import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/charging_session_details_model.dart';

class ChargingSessionDetailsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        return ChargingSessionDetails.fromJson(map);
      }
      if (map is List) {
        return map
            .map((item) => ChargingSessionDetails.fromJson(item))
            .toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<ChargingSessionDetails?> getChargingSessionDetails(
      {required int stationId, required int connectorId}) async {
    // final response = await get('chargingsessiondetails/$id');
    // return response.body;
    print("getChargingSessionDetails Called");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonChargingSessionDetails);
    final ChargingSessionDetails jsonResult =
        ChargingSessionDetails.fromJson(jsonDecode(data));
    print("ChargingSessionDetails Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<ChargingSessionDetails>> postChargingSessionDetails(
          ChargingSessionDetails chargingsessiondetails) async =>
      await post('chargingsessiondetails', chargingsessiondetails);

  Future<Response> deleteChargingSessionDetails(int id) async =>
      await delete('chargingsessiondetails/$id');
}