import 'package:flutter/material.dart';

class ThreeStateButtonWidget extends StatefulWidget {
  const ThreeStateButtonWidget({
    super.key,
    required this.onStateChanged,
    required this.text,
  });

  final String text;
  final Function(bool? currentState) onStateChanged;

  @override
  State<ThreeStateButtonWidget> createState() => _SelectableWidgetButtonState();
}

class _SelectableWidgetButtonState extends State<ThreeStateButtonWidget> {
  bool? currentState;

  @override
  void initState() {
    super.initState();
    currentState = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final nextState = getNextState(currentState);
        widget.onStateChanged(nextState);
        setState(() {
          currentState = nextState;
        });
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 32),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: currentColor(currentState),
            border: Border.all(),
          ),
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Color currentColor(bool? currentState) {
    if (currentState == null) return Colors.transparent;
    if (currentState == true) return const Color(0x55000000);
    return const Color.fromARGB(50, 255, 0, 0);
  }

  bool? getNextState(bool? currentState) {
    if (currentState == null) return true;
    if (currentState == true) return false;
    return null;
  }
}
