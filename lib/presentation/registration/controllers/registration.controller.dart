import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/base/CommonResponse.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'package:project/infrastructure/dal/providers/registration/registration_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/storage/app_storage.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/validation_utils.dart';
import 'package:project/presentation/registration/models/registration_model.dart';

class RegistrationController extends GetxController {

  final registrationModel = RegistrationModel().obs;
  final formKey = GlobalKey<FormState>();
  RxList<Country> countries = RxList.empty(growable: true);
  RxBool isLoading = false.obs;
  late String mobileNumber;
  late String countryCode;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxString emailError = "".obs;
  RxBool buttonEnabled = false.obs;

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

  bool validate(){
    emailError.value = ValidationUtils().emailValidation(emailController.text.trim()) ?? "";
    buttonEnabled(false);
    if(nameController.text.trim().isEmpty){
      return false;
    }
    if(emailController.text.trim().isEmpty){
      return false;
    }
    if(emailError.value.isNotEmpty){
      return false;
    }
    buttonEnabled(true);
    return true;
  }

  void registration() {
    isLoading(true);
    RegistrationProvider()
        .registration(
        email: emailController.text.trim(), name: nameController.text.trim())
        .then((value) {
      isLoading(false);
      CommonResponse response = value;
      if (response.status ?? false) {
        AppStorage().writeIsLoggedIn(true);
        NavigationUtils().callHomePage(clearStack: true);
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }



}