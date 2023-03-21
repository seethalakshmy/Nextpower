import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class RoundedOutlineButton extends StatelessWidget {
  const RoundedOutlineButton({
    super.key,
    required this.onPressed,
    this.borderRadius = 30.0,
    required this.text,
    this.isLoading = false,
    this.loaderSize = 18,
  });

  final VoidCallback onPressed;
  final double borderRadius;
  final String text;
  final bool isLoading;
  final double loaderSize;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primaryBlue),
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: loaderSize,
                width: loaderSize,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(text));
  }
}