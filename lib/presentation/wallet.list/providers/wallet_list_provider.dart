import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../wallet_list_model.dart';

class WalletListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return WalletList.fromJson(map);
      if (map is List)
        return map.map((item) => WalletList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<WalletList?> getWalletList() async {
    // final response = await get('walletlist/$id');
    // return response.body;
    print("getWalletList");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonWalletList);
    final WalletList jsonResult = WalletList.fromJson(jsonDecode(data));
    print("UsageHistoryDetails Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<WalletList>> postWalletList(WalletList walletlist) async =>
      await post('walletlist', walletlist);

  Future<Response> deleteWalletList(int id) async =>
      await delete('walletlist/$id');
}