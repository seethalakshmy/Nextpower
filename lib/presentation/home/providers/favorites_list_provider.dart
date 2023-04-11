import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';

import '../models/favorites_list_model.dart';

class FavoritesListProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return FavoritesList.fromJson(map);
      if (map is List)
        return map.map((item) => FavoritesList.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<FavoritesList?> getFavoritesList() async {
    // final response = await get('favoriteslist/$id');
    // return response.body;
    print("getFavoritesList Called");
    String data = await DefaultAssetBundle.of(Get.context!)
        .loadString(Assets.jsonFavoritesList);
    final FavoritesList jsonResult = FavoritesList.fromJson(jsonDecode(data));
    print("FavoritesList Repository: data:${jsonResult.toJson()}");
    return jsonResult;
  }

  Future<Response<FavoritesList>> postFavoritesList(
          FavoritesList favoriteslist) async =>
      await post('favoriteslist', favoriteslist);

  Future<Response> deleteFavoritesList(int id) async =>
      await delete('favoriteslist/$id');
}