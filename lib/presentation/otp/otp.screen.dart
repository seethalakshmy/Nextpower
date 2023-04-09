import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/widgets/buttons/back_button.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';

import '../../infrastructure/utils/translation_util.dart';
import '../../infrastructure/widgets/text/heading_text_widget.dart';
import 'controllers/otp.controller.dart';
import 'widgets/otp_widget.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: BackButtonAppbar(onBackPressed: () {
            if (controller.isVerify.value) {
              Get.back(result: false);
            } else {
              controller.changePhoneNumber();
            }
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Obx(() => IgnorePointer(
                ignoring: controller.isLoading.value,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HeadingTextWidget(
                        title: translate(LocaleKeys.enterOtp),
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        return SubtitleWidget(
                            subtitle:
                                "${translate(LocaleKeys.enterOtpSentTo)} ${controller.numberToDisplay.value}");
                      }),
                      const SizedBox(height: 30),
                      OtpWidget(),
                      const SizedBox(height: 20),
                      Obx(() => RoundedRectangleButton(
                          onPressed: () async {
                            controller.isLoading(true);
                            if (controller.formKey.currentState!.validate()) {
                              await Future.delayed(const Duration(seconds: 2));
                              controller.isLoading(false);
                              if (controller.isVerify.value) {
                                controller.isLoading(false);
                                Get.back(result: true);
                              } else if (controller.isAccountCreated) {
                                NavigationUtils().callHomePage();
                              } else {
                                NavigationUtils().callRegistration(
                                    controller.countryCode,
                                    controller.mobileNumber);
                              }
                            } else {
                              controller.isLoading(false);
                            }
                          },
                          isLoading: controller.isLoading.value,
                          text: controller.isVerify.value
                              ? translate(LocaleKeys.verify)
                              : translate(LocaleKeys.login))),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _TextButtons(
                              onPressed: () {
                                controller.resendOTP();
                              },
                              text: LocaleKeys.resendOtp),
                          _TextButtons(
                              onPressed: () {
                                controller.changePhoneNumber();
                              },
                              text: LocaleKeys.changePhoneNumber),
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}

class _TextButtons extends StatelessWidget {
  const _TextButtons({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        translate(text),
        style: TextStyle(
            color: AppColors.labelColor,
            decoration: TextDecoration.underline,
            fontSize: 14),
      ),
    );
  }
}