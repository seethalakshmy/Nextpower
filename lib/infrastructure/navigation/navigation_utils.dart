import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/routes.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';

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

  void callHomePage({bool clearStack = false}) {
    if (clearStack) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.HOME);
    }
  }

  void callRegistration(String countryCode, String mobileNumber) {
    Get.toNamed(Routes.REGISTRATION, parameters: {
      ParamName.countryCode: countryCode,
      ParamName.mobileNumber: mobileNumber,
    });
  }

  Future<bool> goBack() async {
    Get.back(closeOverlays: true);
    return true;
  }

  void callLogout() async {
    callLoginPage(
      clearStack: true,
    );
  }

  void goFromSplash() {
    callLoginPage(isLoginPage: true);
    // Get.offAllNamed(Routes.STATION_DETAILS);
    // Get.offAllNamed(Routes.MY_ADDRESS);
  }

  void callProfile({bool clearStack = false, required String isCalledFrom}) {
    if (clearStack) {
      Get.offAllNamed(Routes.PROFILE,
          parameters: {ParamName.from: isCalledFrom});
    } else {
      Get.toNamed(Routes.PROFILE);
    }
  }

  void callMyVehicles() {
    Get.toNamed(Routes.MY_VEHICLES);
  }

  void callMyVehiclesAddEditPage(int id) {
    Get.toNamed(Routes.MY_VEHICLES_ADD_EDIT,
        parameters: {ParamName.vehicleId: id.toString()});
  }

  void callMyAddress() {
    Get.toNamed(Routes.MY_ADDRESS);
  }

  void callMyAddressAddEditPage(int id) {
    Get.toNamed(Routes.MY_ADDRESS_ADD_EDIT,
        parameters: {ParamName.addressId: id.toString()});
  }

  callScreenYetToBeDone() {
    CustomSnackBar.showErrorSnackBar('Error', "Screen yet to be done");
  }

  callStationList() {
    Get.toNamed(Routes.STATION_LIST);
  }

  void callStationDetails() {
    Get.toNamed(Routes.STATION_DETAILS);
  }
}