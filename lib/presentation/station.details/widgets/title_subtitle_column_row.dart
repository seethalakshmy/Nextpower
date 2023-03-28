import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';

class TitleSubtitleColumnRowWidget extends StatelessWidget {
  const TitleSubtitleColumnRowWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.showAsColumn,
  });

  final String title;
  final String subtitle;
  final bool showAsColumn;

  @override
  Widget build(BuildContext context) {
    List<Widget> childList = [
      SubtitleWidget(
        subtitle: title,
        fontSize: 16,
        textColor: AppColors.iconColor,
      ),
      const SizedBox(width: 10),
      SubtitleWidget(
        subtitle: subtitle,
        textColor: AppColors.btmTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ];
    return showAsColumn
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childList,
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: childList,
          );
  }
}