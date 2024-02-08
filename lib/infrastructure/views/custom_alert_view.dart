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
    this.positiveButtonRightAlign = false,
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
  final bool positiveButtonRightAlign;

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
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textTitleColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                      child: positiveButtonRightAlign
                          ? noButton(onNegativeTap)
                          : yesButton(onPositiveTap)),
                  const SizedBox(width: 10),
                  Expanded(
                      child: positiveButtonRightAlign
                          ? yesButton(onPositiveTap)
                          : noButton(onNegativeTap))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget noButton(Function? onclick) {
    return RoundedOutlineButton(
        height: 45,
        onPressed: () {
          if (onclick != null) {
            onclick();
          } else {
            NavigationUtils().goBack();
          }
        },
        text: negativeText ?? 'No');
  }

  Widget yesButton(Function? onclick) {
    return RoundedRectangleButton(
        height: 45,
        padding: EdgeInsets.zero,
        onPressed: () {
          if (onclick != null) {
            onclick();
          } else {
            NavigationUtils().goBack();
          }
        },
        text: positiveText ?? 'Yes');
  }
}
