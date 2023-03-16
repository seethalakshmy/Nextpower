import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/routes.dart';

import '../utils/param_name.dart';

class NavigationUtils {
  void callLoginPage({bool clearStack = false, bool isLoginPage = true}) {
    if (clearStack) {
      Get.offAllNamed(Routes.LOGIN,
          parameters: {ParamName.isLoginPage: isLoginPage.toString()});
    } else {
      Get.toNamed(Routes.LOGIN,
          parameters: {ParamName.isLoginPage: isLoginPage.toString()});
    }
  }

  Future<bool> callOTPPage(
      {required String countryCode,
      required String mobileNumber,
      required String otp,
      required bool isVerify}) async {
    bool verified = await Get.toNamed(Routes.OTP, parameters: {
      ParamName.countryCode: countryCode,
      ParamName.mobileNumber: mobileNumber,
      ParamName.otp: otp,
      ParamName.isVerify: isVerify.toString()
    });
    return verified;
  }

  void callHomePage() {
    Get.toNamed(Routes.HOME);
  }

  void callRegistration(String countryCode, String mobileNumber) {
    Get.toNamed(Routes.REGISTRATION, parameters: {
      ParamName.countryCode: countryCode,
      ParamName.mobileNumber: mobileNumber,
    });
  }

  void goBack() {
    Get.back();
  }

  void goFromSplash() {
    // callLoginPage(isLoginPage: false);
    // Get.offAllNamed(Routes.REGISTRATION);
    Get.offAllNamed(Routes.PROFILE);
  }

  void callProfile() {
    Get.offAllNamed(Routes.PROFILE);
  }
}