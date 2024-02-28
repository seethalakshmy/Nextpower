import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/models/validate_otp/VerifyOtpResponse.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../storage/app_storage.dart';

class ChangeMobileNumberProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<LoginResponse> changePhoneNumber(
      {required String phoneNumber, required String countryCode}) async {
    try {
      String userId = AppStorage().getUserId();
      http.Response response = await _apiService.apiRequest(
          endPoint: 'change_phone_number',
          params: {'country_code': countryCode, 'phone_number': phoneNumber,"user_id":userId});

      LoginResponse data = LoginResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return LoginResponse(status: false, message: e.toString());
    }
  }

  Future<VerifyOtpResponse> verifyOtp(
      {
        required String phoneNumber,
        required String countryCode,
        required String otp
      }
      ) async {
    try {
      http.Response response =
      await _apiService.apiRequest(
        endPoint: 'verify_otp',
        params: {
          'country_code': countryCode,
          'phone_number': phoneNumber,
          'otp': otp,
        }
      );

      VerifyOtpResponse data =
      VerifyOtpResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return VerifyOtpResponse(status: false, message: e.toString());
    }
  }
}
