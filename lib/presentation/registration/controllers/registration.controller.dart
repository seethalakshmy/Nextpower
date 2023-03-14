import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/presentation/registration/models/registration_model.dart';

class RegistrationController extends GetxController {
  //TODO: Implement RegistrationController

  final count = 0.obs;
  final registrationModel = RegistrationModel().obs;
  final formKey = GlobalKey<FormState>();
  late String mobileNumber;
  late String countryCode;

  @override
  void onInit() {
    mobileNumber = Get.parameters[ParamName.mobileNumber] ?? "";
    countryCode = Get.parameters[ParamName.countryCode] ?? "";
    setCountryCode(countryCode);
    super.onInit();
  }

  setCountryCode([String? value]) {
    registrationModel.value.countryCode =
        value ?? AppConstants().countryCodeList.first;
    print(jsonEncode(registrationModel));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}