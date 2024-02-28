
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'package:project/infrastructure/dal/providers/profile/profile_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';


class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool buttonLoading = false.obs;
  RxBool isEditable = false.obs;
  RxBool isApiCalling = false.obs;
  RxBool isEmailVerificationEnabled = false.obs;
  RxBool isMobileVerificationEnabled = false.obs;
  RxBool isEmailVerified = true.obs;
  RxBool isMobileVerified = true.obs;
  RxBool isEmailVerificationIconEnable = true.obs;
  RxString userImagePath = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString countryCode = "".obs;

  RxString mobileNumberError = "".obs;
  String previousEmail = "";
  String from = ""; //not used now
  RxList<Country> countries = RxList.empty(growable: true);

  @override
  void onInit() {
    from = Get.parameters[ParamName.from].toString();
    getProfile();
    super.onInit();
  }

  void getProfile() {
    isLoading(true);
    ProfileProvider().getProfile().then((response) {
      isLoading(false);
      if (response.status ?? false) {
        userImagePath(response.profile?.userImage ?? "");
        email(response.profile?.userEmail ?? "");
        name(response.profile?.name ?? "");
        phoneNumber(response.profile?.phoneNumber ?? "");
        countryCode(response.profile?.countryCode ?? "");
        isEmailVerified(response.profile?.isEmailVerified ?? false);

      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }


  
  
  void changeEmailID(String value) {
    if (value.compareTo(previousEmail) != 0) {
      isEmailVerified(false);
    } else {
      isEmailVerified(true);
    }
    email.value = value;
  }

  void setProfileEditable() {
    isEditable(true);
  }

  bool isValid() {
    if (email.value.isEmpty) {
      return false;
    }
    if (name.value.isEmpty) {
      return false;
    }
    return true;
  }

  // void validateEmailID() async {
  //   CustomSnackBar.showSuccessSnackBarWithButton(
  //       title: LocaleKeys.not_verified.tr,
  //       message: LocaleKeys.please_click_link_to_verify_email.tr,
  //       buttonTitle: LocaleKeys.resend_verification_link.tr, onPressedButton: (){
  //
  //         Get.back();
  //       emailVerificationResend();
  //   });
  // }

  void submit() {
    buttonLoading(true);
    ProfileProvider().updateProfile(name: name.value, email: email.value).then((response) {
      buttonLoading(false);
      if (response.status ?? false) {
        isEditable(false);
        getProfile();
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.message ?? "");
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void emailVerificationResend() {
    isApiCalling.value = true;
    ProfileProvider().emailVerificationResend().then((response) {
      if (response.status == true) {
        isApiCalling.value = false;
        isEmailVerificationIconEnable.value = false;
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.message ?? "");
      } else {
        isApiCalling.value = false;
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }




  void gotoLogin() {
    NavigationUtils().callLoginPage(isLoginPage: false);
  }
}