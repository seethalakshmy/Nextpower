import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/infrastructure/dal/models/station_details/ConnectorsResponse.dart';

import '../../models/station_details/station_details_model.dart';
import '../../services/api_service.dart';

class StationDetailsProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {}

  Future<StationDetailResponse> getStationDetails(
      {required String id,
      required String fromQR,
      required int stationID}) async {
    try {
      if (fromQR == "fromQrCode") {
        http.Response response = await _apiService.apiRequest(
            endPoint: 'get_station_by_id',
            postRequest: false,
            params: {
              'charging_point_qrcode': id.toString(),
            });
        StationDetailResponse data =
            StationDetailResponse.fromJson(json.decode(response.body));
        return data;
      } else {
        http.Response response = await _apiService.apiRequest(
            endPoint: 'get_station_by_id',
            postRequest: false,
            params: {
              'id': stationID.toString(),
            });
        StationDetailResponse data =
            StationDetailResponse.fromJson(json.decode(response.body));
        return data;
      }
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return StationDetailResponse(status: false, message: e.toString());
    }
  }

  Future<ConnectorsResponse> getConnectors({required String stationId}) async {
    try {
      http.Response response = await _apiService
          .apiRequest(endPoint: 'connectors', postRequest: false, params: {
        'station_id': stationId,
      });
      ConnectorsResponse data =
          ConnectorsResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return ConnectorsResponse(status: false, message: e.toString());
    }
  }
}
