import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/utility.dart';

class LoginController extends GetxController {
  final selectedCountryCode = "".obs;

  String mobileNumber = "";
  RxString mobileNumberError = "".obs;

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    setCountryCode();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  setCountryCode([String? value]) {
    selectedCountryCode(value ?? AppConstants().countryCodeList.first);
    update();
  }

  printData({required String message, required String value, int? lineNumber}) {
    PrintUtils().prints(
        message: message,
        value: value,
        className: "LoginController",
        lineNumber: lineNumber);
  }

  gotoNextPage() async {
    printData(message: "Mobile number:", value: mobileNumber);
    isLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    formKey.currentState!.validate();
    if (mobileNumberError.value.isEmpty) {
      String otp = Utility.generate4DigitOTP();
      CustomSnackBar.showSuccessSnackBar("OTP", otp);
      NavigationUtils().callOTPPage(
          countryCode: selectedCountryCode.value,
          mobileNumber: mobileNumber,
          otp: otp,
          isVerify: false);
      isLoading(false);
    } else {
      isLoading(false);
    }
  }
}