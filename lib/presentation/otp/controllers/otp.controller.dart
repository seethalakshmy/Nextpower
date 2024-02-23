import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/models/validate_otp/VerifyOtpResponse.dart';
import 'package:project/infrastructure/dal/providers/login/login_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/storage/app_storage.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/presentation/profile/controllers/profile.controller.dart';

class OtpController extends GetxController {
  RxString numberToDisplay = "".obs;
  String countryCode = "";
  String mobileNumber = "";
  RxBool isVerify = false.obs;
  RxBool isLoading = false.obs;
  RxBool resendOtpTime = false.obs;

  Rx<Duration> remainingTime = Rx<Duration>(const Duration(minutes: 1));

  // Duration remainingTime = const Duration(minutes: 1);
  final formKey = GlobalKey<FormState>();
  final className = "OTP-Screen";
  Timer? timer;

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
    verifyOtpTimer();
  }

  void verifyOtpTimer() {
    resendOtpTime(false);
    remainingTime.value = const Duration(seconds: 60);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > const Duration(seconds: 0)) {
        remainingTime.value = remainingTime.value - const Duration(seconds: 1);
      } else {
        resendOtpTime(true);
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    timer?.cancel();
    isLoading(true);
    verifyOtpTimer();
    LoginProvider()
        .resendOtp(phoneNumber: mobileNumber, countryCode: countryCode)
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
            phoneNumber: mobileNumber, countryCode: countryCode, otp: otp)
        .then((value) {
      isLoading(false);
      VerifyOtpResponse response = value;
      if (response.status ?? false) {
        AppStorage().writeUserId("${response.userId ?? 0}");
        AppStorage().writeAccessToken(response.accessToken ?? "");
        AppStorage().writeAccessToken(response.accessToken ?? "");
        AppStorage().writeIsLoggedIn(response.isProfileCompleted ?? false);
        AppStorage().writeMobileNumber(mobileNumber);
        moveToNext();
        if (isVerify.value) {
          CustomSnackBar.showSuccessSnackBar(
              LocaleKeys.success.tr, response.message ?? "");
        }
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  bool validate() {
    if (otp.length == 4) {
      return true;
    }
    return false;
  }

  void moveToNext() {
    bool profileCompleted = AppStorage().getLoggedIn();
    if (isVerify.value) {
      Get.back(result: true);
      final profileController = Get.find<ProfileController>();
      profileController.getProfile();
    } else if (profileCompleted) {
      NavigationUtils().callHomePage();
    } else {
      NavigationUtils().callRegistration(countryCode, mobileNumber);
    }
  }
}
