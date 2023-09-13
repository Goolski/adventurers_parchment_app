import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MaskedImageWidget extends StatelessWidget {
  const MaskedImageWidget({
    super.key,
    required this.image,
    required this.child,
    required this.blendMode,
  });

  final BlendMode blendMode;
  final ImageProvider image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ShaderMask(
            blendMode: blendMode,
            shaderCallback: (bounds) => ImageShader(
              snapshot.data!,
              TileMode.repeated,
              TileMode.repeated,
              Matrix4.identity().storage,
            ),
            child: child,
          );
        } else {
          return child;
        }
      },
    );
  }

  Future<ui.Image> getImage() async {
    final completer = Completer<ui.Image>();
    final stream = image.resolve(ImageConfiguration());
    stream.addListener(
      ImageStreamListener(
        (image, _) {
          completer.complete(image.image);
        },
      ),
    );
    return completer.future;
  }
}
