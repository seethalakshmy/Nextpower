import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/utils/validation_utils.dart';
import 'package:project/infrastructure/widgets/buttons/back_button.dart';
import 'package:project/infrastructure/widgets/text/heading_text_widget.dart';

import '../../infrastructure/widgets/text_fields/mobile_number_widget.dart';
import 'controllers/login_controller.dart';
import 'widgets/continue_button_widget.dart';
import 'widgets/terms_and_conditions_text_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PopScope(
        onPopInvoked: (value) {
          controller.count++;
          if (controller.count.value > 1) {
            controller.canPop.value = true;
          }
          if (controller.count.value == 1) {
            Get.snackbar(
              "",
              "",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.transparent,
              colorText: Colors.black,
              messageText: const Text(
                "Press Again To Exit",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
        canPop: controller.canPop.value,
        child: Scaffold(
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
                    Obx(() => MobileNumberWidget(
                          countryLoading: controller.countriesLoading.value,
                          validator: (value) {
                            controller.mobileNumberError(ValidationUtils()
                                    .mobileNumberEmptyValidation(value) ??
                                "");
                            return null;
                          },
                          countries: controller.countries.value,
                          onMobileNumberChanged: (value) {
                            controller.mobileNumber = value;
                            controller.hideErrors();
                          },
                          onCountryCodeChanged: (value) {
                            PrintUtils()
                                .prints(message: "Selected ", value: value);
                            controller.selectedCountryCode.value = value;
                          },
                          errorText: controller.mobileNumberError.value,
                          countryCode: controller.selectedCountryCode.value,
                          title: translate(LocaleKeys.mobileNumber.tr),
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
        ),
      );
    });
  }
}
