import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;
import '../../models/Wallet/wallet_detail_response_model.dart';
import '../../models/base/CommonResponse.dart';

class WalletDetailProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<WalletDetailResponseModel> getWalletDetail() async {
    try {
      http.Response response = await _apiService.apiRequest(
          endPoint: 'get_wallet', postRequest: false);

      WalletDetailResponseModel data =
          WalletDetailResponseModel.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return WalletDetailResponseModel(status: false, message: e.toString());
    }
  }

  Future<CommonResponse> addAmountToWallet(
      String transactionId, int amount) async {
    try {
      http.Response response = await _apiService.apiRequest(
          endPoint: 'add_wallet',
          params: {
            "transaction_id": transactionId,
            "amount": amount,
            "payment_response": ""
          });

      CommonResponse data =
      CommonResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return CommonResponse(status: false, message: e.toString());
    }
  }
}
