import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/file_picker_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

import '../../generated/locales.g.dart';
import '../../infrastructure/utils/print_utils.dart';
import '../../infrastructure/utils/translation_util.dart';
import '../../infrastructure/utils/validation_utils.dart';
import '../../infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import '../../infrastructure/widgets/text_fields/mobile_number_widget.dart';
import '../../infrastructure/widgets/text_fields/name_widget.dart';
import 'controllers/profile.controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: NavigationUtils().goBack,
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.98),
        appBar: CustomAppbar(title: translate(LocaleKeys.profile)),
        body: Obx(() => controller.isLoading.value
            ? const LoadingWidget()
            : Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    _EditIconWidget(controller: controller),
                    _ImageWidget(controller: controller),
                    const SizedBox(height: 30),
                    CustomCardView(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                IgnorePointer(
                                    ignoring: !controller.isEditable.value,
                                    child: _NameWidget(controller: controller)),
                                const SizedBox(height: 10),
                                IgnorePointer(
                                    ignoring: !controller.isEditable.value,
                                    child: _MobileNumberWidget(
                                        controller: controller)),
                                const SizedBox(height: 10),
                                _EmailWidget(controller: controller),
                              ],
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
        style: TextStyle(
            decoration: TextDecoration.underline, color: AppColors.labelColor),
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
          controller.userImagePath.value = file.path;
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
                  : Image.asset(
                      Assets.iconsMenuProfileImage,
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
                icon: SvgImageUtils()
                    .showSvgFromAsset(Assets.iconsEdit, width: 19, height: 19)),
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
    return Obx(() => RoundedRectangleButton(
        isLoading: controller.buttonLoading.value,
        onPressed: () {
          if (controller.isValid()) {
            controller.submit();
          }
        },
        text: translate(LocaleKeys.done)));
  }
}

class _EmailWidget extends StatelessWidget {
  const _EmailWidget({
    required this.controller,
  });

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isEditable.value) {
        return CommonTextFieldWidget(
          initialValue: controller.email.value,
          title: translate(LocaleKeys.emailAddress),
          onChanged: (value) {
            controller.changeEmailID(value);
          },
          validator: (value) => ValidationUtils().emailValidation(value),
          suffix: Obx(() => controller.isEmailVerified.value
              ? SvgImageUtils()
                  .showSvgFromAsset(Assets.iconsTick, width: 24, height: 24)
              : Container()),
        );
      } else {
        return EmailDisabled(controller: controller);
      }
    });
  }
}

class EmailDisabled extends StatelessWidget {
  const EmailDisabled({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: translate(LocaleKeys.emailAddress)),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              if (controller.isEmailVerified.isFalse) {
                controller.emailVerificationResend();
              }
            },
            child: Container(
              height: 48,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 18, right: 3),
              decoration: BoxDecoration(
                color: Colors.transparent,
                // Set your desired color here
                borderRadius: BorderRadius.circular(6),
                // Adjust the radius as needed
                border: Border.all(
                  color: Colors.grey.withOpacity(0.6), // Set border color
                  width: 1, // Set border width
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      controller.email.value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  controller.isApiCalling.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                            strokeWidth: 2,
                          ),
                        )
                      : controller.isEmailVerified.value
                          ? SvgImageUtils().showSvgFromAsset(Assets.iconsTick,
                              width: 24, height: 24)
                          : controller.isEmailVerificationIconEnable.value
                              ? SvgImageUtils()
                                  .showSvgFromAsset(Assets.iconsExclamation)
                              : const SizedBox(),
                ],
              ),
            ),
          ),
        ],
      );
    });
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
          countries: controller.countries.value,
          mobileNumber: controller.phoneNumber.value,
          isEnabled: false,
          // suffix: controller.isMobileVerified.value
          //     ? SvgImageUtils()
          //         .showSvgFromAsset(Assets.iconsTick, width: 24, height: 24)
          //     : GestureDetector(
          //         onTap: () {},
          //         child:
          //             SvgImageUtils().showSvgFromAsset(Assets.iconsExclamation),
          //       ),
          title: translate(LocaleKeys.mobileNumber),
          validator: (value) {
            controller.mobileNumberError.value =
                ValidationUtils().mobileNumberValidation(value) ?? "";
            return null;
          },
          onMobileNumberChanged: (value) {
            controller.phoneNumber.value = value;
          },
          onCountryCodeChanged: (value) {
            PrintUtils().prints(message: "Selected ", value: value);
          },
          errorText: controller.mobileNumberError.value,
          countryCode: controller.countryCode.value,
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
        initialValue: controller.name.value,
        title: translate(LocaleKeys.name),
        onChanged: (value) {
          controller.name.value = value;
        },
        validator: (value) {
          return ValidationUtils().nameValidation(value);
        });
  }
}
