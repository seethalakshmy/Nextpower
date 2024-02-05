import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/models/stations/StationsDetailsResponse.dart';
import 'package:project/infrastructure/dal/models/stations/StationsResponse.dart';
import 'package:project/infrastructure/dal/models/validate_otp/VerifyOtpResponse.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;

class HomeStationsProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<StationsResponse> getStations(
      {required double latitude, required double longitude}) async {
    try {
      http.Response response = await _apiService.apiRequest(
          endPoint: 'stations',
          params: {'latitude': latitude, 'longitude': longitude});

      StationsResponse data = StationsResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return StationsResponse(status: false, message: e.toString());
    }
  }

  Future<StationsDetailsResponse> getStationDetails({required String stationId}) async {
    try {
      http.Response response =
          await _apiService.apiRequest(endPoint: 'get_station_by_id',
              params: {'id': stationId},
              postRequest: false);

      StationsDetailsResponse data =
      StationsDetailsResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return StationsDetailsResponse(status: false, message: e.toString());
    }
  }
}
