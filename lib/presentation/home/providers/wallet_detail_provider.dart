import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/wallet_detail_model.dart';

class WalletDetailProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return WalletDetail.fromJson(map);
      if (map is List)
        return map.map((item) => WalletDetail.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<WalletDetail?> getWalletDetail() async {
    // final response = await get('walletdetail/$id');
    // return response.body;
    print("getWalletDetail Called");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonWalletDetail);

    print(data);
    final WalletDetail jsonResult = WalletDetail.fromJson(jsonDecode(data));
    print("WalletDetail Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<WalletDetail>> postWalletDetail(
          WalletDetail walletdetail) async =>
      await post('walletdetail', walletdetail);

  Future<Response> deleteWalletDetail(int id) async =>
      await delete('walletdetail/$id');
}