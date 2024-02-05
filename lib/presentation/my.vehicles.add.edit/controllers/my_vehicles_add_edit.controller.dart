import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/providers/vehicle/vehicle_provider.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/presentation/my_vehicles/models/vehicle_request_model.dart';

class MyVehiclesAddEditController extends GetxController {
  //TODO: Implement MyVehiclesAddEditController

  final isLoading = false.obs;
  final buttonDisable = true.obs;
  final buttonLoading = false.obs;
  VehicleRequest vehicle = VehicleRequest();
  // TextEditingController vehicleNumberController = TextEditingController();
  // TextEditingController vehicleMakeController = TextEditingController();
  // TextEditingController vehicleModelController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int vehicleId = 0;

  @override
  void onInit() {
    vehicleId = int.parse(Get.parameters[ParamName.vehicleId].toString());
    if (vehicleId != 0) {
      //edit
      getVehicleDetails();
    }


    super.onInit();
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
          vehicleNumber: response.vehicle?.vehicleNumber ?? ""
        );
        vehicle = res;
        // vehicleMakeController.text = res.vehicleMake;
        // vehicleModelController.text = res.vehicleModel;
        // vehicleNumberController.text = res.vehicleNumber;
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  bool validation() {
    buttonDisable(true);
    if (vehicle.vehicleNumber.trim().isEmpty) {
      buttonDisable(true);
      return false;
    }
    if (vehicle.vehicleMake.trim().isEmpty) {
      buttonDisable(true);
      return false;
    }
    if (vehicle.vehicleModel.trim().isEmpty) {
      buttonDisable(true);
      return false;
    }
    buttonDisable(false);
    return true;
  }

  void addVehicle() {
    buttonLoading(true);
    VehicleProvider()
        .addVehicle(
            vehicleNumber: vehicle.vehicleNumber,
            vehicleModel: vehicle.vehicleModel,
            vehicleMake: vehicle.vehicleMake)
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
