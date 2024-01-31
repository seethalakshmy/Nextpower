import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/utils/validation_utils.dart';
import 'package:project/infrastructure/widgets/buttons/back_button.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/text/heading_text_widget.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/infrastructure/widgets/text_fields/mobile_number_widget.dart';
import 'package:project/infrastructure/widgets/text_fields/name_widget.dart';

import 'controllers/registration.controller.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const BackButtonAppbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              const SizedBox(height: 50),
              HeadingTextWidget(title: translate(LocaleKeys.createAnAccount)),
              const SizedBox(height: 10),
              SubtitleWidget(
                  subtitle: translate(LocaleKeys
                      .pleaseEnterTheFollowingDetailsToCreateAnAccount)),
              const SizedBox(height: 10),
              CommonTextFieldWidget(
                  title: translate(LocaleKeys.name),
                  onChanged: (value) {},
                  validator: (value) {
                    return ValidationUtils().nameValidation(value);
                  }),
              const SizedBox(height: 10),
              Obx(() => MobileNumberWidget(
                countries: controller.countries.value,
                    mobileNumber: controller.mobileNumber,
                    isEnabled: false,
                    title: translate(LocaleKeys.mobileNumber),
                    validator: (value) {
                      controller.registrationModel.update((val) {
                        val?.mobileNumberError =
                            ValidationUtils().mobileNumberValidation(value) ??
                                "";
                      });

                      return null;
                    },
                    onMobileNumberChanged: (value) {
                      controller.registrationModel.update((val) {
                        val?.mobileNumber = value;
                      });
                    },
                    onCountryCodeChanged: (value) {
                      PrintUtils().prints(message: "Selected ", value: value);
                      controller.setCountryCode(value);
                    },
                    errorText:
                        controller.registrationModel.value.mobileNumberError,
                    countryCode:
                        controller.registrationModel.value.countryCode ?? "",
                  )),
              const SizedBox(height: 10),
              CommonTextFieldWidget(
                title: translate(LocaleKeys.emailAddress),
                onChanged: (value) {},
                validator: (value) => ValidationUtils().emailValidation(value),
              ),
              const SizedBox(height: 30),
              RoundedRectangleButton(
                  onPressed: () {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      NavigationUtils().callHomePage(clearStack: true);
                    }
                  },
                  text: translate(LocaleKeys.submit))
            ],
          ),
        ),
      ),
    );
  }
}