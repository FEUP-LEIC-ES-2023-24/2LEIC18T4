import 'package:flutter/material.dart';

class ScreensButton extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final Color buttonColor;

  final Function()? onTap;

  const ScreensButton(
      {super.key,
      required this.buttonText,
      required this.textColor,
      required this.buttonColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(buttonText,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          )),
    );
  }
}
