import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/dal/models/countries/state_list_model.dart';



class StateListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return StateList.fromJson(map);
      if (map is List)
        return map.map((item) => StateList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<StateList?> getStateList(int id) async {
    // final response = await get('statelist/$id');
    // return response.body;
    print("getStateList");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonStateList);
    final StateList jsonResult = StateList.fromJson(jsonDecode(data));
    print("State Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<StateList>> postStateList(StateList statelist) async =>
      await post('statelist', statelist);

  Future<Response> deleteStateList(int id) async =>
      await delete('statelist/$id');
}