import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

import 'title_widget.dart';

class ListTitleWidget extends StatelessWidget {
  const ListTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return TitleWidget(
      title: title,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: AppColors.labelColor2,
    );
  }
}