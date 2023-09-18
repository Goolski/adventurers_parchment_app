import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MaskedGifImageWidget extends StatefulWidget {
  const MaskedGifImageWidget({
    super.key,
    required this.image,
    required this.child,
    required this.blendMode,
  });

  final BlendMode blendMode;
  final AssetImage image;
  final Widget child;

  @override
  State<MaskedGifImageWidget> createState() => _MaskedImageWidgetState();
}

class _MaskedImageWidgetState extends State<MaskedGifImageWidget> {
  ImageInfo? currentImage = null;

  @override
  void initState() {
    super.initState();
    getGifImages().then(
      (value) => GifStream(
        fps: 30,
        gifImages: value,
      ).stream.listen(
        (event) {
          setState(
            () {
              currentImage = event;
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentImage != null) {
      return ShaderMask(
        blendMode: widget.blendMode,
        shaderCallback: (bounds) => ImageShader(
          currentImage!.image,
          TileMode.repeated,
          TileMode.repeated,
          Matrix4.identity().storage,
        ),
        child: widget.child,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<ImageInfo>> getGifImages() async {
    AssetBundleImageKey key =
        await widget.image.obtainKey(const ImageConfiguration());
    final Uint8List bytes =
        (await key.bundle.load(key.name)).buffer.asUint8List();

    ui.Codec codec =
        await PaintingBinding.instance!.instantiateImageCodec(bytes);
    List<ImageInfo> infos = [];
    Duration duration = Duration();

    for (int i = 0; i < codec.frameCount; i++) {
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      infos.add(ImageInfo(image: frameInfo.image));
      duration += frameInfo.duration;
    }
    return infos;
  }
}

class GifStream {
  final List<ImageInfo> gifImages;
  final int fps;
  final StreamController<ImageInfo> _controller = StreamController();

  GifStream({
    required this.gifImages,
    required this.fps,
  }) {
    init();
  }

  void init() {
    for (var i = 0; i < 30; i++) {
      Future.delayed(
        Duration(milliseconds: 100),
        () => _controller.add(gifImages[i]),
      );
    }
  }

  Stream<ImageInfo> get stream => _controller.stream;
}
