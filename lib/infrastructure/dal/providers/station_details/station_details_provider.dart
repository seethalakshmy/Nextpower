import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/station_details/station_details_model.dart';
import '../../services/api_service.dart';

class StationDetailsProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
  }

  Future<StationDetailModel> getStationDetails({required int id}) async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'get_station_by_id',postRequest: false,
          params: {
            'id': id.toString(),
          }
      );
      StationDetailModel data =
      StationDetailModel.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return StationDetailModel(status: false, message: e.toString());
    }
  }


}