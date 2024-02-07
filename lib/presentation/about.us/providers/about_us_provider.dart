import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../infrastructure/dal/models/about_us/about_us_model.dart';
import '../../../infrastructure/dal/services/api_service.dart';
import '../about_us_model.dart';

class AboutUsProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return AboutUs.fromJson(map);
      if (map is List)
        return map.map((item) => AboutUs.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  // Future<AboutUs?> getAboutUs() async {
  //   // final response = await get('aboutus/$id');
  //   // return response.body;
  //   print("getAboutUs Called");
  //   String data = await DefaultAssetBundle.of(Get.context!)
  //       .loadString(Assets.jsonAboutUs);
  //   final AboutUs jsonResult = AboutUs.fromJson(jsonDecode(data));
  //   print("AboutUs Repository: data:${jsonResult.toJson()}");
  //   return jsonResult;
  // }


  Future<AboutUsModel> getAboutUs() async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'get_CMS_content?slug=about-us',postRequest: false);
      AboutUsModel data =
      AboutUsModel.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return AboutUsModel(status: false, message: e.toString());
    }
  }

  Future<Response<AboutUs>> postAboutUs(AboutUs aboutus) async =>
      await post('aboutus', aboutus);

  Future<Response> deleteAboutUs(int id) async => await delete('aboutus/$id');
}