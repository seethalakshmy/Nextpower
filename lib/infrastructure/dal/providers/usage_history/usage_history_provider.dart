import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/models/states/StatesResponse.dart';
import 'package:project/infrastructure/dal/models/usage_history/UsageHistoryDetailResponse.dart';
import 'package:project/infrastructure/dal/models/usage_history/UsageHistoryResponse.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;

class UsageHistoryProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<UsageHistoryResponse> getUsageHistory() async {
    try {
      http.Response response =
          await _apiService.apiRequest(endPoint: 'get_usage_history', postRequest: false);

      UsageHistoryResponse data =
      UsageHistoryResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return UsageHistoryResponse(status: false, message: e.toString());
    }
  }

  Future<UsageHistoryDetailResponse> getUsageHistoryDetails({required String id}) async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'get_usage_history_by_id', postRequest: false,
          params: {
            'id': id,
          }
      );

      UsageHistoryDetailResponse data =
      UsageHistoryDetailResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return UsageHistoryDetailResponse(status: false, message: e.toString());
    }
  }
}
