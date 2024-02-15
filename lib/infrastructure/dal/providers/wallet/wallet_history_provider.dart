import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../../models/Wallet/wallet_history_response_model.dart';

class WalletHistoryProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<WalletHistoryResponseModel> getWalletHistory() async {
    try {
      http.Response response = await _apiService.apiRequest(
          endPoint: 'wallet_history', postRequest: false);

      WalletHistoryResponseModel data =
      WalletHistoryResponseModel.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return WalletHistoryResponseModel(status: false, message: e.toString());
    }
  }


}
