import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MaskedGifImageAnimatedWidget extends StatefulWidget {
  const MaskedGifImageAnimatedWidget({
    super.key,
    required this.image,
    required this.child,
    required this.blendMode,
    this.forward = true,
    required this.animator,
  });

  final BlendMode blendMode;
  final AssetImage image;
  final Widget child;
  final bool forward;
  final Animation<double> animator;

  @override
  State<MaskedGifImageAnimatedWidget> createState() =>
      _MaskedImageWidgetAnimatedState();
}

class _MaskedImageWidgetAnimatedState
    extends State<MaskedGifImageAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late Future<List<ImageInfo>> images;
  late Animation<int> fractalAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    images = getGifImages().then((value) {
      opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
          .animate(widget.animator)
        ..addListener(() {});
      fractalAnimation =
          IntTween(begin: 0, end: value.length - 1).animate(widget.animator)
            ..addListener(() {
              setState(() {});
            });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageInfo>>(
      future: images,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Opacity(
            opacity: opacityAnimation.value,
            child: ShaderMask(
              blendMode: widget.blendMode,
              shaderCallback: (bounds) => ImageShader(
                snapshot.data![fractalAnimation.value].image,
                TileMode.repeated,
                TileMode.repeated,
                Matrix4.identity().storage,
              ),
              child: widget.child,
            ),
          );
        } else {
          if (widget.forward) {
            return SizedBox.expand();
          } else {
            return widget.child;
          }
        }
      },
    );
  }

  @override
  void dispose() {
    // widget.animator.removeListener(() {});
    super.dispose();
  }

  Future<List<ImageInfo>> getGifImages() async {
    AssetBundleImageKey key =
        await widget.image.obtainKey(const ImageConfiguration());
    final Uint8List bytes =
        (await key.bundle.load(key.name)).buffer.asUint8List();

    ui.Codec codec =
        await PaintingBinding.instance.instantiateImageCodec(bytes);
    List<ImageInfo> infos = [];

    for (int i = 0; i < codec.frameCount; i++) {
      ui.FrameInfo frameInfo = await codec.getNextFrame();
      infos.add(ImageInfo(image: frameInfo.image));
    }
    return infos;
  }
}
