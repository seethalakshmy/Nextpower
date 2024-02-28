import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/models/validate_otp/VerifyOtpResponse.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;

import '../../../storage/app_storage.dart';

class LoginProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<LoginResponse> login(
      {required String phoneNumber, required String countryCode}) async {
    try {
      http.Response response = await _apiService.apiRequest(
          endPoint: 'sign_in',
          params: {'country_code': countryCode, 'phone_number': phoneNumber});

      LoginResponse data = LoginResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return LoginResponse(status: false, message: e.toString());
    }
  }

  Future<LoginResponse> resendOtp(
      {required String phoneNumber, required String countryCode}) async {
    try {
      http.Response response = await _apiService.apiRequest(
          endPoint: 'resend_otp',
          params: {'country_code': countryCode, 'phone_number': phoneNumber});

      LoginResponse data = LoginResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return LoginResponse(status: false, message: e.toString());
    }
  }

  Future<CountryResponse> getCountries() async {
    try {
      http.Response response =
          await _apiService.apiRequest(endPoint: 'countries', postRequest: false);

      CountryResponse data =
          CountryResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return CountryResponse(status: false, message: e.toString());
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
      String userId = AppStorage().getUserId();
      Map<String,dynamic> params = {};

      if (userId == ""){
        params.addAll({'country_code': countryCode,
            'phone_number': phoneNumber,
            'otp': otp
        });
      }else{
        params.addAll({'country_code': countryCode,
          'phone_number': phoneNumber,
          'otp': otp,
          'user_id':userId});
      }

      http.Response response =
      await _apiService.apiRequest(
        endPoint: 'verify_otp',
        params: params
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
