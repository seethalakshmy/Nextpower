import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/base/CommonResponse.dart';
import 'package:project/infrastructure/dal/models/profile/ProfileResponse.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:project/infrastructure/storage/app_storage.dart';

class ProfileProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<ProfileResponse> getProfile() async {
    try {
      http.Response response =
      await _apiService.apiRequest(url: 'get_profile', postRequest: false);

      ProfileResponse data =
      ProfileResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return ProfileResponse(status: false, message: e.toString());
    }
  }

  Future<CommonResponse> updateProfile({required String name,required String email}) async {
    String userId = AppStorage().getUserId();
    try {
      http.Response response =
      await _apiService.apiRequest(url: 'update_profile',
          params: {
            'user_id': userId,
            'name': name,
            'email': email,
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
