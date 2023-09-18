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
    Future.delayed(
      Duration(milliseconds: 500),
      () => widgetKey.currentState?.goForward(),
    );
    final widget = Scaffold(
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
    return widget;
  }

  void goTo(BuildContext context, String path) async {
    widgetKey.currentState?.goBackwards().then(
          (value) => context.go(path),
        );
    // context.go(path);
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
