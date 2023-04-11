import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/usage_history_details_model.dart';

class UsageHistoryDetailsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UsageHistoryDetails.fromJson(map);
      if (map is List)
        return map.map((item) => UsageHistoryDetails.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UsageHistoryDetails?> getUsageHistoryDetails(int id) async {
    // final response = await get('usagehistorydetails/$id');
    // return response.body;
    print("getUsageHistoryDetails");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonUsageHistoryDetails);
    final UsageHistoryDetails jsonResult =
        UsageHistoryDetails.fromJson(jsonDecode(data));
    print("UsageHistoryDetails Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<UsageHistoryDetails>> postUsageHistoryDetails(
          UsageHistoryDetails usagehistorydetails) async =>
      await post('usagehistorydetails', usagehistorydetails);

  Future<Response> deleteUsageHistoryDetails(int id) async =>
      await delete('usagehistorydetails/$id');
}