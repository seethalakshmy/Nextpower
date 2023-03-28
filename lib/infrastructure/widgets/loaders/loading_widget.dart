import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size,
    this.strokeWidth,
    this.strokeColor,
  });

  final double? size;
  final double? strokeWidth;
  final Color? strokeColor;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: size ?? 20,
      width: size ?? 20,
      child: CircularProgressIndicator(
        color: strokeColor ?? AppColors.primaryBlue,
        strokeWidth: strokeWidth ?? 1,
      ),
    ));
  }
}