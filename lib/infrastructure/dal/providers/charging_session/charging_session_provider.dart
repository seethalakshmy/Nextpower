import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/base/CommonResponse.dart';
import '../../models/charging_session/charging_session_respose.dart';
import '../../services/api_service.dart';

class ChargingSessionDetailsProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {}

  Future<ChargingSessionResponseModel> postChargingSessionDetails(
      {required int connectorId, required int stationId}) async {
    try {
      http.Response response =
          await _apiService.apiRequest(endPoint: 'charging_session', params: {
        'station_id': stationId,
        'connector_id': connectorId,
      });
      ChargingSessionResponseModel data =
          ChargingSessionResponseModel.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return ChargingSessionResponseModel(status: false, message: e.toString());
    }
  }

  Future<CommonResponse> startCharging() async {
    try {
      http.Response response =
          await _apiService.apiRequest(endPoint: 'start_charging');
      CommonResponse data = CommonResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider :${e.toString()}");
      return CommonResponse(status: false, message: e.toString());
    }
  }

  Future<CommonResponse> stopCharging() async {
    try {
      http.Response response =
          await _apiService.apiRequest(endPoint: 'stop_charging');
      CommonResponse data = CommonResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider :${e.toString()}");
      return CommonResponse(status: false, message: e.toString());
    }
  }
}
