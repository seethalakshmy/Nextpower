import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/base/CommonResponse.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:project/infrastructure/storage/app_storage.dart';

class RegistrationProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<CommonResponse> registration(
      {
        required String email,
        required String name
      }
      ) async {
    try {
      String userId = AppStorage().getUserId();
      http.Response response =
      await _apiService.apiRequest(
        endPoint: 'sign_up',
        params: {
          'email': email,
          'user_id': userId,
          'name': name,
        }
      );

      CommonResponse data =
      CommonResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return CommonResponse(status: false, message: e.toString());
    }
  }
}
