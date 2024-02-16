import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

import '../../../infrastructure/dal/models/charging_session/charging_session_respose.dart';
import '../../../infrastructure/dal/providers/charging_session/charging_session_provider.dart';

class ChargingSessionController extends GetxController {
  final int moneyOptionValue = 1;
  final int timeOptionValue = 2;
  final int energyOptionValue = 3;
  int? stationId;
  int? connectorId;
  RxBool isLoading = true.obs;
  ChargingSessionResponseModel? chargingSession;
  RxInt selectedChargingOption = 1.obs;
  RxInt standardMinValue = 100.obs;
  RxInt standardMaxValue = 5000.obs;
  static int standardValue = 100;
  TextEditingController textController = TextEditingController();

  @override
  void onInit() async {
    stationId =
        int.parse((Get.parameters[ParamName.stationId] ?? "0").toString());
    //stationId = 9;
    connectorId =
        int.parse((Get.parameters[ParamName.connectorId] ?? "0").toString());

    await Future.delayed(const Duration(seconds: 1));
    if (stationId != 0 && connectorId != 0) {
      postChargingSessionDetail(connectorId ?? 0, stationId ?? 0);
    } else {
      NavigationUtils().goBack();
      CustomSnackBar.showErrorSnackBar(translate(LocaleKeys.error),
          translate(LocaleKeys.somethingWentWrongPleaseTryAgainLater));
    }

    super.onInit();
  }

  //1= Money
  //2= Time
  //3= Energy
  setSelectedOption(int selectedIndex) {
    selectedChargingOption(selectedIndex);
  }

  void postChargingSessionDetail(int connectorId, int stationId) {
    isLoading(true);
    ChargingSessionDetailsProvider()
        .postChargingSessionDetails(
            connectorId: connectorId, stationId: stationId)
        .then((value) {
      if (value.status == true) {
        chargingSession = value;
        standardMinValue.value =
            int.parse(value.chargingSession?.minAmount ?? "0");
        textController.text = value.chargingSession?.minAmount ?? "0";
        standardMaxValue.value =
            int.parse(value.chargingSession?.maxAmount ?? "0");
        isLoading(false);
      } else {
        isLoading(false);
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, value.message ?? "");
      }
    });
  }

  String getSubtitleText() {
    String text = translate(LocaleKeys.set);
    if (selectedChargingOption.value == moneyOptionValue) {
      text =
          "$text ${translate(LocaleKeys.budget)} ( ${translate(LocaleKeys.money)}: \$ )";
    } else if (selectedChargingOption.value == timeOptionValue) {
      text =
          "$text ${translate(LocaleKeys.time).toLowerCase()} ( ${translate(LocaleKeys.duration)}: ${translate(LocaleKeys.minutes)} )";
    } else if (selectedChargingOption.value == energyOptionValue) {
      text =
          "$text ${translate(LocaleKeys.energy).toLowerCase()}  ( ${translate(LocaleKeys.energy)}: ${translate(LocaleKeys.kwh)} )";
    }
    return text;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
