

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';

class LoginProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<LoginResponse> login({required String phoneNumber}) async {
    try{
      final response = await _apiService.apiRequest(
        url: 'sign_in',
        params: {
          'country_code':'91',
          'phone_number' : phoneNumber
        }
      );

      LoginResponse data = LoginResponse.fromJson(response);
      return data;
    }catch(e){
      return LoginResponse(status: false,message: e.toString());
    }

  }

}