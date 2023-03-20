import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/station_details_model.dart';

class StationDetailsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return StationDetails.fromJson(map);
      if (map is List)
        return map.map((item) => StationDetails.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<StationDetails?> getStationDetails(int id) async {
    // final response = await get('stationdetails/$id');
    // return response.body;
    print("getStationDetails");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonStationDetails);
    final StationDetails jsonResult = StationDetails.fromJson(jsonDecode(data));
    print("Station details Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<StationDetails>> postStationDetails(
          StationDetails stationdetails) async =>
      await post('stationdetails', stationdetails);

  Future<Response> deleteStationDetails(int id) async =>
      await delete('stationdetails/$id');
}