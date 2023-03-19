import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/vehicles_list_model.dart';

class VehiclesListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return VehiclesList.fromJson(map);
      if (map is List)
        return map.map((item) => VehiclesList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<VehiclesList?> getVehiclesList() async {
    // final response = await get('vehicleslist/$id');
    // return response.body;
    print("getVehiclesList");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonVehiclesList);
    final VehiclesList jsonResult = VehiclesList.fromJson(jsonDecode(data));
    print("My Vehicles Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<VehiclesList>> postVehiclesList(
          VehiclesList vehicleslist) async =>
      await post('vehicleslist', vehicleslist);

  Future<Response> deleteVehiclesList(int id) async =>
      await delete('vehicleslist/$id');
}