import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
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
  final formKey = GlobalKey<FormState>();


  //dummy variables
  String otp = "";
  bool isAccountCreated = true;

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
    otp = Get.parameters['otp'] ?? "";
    if (numberToDisplay.isEmpty) {
      CustomSnackBar.showErrorSnackBar(translate(LocaleKeys.error),
          translate(LocaleKeys.somethingWentWrongPleaseTryAgainLater));
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