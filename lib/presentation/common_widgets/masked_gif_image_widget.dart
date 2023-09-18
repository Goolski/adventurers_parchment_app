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

class _MaskedImageWidgetState extends State<MaskedGifImageWidget>
    with SingleTickerProviderStateMixin {
  late Future<List<ImageInfo>> images;
  late AnimationController animController;
  late Animation<int> animation;

  @override
  void initState() {
    super.initState();

    animController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    images = getGifImages().then((value) {
      animation =
          IntTween(begin: 0, end: value.length - 1).animate(animController)
            ..addListener(() {
              setState(() {});
            });
      animController.forward();
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageInfo>>(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ShaderMask(
            blendMode: widget.blendMode,
            shaderCallback: (bounds) => ImageShader(
              snapshot.data![animation.value].image,
              TileMode.repeated,
              TileMode.repeated,
              Matrix4.identity().storage,
            ),
            child: widget.child,
          );
        } else {
          return SizedBox.expand();
        }
      },
    );
  }

  @override
  void dispose() {
    animController.dispose();
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

    for (int i = 0; i < codec.frameCount; i++) {
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      infos.add(ImageInfo(image: frameInfo.image));
    }
    return infos;
  }
}
