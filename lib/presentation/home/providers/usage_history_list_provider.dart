import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/usage_history_list_model.dart';

class UsageHistoryListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UsageHistoryList.fromJson(map);
      if (map is List) {
        return map.map((item) => UsageHistoryList.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UsageHistoryList?> getUsageHistoryList(int historyOption) async {
    // final response = await get('usagehistorylist/$id');
    // return response.body;
    print("getUsageHistory Called");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonUsageHistoryList);

    print(data);
    final UsageHistoryList jsonResult =
    UsageHistoryList.fromJson(jsonDecode(data));
    print("UsageHistoryList Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<UsageHistoryList>> postUsageHistoryList(
      UsageHistoryList usagehistorylist) async =>
      await post('usagehistorylist', usagehistorylist);

  Future<Response> deleteUsageHistoryList(int id) async =>
      await delete('usagehistorylist/$id');
}