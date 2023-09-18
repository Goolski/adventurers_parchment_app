import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common_widgets/masked_gif_image_widget.dart';

class MainScaffold extends StatelessWidget {
  MainScaffold({
    super.key,
    required this.child,
  });

  final Widget child;
  final GlobalKey<MaskedGifImageWidgetState> widgetKey =
      GlobalKey<MaskedGifImageWidgetState>();

  @override
  Widget build(BuildContext context) {
    widgetKey.currentState?.goBackwards();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MainBackgroundWidget(key: key),
          SafeArea(
            child: MaskedGifImageWidget(
              blendMode: BlendMode.dstIn,
              image: AssetImage('assets/noise.gif'),
              child: child,
              key: widgetKey,
            ),
          ),
        ],
      ),
    );
  }

  void goTo(BuildContext context, String path) {
    widgetKey.currentState?.goBackwards();
    context.go(path);
    widgetKey.currentState?.goBackwards();
  }
}

class MainBackgroundWidget extends StatelessWidget {
  const MainBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/paper.jpg',
      fit: BoxFit.cover,
    );
  }
}
