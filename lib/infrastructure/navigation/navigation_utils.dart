import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/routes.dart';

import '../utils/param_name.dart';

class NavigationUtils {
  void callLoginPage({bool clearStack = false}) {
    if (clearStack) {
      Get.offAllNamed(
        Routes.LOGIN,
      );
    } else {
      Get.toNamed(
        Routes.LOGIN,
      );
    }
  }

  void callOTPPage(String countryCode, String mobileNumber, String otp) {
    Get.toNamed(Routes.OTP, parameters: {
      ParamName.countryCode: countryCode,
      ParamName.mobileNumber: mobileNumber,
      ParamName.otp: otp,
    });
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
    Get.offAllNamed(Routes.LOGIN);
    // Get.offAllNamed(Routes.REGISTRATION);
  }
}