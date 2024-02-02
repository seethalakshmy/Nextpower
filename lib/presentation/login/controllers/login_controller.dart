import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/providers/change_mobile_number/change_mobile_provider.dart';
import 'package:project/infrastructure/dal/providers/login/login_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';

class LoginController extends GetxController {
  final selectedCountryCode = "".obs;

  String mobileNumber = "";
  RxString mobileNumberError = "".obs;

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool countriesLoading = false.obs;
  RxList<Country> countries = RxList.empty(growable: true);
  bool isLoginPage = true; //Page reused for change phone number

  @override
  void onInit() {
    isLoginPage = (Get.parameters[ParamName.isLoginPage] ?? "")
                .toString()
                .compareTo("true") ==
            0
        ? true
        : false;
    getCountries();

    super.onInit();
  }

  void getCountries() {
    countriesLoading(true);
    LoginProvider().getCountries().then((response) {
      countriesLoading(false);
      if (response.status ?? false) {
        countries.value = response.countries ?? [];
        selectedCountryCode.value =
            "${countries.value.first.countryCode ?? 91}";
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
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
    if(isLoginPage){
      callMobileNumberValidateApi();
    }else{
      callChangeMobileNumberApi();
    }

  }

  void callMobileNumberValidateApi() {
    isLoading(true);
    LoginProvider()
        .login(
            phoneNumber: mobileNumber, countryCode: selectedCountryCode.value)
        .then((value) {
      isLoading(false);
      LoginResponse response = value;
      if (response.status ?? false) {
        moveToOtpValidatePage(response.otp ?? "");
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.otp ?? "");
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void callChangeMobileNumberApi() {
    isLoading(true);
    ChangeMobileNumberProvider()
        .changePhoneNumber(
        phoneNumber: mobileNumber, countryCode: selectedCountryCode.value)
        .then((value) {
      isLoading(false);
      LoginResponse response = value;
      if (response.status ?? false) {
        moveToOtpValidatePage(response.otp ?? "");
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.otp ?? "");
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void hideErrors() {
    mobileNumberError.value = "";
  }

  void moveToOtpValidatePage(String otp) {
    NavigationUtils().callOTPPage(
        countryCode: selectedCountryCode.value,
        mobileNumber: mobileNumber,
        otp: otp,
        clearBackStack: !isLoginPage,
        isVerify: !isLoginPage);
  }
}
