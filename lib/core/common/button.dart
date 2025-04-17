import 'package:flutter/material.dart';
import 'package:vokitoki/core/constants/constants.dart';
import 'package:vokitoki/main.dart';

class FillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const FillButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * 0.07,
        width: width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: ButtonColor.first),
          boxShadow: [BoxShadow(spreadRadius: 1, color: ButtonColor.shadow)],
          borderRadius: BorderRadius.circular(width * 0.3),
          gradient: LinearGradient(
            colors: [ButtonColor.third, ButtonColor.first],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class NotFillB extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const NotFillB({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * 0.07,
        width: width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: ButtonColor.first, width: 2),
          borderRadius: BorderRadius.circular(width * 0.3),
          color: Colors.transparent, // No fill
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
              color: ButtonColor.first,
            ),
          ),
        ),
      ),
    );
  }
}
