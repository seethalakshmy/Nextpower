import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.subtitle,
    this.fontWeight,
    this.textColor,
    this.fontSize,
  });

  final String subtitle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
          fontSize: fontSize ?? 14,
          color: textColor ?? AppColors.labelTextColor3,
          fontWeight: fontWeight,
          height: 1.5),
    );
  }
}