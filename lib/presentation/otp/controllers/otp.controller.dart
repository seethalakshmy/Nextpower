import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/base/CommonResponse.dart';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/providers/login/login_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/utils/utility.dart';

class OtpController extends GetxController {
  RxString numberToDisplay = "".obs;
  String countryCode = "";
  String mobileNumber = "";
  RxBool isVerify = false.obs;
  RxBool isLoading = false.obs;
  RxBool resendOtpTime = false.obs;
  final formKey = GlobalKey<FormState>();
  final className = "OTP-Screen";

  //dummy variables
  String validOtp = "";
  String otp = "";
  bool isAccountCreated = false;

  @override
  void onInit() {
    super.onInit();
    mobileNumber = Get.parameters[ParamName.mobileNumber] ?? "";
    countryCode = Get.parameters[ParamName.countryCode] ?? "";
    isVerify.value =
        (Get.parameters[ParamName.isVerify] ?? "false").compareTo("true") == 0
            ? true
            : false;
    numberToDisplay.value = "$countryCode $mobileNumber";
    validOtp = Get.parameters['otp'] ?? "";
    if (numberToDisplay.isEmpty) {
      CustomSnackBar.showErrorSnackBar(translate(LocaleKeys.error),
          translate(LocaleKeys.somethingWentWrongPleaseTryAgainLater));
    }
    resendOtpTimer();
  }

  void resendOtpTimer(){
    resendOtpTime(false);
    Future.delayed(const Duration(seconds: 20)).then((value) {
      resendOtpTime(true);
    });
  }

  void resendOTP() {
    isLoading(true);
    resendOtpTimer();
    LoginProvider()
        .login(
        phoneNumber: mobileNumber, countryCode: countryCode)
        .then((value) {
      isLoading(false);
      LoginResponse response = value;
      if (response.status ?? false) {
        validOtp = response.otp ?? "";
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.otp ?? "");
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void validateOtp() {
    isLoading(true);
    LoginProvider()
        .verifyOtp(
        phoneNumber: mobileNumber, countryCode: countryCode,otp: otp)
        .then((value) {
      isLoading(false);
      CommonResponse response = value;
      if (response.status ?? false) {
        moveToNext();
      } else {
        NavigationUtils().callRegistration(
            countryCode,
            mobileNumber);
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  bool validate(){
    if(otp.length == 4){
      return true;
    }
    return false;
  }

  void moveToNext(){
    if (isVerify.value) {
      isLoading(false);
      Get.back(result: true);
    } else if (isAccountCreated) {
      NavigationUtils().callHomePage();
    } else {
      NavigationUtils().callRegistration(
          countryCode,
          mobileNumber);
    }
  }

  void changePhoneNumber() {
    Get.back(closeOverlays: true);
  }
}