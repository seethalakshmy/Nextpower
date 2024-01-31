import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/utility.dart';

import '../../../infrastructure/utils/constants.dart';
import '../models/profile_model.dart';
import '../providers/profile_provider.dart';

class ProfileController extends GetxController {
  Rx<Profile> currentProfileData = Profile().obs;
  RxBool isLoading = false.obs;
  RxBool isEditable = false.obs;
  final formKey = GlobalKey<FormState>();
  RxString mobileNumberError = "".obs;
  RxBool isEmailVerificationEnabled = false.obs;
  RxBool isMobileVerificationEnabled = false.obs;
  RxBool isEmailVerified = true.obs;
  RxBool isMobileVerified = true.obs;

  Profile previousProfile = Profile();
  String previousEmail = "";
  String previousMobileNumber = "";
  String previousCountryCode = "";
  RxString userImagePath = "".obs;
  String from = ""; //not used now
  RxList<Country> countries = RxList.empty(growable: true);

  @override
  void onInit() {
    print('profileController init called');
    isLoading(true);
    from = Get.parameters[ParamName.from].toString();
    ProfileProvider().getProfile(0).then((value) async {
      await Future.delayed(const Duration(seconds: 2));
      currentProfileData.value = value;
      previousEmail = value.emailId ?? "";
      previousMobileNumber = value.mobileNumber ?? "";
      isLoading(false);
    });
    super.onInit();
  }

  setCountryCode([String? value]) {
    currentProfileData.value.countryCode =
        value ?? AppConstants().countryCodeList.first;
    print(jsonEncode(currentProfileData));
  }

  @override
  void onReady() {
    print('profileController onready called');

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeEmailID(String value) {
    print('value: $value; previousEmail: ${previousEmail}');
    if (value.compareTo(previousEmail) != 0) {
      isEmailVerified(false);
    } else {
      isEmailVerified(true);
    }
    currentProfileData.update((val) {
      val?.emailId = value;
    });
  }

  void changePhoneNumber(value) {
    if (value != previousMobileNumber) {
      isEmailVerified(false);
    } else {
      isEmailVerified(true);
    }
    currentProfileData.update((val) {
      val?.mobileNumber = value ?? "";
    });
  }

  void changeCountryCode(value) {
    if (value != previousCountryCode) {
      isEmailVerified(false);
    } else {
      isEmailVerified(true);
    }
    currentProfileData.update((val) {
      val?.countryCode = value ?? "";
    });
  }

  void setProfileEditable() {
    isEditable(true);
  }

  bool isValid(bool validate) {
    if (!validate) {
      return false;
    }
    if (previousProfile.emailId != currentProfileData.value.emailId) {
      return false;
    }
    if (previousProfile.countryCode != currentProfileData.value.countryCode) {
      return false;
    }
    return true;
  }

  void validateEmailID() async {
    String otp = Utility.generate4DigitOTP();
    CustomSnackBar.showSuccessSnackBar("OTP", otp);
    isEmailVerified.value = await NavigationUtils().callOTPPage(
        countryCode: "",
        mobileNumber: currentProfileData.value.emailId ?? "",
        otp: otp,
        isVerify: true);
  }

  void submit() {
    isEditable(false);
    print("Data to pass:${jsonEncode(currentProfileData)}");
  }

  void gotoLogin() {
    NavigationUtils().callLoginPage(isLoginPage: false);
  }
}