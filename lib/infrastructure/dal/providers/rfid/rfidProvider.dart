import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/rfid/rfid_response.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';

class RfidTagListProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {

  }

  Future<RfidResponse?> getRfidTagList() async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'get_RFID_list',postRequest: false);
      RfidResponse data =
      RfidResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return RfidResponse(status: false, message: e.toString());
    }
  }


}