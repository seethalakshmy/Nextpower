import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleMakersResponse.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleModelsResponse.dart';
import 'package:project/infrastructure/dal/providers/vehicle/vehicle_provider.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/presentation/my_vehicles/models/vehicle_request_model.dart';

class MyVehiclesAddEditController extends GetxController {
  final isLoading = false.obs;
  final buttonEnable = true.obs;
  final buttonLoading = false.obs;
  VehicleRequest vehicle = VehicleRequest();
  final formKey = GlobalKey<FormState>();
  int vehicleId = 0;
  RxList<MakersItem> makers = RxList.empty(growable: true);
  RxList<ModelsItem> models = RxList.empty(growable: true);
  String makeId = "";
  String modelId = "";

  @override
  void onInit() {
    vehicleId = int.parse(Get.parameters[ParamName.vehicleId].toString());
    if (vehicleId != 0) {
      //edit
      getVehicleDetails();
    }

    getVehicleMakeList();

    super.onInit();
  }

  void getVehicleMakeList() {
    VehicleProvider().getVehicleMakersList().then((response) {
      if (response.status ?? false) {
        makers.addAll(response.stations ?? []);
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void getVehicleModelList() {
    VehicleProvider().getVehicleModelsList(makerId: makeId).then((response) {
      if (response.status ?? false) {
        models.value = response.stations ?? [];
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void getVehicleDetails() {
    isLoading(true);
    VehicleProvider()
        .getVehicleDetails(vehicleId: vehicleId.toString())
        .then((response) {
      isLoading(false);
      if (response.status ?? false) {
        VehicleRequest res = VehicleRequest(
            vehicleMake: response.vehicle?.vehicleMake ?? "",
            vehicleModel: response.vehicle?.vehicleModel ?? "",
            vehicleNumber: response.vehicle?.vehicleNumber ?? "");
        modelId = "${response.vehicle?.vehicleModelId ?? 0}";
        makeId = "${response.vehicle?.vehicleMakeId ?? 0}";
        vehicle = res;
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  bool validation() {
    if (vehicle.vehicleNumber.trim().isEmpty) {
      return false;
    }
    if (makeId.isEmpty) {
      CustomSnackBar.showErrorSnackBar(LocaleKeys.failed.tr,
          LocaleKeys.select_vehicle_make_from_drop_down.tr);
      return false;
    }
    if (modelId.isEmpty) {
      CustomSnackBar.showErrorSnackBar(LocaleKeys.failed.tr,
          LocaleKeys.select_vehicle_model_from_drop_down.tr);
      return false;
    }
    buttonEnable(true);
    return true;
  }

  void selectMakeId(String text) {
    for (MakersItem itm in makers.value) {
      if (text.trim().toLowerCase() == itm.title!.toLowerCase()) {
        makeId = itm.id.toString();
        break;
      }
    }
  }

  void selectModelId(String text) {
    for (ModelsItem itm in models.value) {
      if (text.trim().toLowerCase() == itm.name!.toLowerCase()) {
        modelId = itm.id.toString();
        break;
      }
    }
  }

  void addVehicle() {
    buttonLoading(true);
    VehicleProvider()
        .addVehicle(
            vehicleNumber: vehicle.vehicleNumber,
            vehicleModel: modelId,
            vehicleMake: makeId)
        .then((response) {
      buttonLoading(false);
      if (response.status ?? false) {
        Get.back(result: true);
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.message ?? "");
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void updateVehicle() {
    buttonLoading(true);
    VehicleProvider()
        .updateVehicle(
            id: vehicleId.toString(),
            vehicleNumber: vehicle.vehicleNumber,
            vehicleModel: modelId,
            vehicleMake: makeId)
        .then((response) {
      buttonLoading(false);
      if (response.status ?? false) {
        Get.back(result: true);
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.message ?? "");
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }
}
