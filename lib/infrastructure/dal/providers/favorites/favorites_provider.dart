import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;
import '../../models/base/CommonResponse.dart';

class FavoriteProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

Future<CommonResponse> getFavoritesList() async {
  //model not added
  try {
    http.Response response =
    await _apiService.apiRequest(endPoint: 'get_favorites');
    CommonResponse data =
    CommonResponse.fromJson(json.decode(response.body));
    return data;
  } catch (e) {
    debugPrint("Api issue in provider : ${e.toString()}");
    return CommonResponse(status: false, message: e.toString());
  }
}

  Future<CommonResponse> removeOrAddFavoritesListItem({required String favoriteId ,required String stationId}) async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'add_or_remove_favorite',
          params: {
            'station_id': stationId,
            'is_favorite': favoriteId,
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
