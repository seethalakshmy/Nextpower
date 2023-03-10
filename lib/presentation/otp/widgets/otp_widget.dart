import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/presentation/otp/controllers/otp.controller.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/utils/input_formatter_utils.dart';

class OtpWidget extends GetView<OtpController> {
  OtpWidget({
    super.key,
  });

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.descriptionTextColor.withOpacity(.5)),
      borderRadius: BorderRadius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Pinput(
      defaultPinTheme: defaultPinTheme,
      inputFormatters: InputFormatterUtils().onlyNumber(),
      keyboardType: TextInputType.number,
      closeKeyboardWhenCompleted: true,
      validator: (value) {
        print(value!.length);
        if (value.isEmpty) {
          return translate(LocaleKeys.enterOtp);
        } else if (value.length < 4) {
          print('entered lessthan 4');
          return translate(LocaleKeys.enterValidOtp);
        } else if (value != controller.otp) {
          return translate(LocaleKeys.invalidOtp);
        } else {
          return null;
        }
      },
      focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(5),
      )),
    );
  }
}