import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

class TermsAndConditionsTextWidget extends StatelessWidget {
  const TermsAndConditionsTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "${translate(LocaleKeys.byContinuingYouAgreeToOur)} ",
        style: TextStyle(color: AppColors.labelTextColor3, height: 1.5),
        children: [
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('tapped');
                  CustomSnackBar.showErrorSnackBar('Not yet done', "");
                },
              text: translate(LocaleKeys.termsAndConditions),
              style: TextStyle(color: AppColors.primaryGreen)),
          const TextSpan(text: ". "),
          TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('tapped');
                  CustomSnackBar.showErrorSnackBar('Not yet done', "");
                },
              text: translate(LocaleKeys.privacyPolicy),
              style: TextStyle(color: AppColors.primaryGreen))
        ],
      ),
    );
  }
}