import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/routes.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void callHomePage({bool clearStack = false, int? index}) {
    // if (clearStack) {
    //   Get.offAllNamed(Routes.HOME, parameters: {
    //     ParamName.index: index != null
    //         ? index.toString()
    //         : HomeController().stationIndex.toString()
    //   });
    // } else {
    Get.offAllNamed(Routes.HOME, parameters: {
      ParamName.index: index != null
          ? index.toString()
          : HomeController().stationIndex.toString()
    });
    // }
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
    // callLoginPage(isLoginPage: true);
    // Get.offAllNamed(Routes.STATION_DETAILS);
    Get.offAllNamed(Routes.HOME);
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

  Future<void> callGoogleMap(double lat, double long) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl),
          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  callStationList() {
    Get.toNamed(Routes.STATION_LIST);
  }

  void callStationDetails(int stationId) {
    Get.toNamed(Routes.STATION_DETAILS,
        parameters: {ParamName.stationId: stationId.toString()});
  }

  void callChargingSessionDetails(
      {required int? stationId, required int connectorId}) {
    print(stationId);
    print(connectorId);
    Get.offNamed(Routes.CHARGING_SESSION,
        parameters: {
          ParamName.stationId: stationId.toString(),
          ParamName.connectorId: connectorId.toString()
        },
        preventDuplicates: true);
  }

  void callQrCodeScannerPage() {
    Get.toNamed(Routes.QR_CODE);
  }

  void callHistoryDetails(int id) {
    Get.toNamed(Routes.USAGE_HISTORY_DETAILS,
        parameters: {ParamName.historyId: id.toString()});
  }
}