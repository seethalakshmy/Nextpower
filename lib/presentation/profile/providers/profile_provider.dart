import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/profile_model.dart';

class ProfileProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Profile.fromJson(map);
      if (map is List)
        return map.map((item) => Profile.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Profile> getProfile(int id) async {
    // final response = await get('profile/$id');
    // return response.body;
    print("getProfileCalled");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonProfile);
    final Profile jsonResult = Profile.fromJson(jsonDecode(data));
    print("Profile Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<Profile>> postProfile(Profile profile) async =>
      await post('profile', profile);

  Future<Response> deleteProfile(int id) async => await delete('profile/$id');
}