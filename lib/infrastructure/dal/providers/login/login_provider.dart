

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/login/login_model.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';

class LoginProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<LoginModel> login({required String phoneNumber}) async {
    try{
      final response = await _apiService.reqst(
        url: 'users',
        params: {
          'name':'morpheus',
          'job' : 'leader'
        }
      );

      LoginModel data = LoginModel.fromJson(response);
      return data;
    }catch(e){
      return LoginModel(statu: false,messag: "Something went wrong\n$e");
    }

  }

}