import 'package:flutter/material.dart';

class BooleanFilterWidget<T, U> extends StatefulWidget {
  final bool Function(T object)? test;
  final U Function(T object) aquireProperty;
  const BooleanFilterWidget({
    super.key,
    this.test,
    required this.aquireProperty,
  });

  @override
  State<BooleanFilterWidget<T, U>> createState() =>
      _BooleanFilterWidgetState<T, U>();
}

class _BooleanFilterWidgetState<T, U> extends State<BooleanFilterWidget<T, U>> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
