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
    this.forward = true,
  });

  final BlendMode blendMode;
  final AssetImage image;
  final Widget child;
  final bool forward;

  @override
  State<MaskedGifImageWidget> createState() => _MaskedImageWidgetState();
}

class _MaskedImageWidgetState extends State<MaskedGifImageWidget>
    with SingleTickerProviderStateMixin {
  late Future<List<ImageInfo>> images;
  late AnimationController animController;
  late Animation<int> fractalAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    animController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      lowerBound: 0,
      upperBound: 1.0,
    );

    images = getGifImages().then((value) {
      opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
          .animate(animController)
        ..addListener(() {});
      fractalAnimation =
          IntTween(begin: 0, end: value.length - 1).animate(animController)
            ..addListener(() {
              setState(() {});
            });
      if (widget.forward) {
        animController.forward();
      } else {
        animController.reverse(from: animController.upperBound);
      }
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
    animController.dispose();
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
