import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
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
            controller.changePhoneNumber();
          }),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                RoundedRectangleButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.isAccountCreated) {
                          NavigationUtils().callProfile();
                        } else {
                          NavigationUtils().callRegistration(
                              controller.countryCode, controller.mobileNumber);
                        }
                      }
                    },
                    text: translate(LocaleKeys.login)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.resendOTP();
                      },
                      child: Text(
                        translate(LocaleKeys.resendOtp),
                        style: const TextStyle(
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.changePhoneNumber();
                      },
                      child: Text(translate(LocaleKeys.changePhoneNumber),
                          style: const TextStyle(
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}