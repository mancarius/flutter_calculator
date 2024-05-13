import 'package:flutter/material.dart';

class CalcolatriceButton extends StatelessWidget {
  final label;
  final Color bgColor;
  final Function() onPressed;

  const CalcolatriceButton({
    super.key,
    required this.label,
    this.bgColor = Colors.grey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).width / 4 - 8,
      width: MediaQuery.sizeOf(context).width / 4 - 8,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          onPressed: onPressed,
          child: label is Widget
              ? label
              : Text(
                  label,
                  style: const TextStyle(fontSize: 30),
                )),
      )
    );
  }
}
