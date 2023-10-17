import 'package:flutter/material.dart';

class SelectableWidgetButton extends StatelessWidget {
  const SelectableWidgetButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isSelected = false,
  });

  final String text;
  final Function() onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 32),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? Color(0x55000000) : Colors.transparent,
            border: Border.all(),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
