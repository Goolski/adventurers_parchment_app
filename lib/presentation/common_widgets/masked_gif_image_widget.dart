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
  final ImageProvider image;
  final Widget child;

  @override
  State<MaskedGifImageWidget> createState() => _MaskedImageWidgetState();
}

class _MaskedImageWidgetState extends State<MaskedGifImageWidget> {
  late ui.Image currentImage;
  bool imageLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, _) {
          setState(
            () {
              imageLoaded = true;
              currentImage = info.image;
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imageLoaded) {
      return ShaderMask(
        blendMode: widget.blendMode,
        shaderCallback: (bounds) => ImageShader(
          currentImage,
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
    widget.image.evict();
  }
}
