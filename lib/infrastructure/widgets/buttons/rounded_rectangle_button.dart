import 'package:flutter/material.dart';

class RoundedRectangleButton extends StatelessWidget {
  const RoundedRectangleButton({
    super.key,
    required this.onPressed,
    this.borderRadius = 30.0,
    required this.text,
  });

  final VoidCallback onPressed;
  final double borderRadius;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 15),
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),),
        child: Text(text));
  }
}