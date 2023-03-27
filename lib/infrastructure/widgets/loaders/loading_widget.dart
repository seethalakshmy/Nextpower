import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size,
    this.strokeWidth,
  });

  final double? size;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: size ?? 20,
      width: size ?? 20,
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: strokeWidth ?? 1,
      ),
    ));
  }
}