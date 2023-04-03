import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../rfid_tag_list_model.dart';

class RfidTagListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return RfidTagList.fromJson(map);
      if (map is List)
        return map.map((item) => RfidTagList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<RfidTagList?> getRfidTagList() async {
    // final response = await get('rfidtaglist/$id');
    // return response.body;
    print("getRfidTagList");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonRfidTagList);
    final RfidTagList jsonResult = RfidTagList.fromJson(jsonDecode(data));
    print("My Vehicles Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<RfidTagList>> postRfidTagList(
      RfidTagList rfidtaglist) async =>
      await post('rfidtaglist', rfidtaglist);

  Future<Response> deleteRfidTagList(int id) async =>
      await delete('rfidtaglist/$id');
}