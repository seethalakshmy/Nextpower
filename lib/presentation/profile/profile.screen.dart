import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/widgets/buttons/back_button.dart';

import '../../generated/locales.g.dart';
import '../../infrastructure/utils/print_utils.dart';
import '../../infrastructure/utils/translation_util.dart';
import '../../infrastructure/utils/validation_utils.dart';
import '../../infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import '../../infrastructure/widgets/text_fields/mobile_number_widget.dart';
import '../../infrastructure/widgets/text_fields/name_widget.dart';
import 'controllers/profile.controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: BackButtonAppbar(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: Colors.green,
              ))
        ],
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: Text(
                'ProfileScreen is working',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView(
              children: [
                const SizedBox(height: 30),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    controller.profile.value.userImage ?? "",
                  ),
                  radius: 50,
                ),
                const SizedBox(height: 30),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  elevation: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        NameWidget(
                            title: translate(LocaleKeys.name),
                            onNameChanged: (value) {},
                            validator: (value) {
                              return ValidationUtils().nameValidation(value);
                            }),
                        const SizedBox(height: 10),
                        Obx(() => MobileNumberWidget(
                              mobileNumber:
                                  controller.profile.value.mobileNumber ?? "",
                              isEnabled: false,
                              title: translate(LocaleKeys.mobileNumber),
                              validator: (value) {
                                controller.profile.update((val) {
                                  // val?.mobileNumberError = ValidationUtils()
                                  //         .mobileNumberValidation(value) ??
                                  //     "";
                                });

                                return null;
                              },
                              onMobileNumberChanged: (value) {
                                controller.profile.update((val) {
                                  val?.mobileNumber = value;
                                });
                              },
                              onCountryCodeChanged: (value) {
                                PrintUtils()
                                    .prints(message: "Selected ", value: value);
                                controller.setCountryCode(value);
                              },
                              errorText:
                                  "controller.profile.value.mobileNumberError",
                              countryCode:
                                  controller.profile.value.countryCode ?? "",
                            )),
                        const SizedBox(height: 10),
                        NameWidget(
                          title: 'Email address',
                          onNameChanged: (value) {},
                          validator: (value) =>
                              ValidationUtils().emailValidation(value),
                        ),
                        const SizedBox(height: 30),
                        RoundedRectangleButton(
                            onPressed: () {
                              controller.formKey.currentState?.validate();
                            },
                            text: 'Done')
                      ],
                    ),
                  ),
                )
              ],
            )),
    );
  }
}