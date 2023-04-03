import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_outline_button.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

class CustomAlertView extends GetView {
  const CustomAlertView({
    Key? key,
    required this.title,
    this.positiveText,
    this.negativeText,
    this.onPositiveTap,
    this.onNegativeTap,
  }) : super(key: key);
  final String title;
  final String? positiveText;
  final String? negativeText;
  final VoidCallback? onPositiveTap;
  final VoidCallback? onNegativeTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TitleWidget(
                title: title,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textTitleColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                      child: RoundedRectangleButton(
                          height: 50,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (onPositiveTap == null) {
                              NavigationUtils().goBack();
                            } else {
                              onPositiveTap!();
                            }
                          },
                          text: positiveText ?? 'Yes')),
                  const SizedBox(width: 10),
                  Expanded(
                      child: RoundedOutlineButton(
                          height: 50,
                          onPressed: () {
                            if (onNegativeTap == null) {
                              NavigationUtils().goBack();
                            } else {
                              onNegativeTap!();
                            }
                          },
                          text: negativeText ?? 'No'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}