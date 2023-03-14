import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/utility.dart';

class OtpController extends GetxController {
  RxString numberToDisplay = "".obs;
  String countryCode = "";
  String mobileNumber = "";
  String otp = "";
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    mobileNumber = Get.parameters[ParamName.mobileNumber] ?? "";
    countryCode = Get.parameters[ParamName.countryCode] ?? "";
    numberToDisplay.value = "$countryCode $mobileNumber";
    otp = Get.parameters['otp'] ?? "";
    if (numberToDisplay.isEmpty) {
      CustomSnackBar.showErrorSnackBar(
          'Error', "Something went wrong. Please try again");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void resendOTP() {
    String otp = Utility.generate4DigitOTP();
    CustomSnackBar.showSuccessSnackBar("OTP", otp);
    PrintUtils().prints(message: "OTP", value: otp);
    this.otp = otp;
  }

  void changePhoneNumber() {
    Get.back(closeOverlays: true);
  }
}