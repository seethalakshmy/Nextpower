import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.subtitle,
    this.fontWeight,
    this.textColor,
  });

  final String subtitle;
  final FontWeight? fontWeight;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
          fontSize: 16,
          color: textColor ?? AppColors.descriptionTextColor,
          fontWeight: fontWeight),
    );
  }
}