import 'package:flutter/material.dart';

class ArtDecoBorderWidget extends StatelessWidget {
  final Widget child;
  const ArtDecoBorderWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double height = 100;
    final image = Image.asset(
      'assets/border.png',
      filterQuality: FilterQuality.medium,
    );
    return Stack(
      children: [
        Positioned(
          height: height,
          child: image,
        ),
        Positioned(
          top: 0,
          right: 0,
          height: height,
          child: RotatedBox(
            quarterTurns: 1,
            child: image,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          height: height,
          child: RotatedBox(
            quarterTurns: 2,
            child: image,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          height: height,
          child: RotatedBox(
            quarterTurns: 3,
            child: image,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ),
      ],
    );
  }
}
