import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/routes.dart';
import 'package:project/infrastructure/storage/app_storage.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/param_name.dart';
import '../utils/translation_util.dart';
import '../views/custom_alert_view.dart';

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
      bool clearBackStack = false,
      required bool isVerify}) async {
    bool verified = false;
    if (clearBackStack) {
      verified = await Get.offNamed(Routes.OTP, parameters: {
        ParamName.countryCode: countryCode,
        ParamName.mobileNumber: mobileNumber,
        ParamName.otp: otp,
        ParamName.isVerify: isVerify.toString()
      });
    } else {
      verified = await Get.toNamed(Routes.OTP, parameters: {
        ParamName.countryCode: countryCode,
        ParamName.mobileNumber: mobileNumber,
        ParamName.otp: otp,
        ParamName.isVerify: isVerify.toString()
      });
    }

    return verified;
  }

  void callHomePage({bool clearStack = false, int? index}) {
    Get.offAllNamed(Routes.HOME, parameters: {
      ParamName.index: index != null
          ? index.toString()
          : HomeController().stationIndex.toString()
    });
  }

  void callRegistration(String countryCode, String mobileNumber) {
    Get.offNamed(Routes.REGISTRATION, parameters: {
      ParamName.countryCode: countryCode,
      ParamName.mobileNumber: mobileNumber,
    });
  }

  Future<bool> goBack({bool? closeOverlays}) async {
    Get.back(closeOverlays: closeOverlays ?? true);
    return true;
  }

  void callLogout() async {
    Get.dialog(
      CustomAlertView(
        title: translate(LocaleKeys.areYouSureYouWantToLogout),
        onPositiveTap: () {
          AppStorage().clearValues();
          callLoginPage(
            clearStack: true,
          );
        },
        onNegativeTap: () {
          NavigationUtils().goBack(closeOverlays: false);
        },
      ),
    );
  }

  void goFromSplash() {
    if (AppStorage().getLoggedIn()) {
      callHomePage(clearStack: true);
    } else {
      callLoginPage(isLoginPage: true, clearStack: true);
    }
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

  Future<bool> callMyVehiclesAddEditPage(int id) async {
    bool? result = await Get.toNamed(Routes.MY_VEHICLES_ADD_EDIT,
        parameters: {ParamName.vehicleId: id.toString()}) as bool?;
    return result ?? false;
  }

  void callMyAddress() {
    Get.toNamed(Routes.MY_ADDRESS);
  }

  Future<bool> callMyAddressAddEditPage(int id) async {
    bool? result = await Get.toNamed(Routes.MY_ADDRESS_ADD_EDIT,
        parameters: {ParamName.addressId: id.toString()}) as bool?;
    return result ?? false;
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
    print("Station id = $stationId");
    print("Connetor id = $connectorId");
    Get.offNamed(Routes.CHARGING_SESSION,
        parameters: {
          ParamName.stationId: stationId.toString(),
          ParamName.connectorId: connectorId.toString()
        },
        preventDuplicates: true);
  }

  void callChargingSessionDetailsFromQRCOde(
      {required String? fromQrCode, required int connectorId}) {
    print("Connetor id = $connectorId");
    Get.offNamed(Routes.STATION_DETAILS,
        parameters: {
          ParamName.from: fromQrCode.toString(),
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

  void callRfidScreen() {
    Get.toNamed(Routes.RFID_TAG_LIST);
  }

  void callWalletListPage() {
    Get.toNamed(Routes.WALLET_LIST);
  }

  void callSupportPage() {
    Get.toNamed(Routes.SUPPORT);
  }

  void callAboutUsPage() {
    Get.toNamed(Routes.ABOUT_US);
  }

  void callChargingBillingPage(int pageIndex) {
    Get.toNamed(Routes.CHARGING_BILLING,
        parameters: {ParamName.pageIndex: pageIndex.toString()});
  }
}
