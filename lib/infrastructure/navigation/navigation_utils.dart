import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/routes.dart';

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

  void callOTPPage(String mobileNumber, String otp) {
    Get.toNamed(Routes.OTP, parameters: {
      "mobile_number": mobileNumber,
      "otp": otp,
    });
  }

  void callHomePage() {
    Get.toNamed(Routes.HOME);
  }
}