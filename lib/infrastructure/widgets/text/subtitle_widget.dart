import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({
    super.key,
    required this.subtitle,
  });

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(fontSize: 16, color: AppColors.descriptionTextColor),
    );
  }
}