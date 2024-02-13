import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/charging_session/charging_session_respose.dart';
import '../../services/api_service.dart';


class ChargingSessionDetailsProvider extends GetConnect {

  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
  }


  Future<ChargingSessionResponseModel> postChargingSessionDetails({required int connectorId ,required int stationId}) async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'charging_session',
          params: {
            'station_id': stationId,
            'connector_id': connectorId,
          }
      );
      ChargingSessionResponseModel data =
      ChargingSessionResponseModel.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return ChargingSessionResponseModel(status: false, message: e.toString());
    }
  }

  // Future<ChargingSessionDetails?> getChargingSessionDetails(
  //     {required int stationId, required int connectorId}) async {
  //   // final response = await get('chargingsessiondetails/$id');
  //   // return response.body;
  //   print("getChargingSessionDetails Called");
  //   String data = await DefaultAssetBundle.of(Get.context!)
  //       .loadString(Assets.jsonChargingSessionDetails);
  //   final ChargingSessionDetails jsonResult =
  //   ChargingSessionDetails.fromJson(jsonDecode(data));
  //   print("ChargingSessionDetails Repository: data:${jsonResult.toJson()}");
  //   return jsonResult;
  // }
  //
  // Future<Response<ChargingSessionDetails>> postChargingSessionDetails(
  //     ChargingSessionDetails chargingsessiondetails) async =>
  //     await post('chargingsessiondetails', chargingsessiondetails);
  //
  // Future<Response> deleteChargingSessionDetails(int id) async =>
  //     await delete('chargingsessiondetails/$id');
}