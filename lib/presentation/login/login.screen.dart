import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/utils/validation_utils.dart';
import 'package:project/infrastructure/widgets/buttons/back_button.dart';
import 'package:project/infrastructure/widgets/text/heading_text_widget.dart';

import '../../infrastructure/widgets/text_fields/mobile_number_widget.dart';
import 'controllers/login.controller.dart';
import 'widgets/continue_button_widget.dart';
import 'widgets/terms_and_conditions_text_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: !controller.isLoginPage ? const BackButtonAppbar() : null,
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
                  title: controller.isLoginPage
                      ? "${translate(LocaleKeys.login)} / ${translate(LocaleKeys.signup)}"
                      : translate(LocaleKeys.changePhoneNumber),
                ),
                const SizedBox(height: 15),
                // SubtitleWidget(
                //     subtitle: controller.isLoginPage
                //         ? translate(
                //             LocaleKeys.pleaseEnterTheDetailsBelowToContinue)
                //         : translate(LocaleKeys.pleaseEnterTheNumberToChange)),
                // const SizedBox(height: 30),
                Obx(() => MobileNumberWidget(
                      validator: (value) {
                        controller.mobileNumberError(ValidationUtils()
                                .mobileNumberEmptyValidation(value) ??
                            "");
                        return null;
                      },
                      onMobileNumberChanged: (value) {
                        controller.mobileNumber = value;
                      },
                      onCountryCodeChanged: (value) {
                        PrintUtils().prints(message: "Selected ", value: value);
                        controller.setCountryCode(value);
                      },
                      errorText: controller.mobileNumberError.value,
                      countryCode: controller.selectedCountryCode.value,
                      title: translate(LocaleKeys.mobileNumber),
                    )),
                const SizedBox(height: 20),
                const ContinueButtonWidget(),
                const SizedBox(height: 30),
                controller.isLoginPage
                    ? const TermsAndConditionsTextWidget()
                    : const SizedBox.shrink()
              ]),
        ),
      ),
    );
  }
}