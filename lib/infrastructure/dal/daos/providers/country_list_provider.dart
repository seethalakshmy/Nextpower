import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../country_list_model.dart';

class CountryListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return CountryList.fromJson(map);
      if (map is List)
        return map.map((item) => CountryList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<CountryList?> getCountryList() async {
    // final response = await get('countrylist/$id');
    // return response.body;
    print("getCountryList");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonCountryList);
    final CountryList jsonResult = CountryList.fromJson(jsonDecode(data));
    print("Country Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<CountryList>> postCountryList(
          CountryList countrylist) async =>
      await post('countrylist', countrylist);

  Future<Response> deleteCountryList(int id) async =>
      await delete('countrylist/$id');
}