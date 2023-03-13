import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/print_utils.dart';

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

  gotoNextPage() {
    printData(message: "Mobile number:", value: mobileNumber);
    isLoading(true);
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      formKey.currentState!.validate();
      isLoading(false);
    });
  }
}