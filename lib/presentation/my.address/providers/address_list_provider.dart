import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../address_list_model.dart';

class AddressListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return AddressList.fromJson(map);
      if (map is List)
        return map.map((item) => AddressList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<AddressList?> getAddressList() async {
    // final response = await get('addresslist/$id');
    // return response.body;
    print("getAddressList");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonAddressList);
    final AddressList jsonResult = AddressList.fromJson(jsonDecode(data));
    print("My Address Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<AddressList>> postAddressList(
          AddressList addresslist) async =>
      await post('addresslist', addresslist);

  Future<Response> deleteAddressList(int id) async =>
      await delete('addresslist/$id');
}