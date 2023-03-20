import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/file_picker_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';

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
    return WillPopScope(
      onWillPop: NavigationUtils().goBack,
      child: Scaffold(
        appBar: profileAppBar(),
        body: Obx(() => controller.isLoading.value
            ? const LoadingWidget()
            : Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    _EditIconWidget(controller: controller),
                    // controller.isEditable.value
                    //     ? const SizedBox(height: 30)
                    //     : const SizedBox.shrink(),
                    _ImageWidget(controller: controller),
                    const SizedBox(height: 30),
                    CustomCardView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            IgnorePointer(
                              ignoring: !controller.isEditable.value,
                              child: Column(
                                children: [
                                  _NameWidget(controller: controller),
                                  const SizedBox(height: 10),
                                  _MobileNumberWidget(controller: controller),
                                  const SizedBox(height: 10),
                                  _EmailWidget(controller: controller),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Obx(() => controller.isEditable.value
                                ? _DoneButtonWidget(controller: controller)
                                : _ChangePhoneNumberWidget(
                                    controller: controller))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
      ),
    );
  }

  CustomAppbar profileAppBar() {
    return CustomAppbar(
      title: translate(LocaleKeys.profile),
    );
  }
}

class _ChangePhoneNumberWidget extends StatelessWidget {
  const _ChangePhoneNumberWidget({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        controller.gotoLogin();
      },
      child: Text(
        translate(LocaleKeys.changePhoneNumber),
        style: const TextStyle(
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () async {
        File? file = await FilePickerUtils.pickImage();
        if (file != null) {
          controller.userImagePath.value = file.path ?? "";
        }
      },
      child: Stack(children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.black,
          child: ClipOval(
            child: SizedBox(
              width: 180.0,
              height: 180.0,
              child: Obx(() => controller.userImagePath.isNotEmpty
                  ? Image.file(
                      File(controller.userImagePath.value),
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      controller.currentProfileData.value.userImage ?? "",
                      fit: BoxFit.fill,
                    )),
            ),
          ),
        ),
        Obx(() => controller.isEditable.value
            ? Positioned(
                bottom: -5,
                right: -5,
                child: ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    // color: Colors.blue.withOpacity(0.8),
                    child: SvgImageUtils()
                        .showSvgFromAsset(Assets.iconsCameraIcon),
                  ),
                ),
              )
            : const SizedBox.shrink()),
      ]),
    ));
  }
}

class _EditIconWidget extends StatelessWidget {
  const _EditIconWidget({
    super.key,
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
          visible: !controller.isEditable.value,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  controller.setProfileEditable();
                },
                icon: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit)),
          ),
        ));
  }
}

class _DoneButtonWidget extends StatelessWidget {
  const _DoneButtonWidget({
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return RoundedRectangleButton(
        onPressed: () {
          var validate = controller.formKey.currentState!.validate();
          print("button pressed: $validate");
          if (controller.isValid(validate)) {
            CustomSnackBar.showErrorSnackBar(translate(LocaleKeys.error),
                translate(LocaleKeys.kindlyValidateAllFieldsAndTryAgain));
          } else {
            controller.submit();
          }
        },
        text: translate(LocaleKeys.done));
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget({
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => CommonTextFieldWidget(
          initialValue: controller.currentProfileData.value.emailId,
          title: translate(LocaleKeys.emailAddress),
          onNameChanged: (value) {
            controller.changeEmailID(value);
          },
          validator: (value) => ValidationUtils().emailValidation(value),
          suffix: Obx(() => controller.isEmailVerified.value
              ? SvgImageUtils().showSvgFromAsset(Assets.iconsTick)
              : GestureDetector(
                  onTap: () {
                    controller.validateEmailID();
                  },
                  child:
                      SvgImageUtils().showSvgFromAsset(Assets.iconsExclamation),
                )),
        ));
  }
}

class _MobileNumberWidget extends StatelessWidget {
  const _MobileNumberWidget({
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => MobileNumberWidget(
          mobileNumber: controller.currentProfileData.value.mobileNumber ?? "",
          isEnabled: false,
          suffix: controller.isMobileVerified.value
              ? SvgImageUtils().showSvgFromAsset(Assets.iconsTick)
              : GestureDetector(
                  onTap: () {},
                  child:
                      SvgImageUtils().showSvgFromAsset(Assets.iconsExclamation),
                ),
          title: translate(LocaleKeys.mobileNumber),
          validator: (value) {
            controller.mobileNumberError.value =
                ValidationUtils().mobileNumberValidation(value) ?? "";
            return null;
          },
          onMobileNumberChanged: (value) {
            controller.currentProfileData.update((val) {
              val?.mobileNumber = value;
            });
          },
          onCountryCodeChanged: (value) {
            PrintUtils().prints(message: "Selected ", value: value);
            controller.setCountryCode(value);
          },
          errorText: controller.mobileNumberError.value,
          countryCode: controller.currentProfileData.value.countryCode ?? "",
        ));
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return CommonTextFieldWidget(
        initialValue: controller.currentProfileData.value.userName,
        title: translate(LocaleKeys.name),
        onNameChanged: (value) {
          controller.currentProfileData.update((val) {
            val?.userName = value ?? "";
          });
        },
        validator: (value) {
          return ValidationUtils().nameValidation(value);
        });
  }
}