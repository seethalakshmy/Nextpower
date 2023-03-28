import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/stations_list_model.dart';

class StationsListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return StationsList.fromJson(map);
      if (map is List)
        return map.map((item) => StationsList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<StationsList?> getStationsList() async {
    // final response = await get('stationslist/$id');
    // return response.body;
    print("getStationsList");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonStationsList);
    final StationsList jsonResult = StationsList.fromJson(jsonDecode(data));
    print("Station list Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<StationsList>> postStationsList(
          StationsList stationslist) async =>
      await post('stationslist', stationslist);

  Future<Response> deleteStationsList(int id) async =>
      await delete('stationslist/$id');
}