import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.fontWeight,
  });

  final String title;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18,
          color: AppColors.titleLabelTextColor,
          fontWeight: fontWeight),
    );
  }
}