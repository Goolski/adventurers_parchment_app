import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MainBackgroundWidget(),
          SafeArea(child: child),
        ],
      ),
    );
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
