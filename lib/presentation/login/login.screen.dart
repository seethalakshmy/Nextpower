import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/widgets/text/heading_text_widget.dart';

import '../../infrastructure/widgets/text/subtitle_widget.dart';
import 'controllers/login.controller.dart';
import 'widgets/continue_button_widget.dart';
import 'widgets/mobile_number.dart';
import 'widgets/terms_and_conditions_text_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: controller.formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeadingTextWidget(
                  title: LocaleKeys.login.tr,
                ),
                const SizedBox(height: 10),
                SubtitleWidget(
                    subtitle:
                        LocaleKeys.pleaseEnterTheDetailsBelowToContinue.tr),
                const SizedBox(height: 30),
                Text(
                  LocaleKeys.mobileNumber.tr,
                  style: TextStyle(
                      fontSize: 18, color: AppColors.titleLabelTextColor),
                ),
                const SizedBox(height: 15),
                const MobileNumberWidget(),
                const SizedBox(height: 20),
                const ContinueButtonWidget(),
                const SizedBox(height: 10),
                const TermsAndConditionsTextWidget()
              ]),
        ),
      ),
    );
  }
}