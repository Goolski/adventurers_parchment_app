import 'package:flutter/material.dart';

import '../common_widgets/masked_widgets/masked_gif_image_widget.dart';

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
    final widget = Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MainBackgroundWidget(key: key),
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
    return widget;
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
