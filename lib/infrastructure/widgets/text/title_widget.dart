import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.fontWeight,
    this.color,
    this.fontSize,
    this.textAlign,
  });

  final String title;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: color ?? AppColors.labelColor,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}