import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/login/login_model.dart';
import 'package:project/infrastructure/dal/providers/login/login_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/utility.dart';

class LoginController extends GetxController {
  final selectedCountryCode = "".obs;

  String mobileNumber = "";
  RxString mobileNumberError = "".obs;

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  bool isLoginPage = true; //Page reused for change phone number

  @override
  void onInit() {
    isLoginPage = (Get.parameters[ParamName.isLoginPage] ?? "")
                .toString()
                .compareTo("true") ==
            0
        ? true
        : false;
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
    if (mobileNumber.isEmpty) {
      mobileNumberError.value = LocaleKeys.mobileNumberShouldntBeEmpty.tr;
      return;
    }
    callMobileNumberValidateApi();
  }

  void callMobileNumberValidateApi(){
    isLoading(true);
    LoginProvider().login(phoneNumber: mobileNumber).then((value) {
      isLoading(false);
      LoginModel response = value;
      if(response.name != null){
        moveToOtpValidatePage();
        CustomSnackBar.showSuccessSnackBar(LocaleKeys.success.tr,"Otp send");
      }
    });
  }

  void hideErrors(){
    mobileNumberError.value = "";
  }

  void moveToOtpValidatePage(){
    // String otp = Utility.generate4DigitOTP();
    // CustomSnackBar.showSuccessSnackBar("OTP", otp);

    NavigationUtils().callOTPPage(
        countryCode: selectedCountryCode.value,
        mobileNumber: mobileNumber,
        otp: "0000",
        isVerify: false);
  }
}