import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/presentation/my_vehicles/models/vehicles_list_model.dart';
import 'package:project/presentation/my_vehicles/providers/vehicles_list_provider.dart';

class MyVehiclesAddEditController extends GetxController {
  //TODO: Implement MyVehiclesAddEditController

  final isLoading = true.obs;
  Vehicles vehicle = Vehicles();
  final formKey = GlobalKey<FormState>();
  int vehicleId = 0;

  @override
  void onInit() {
    vehicleId = int.parse(Get.parameters[ParamName.vehicleId].toString());
    if (vehicleId != 0) {
      VehiclesListProvider().getVehiclesList().then((value) {
        vehicle = value?.vehicles
                ?.singleWhere((element) => element.vehicleId == vehicleId) ??
            Vehicles();
        isLoading(false);
        print("Vehicle:${jsonEncode(vehicle)}");
      });
    } else {
      isLoading(false);
    }
    super.onInit();
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