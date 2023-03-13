import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class TermsAndConditionsTextWidget extends StatelessWidget {
  const TermsAndConditionsTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "${LocaleKeys.byContinuingYouAgreeToOur.tr} ",
        style: TextStyle(color: AppColors.titleLabelTextColor),
        children: [
          TextSpan(
              text: LocaleKeys.termsAndConditions.tr,
              style: TextStyle(color: AppColors.labelGreenTextColor)),
          const TextSpan(text: ". "),
          TextSpan(
              text: LocaleKeys.privacyPolicy.tr,
              style: TextStyle(color: AppColors.labelGreenTextColor))
        ],
      ),
    );
  }
}