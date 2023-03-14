import 'dart:convert';

import 'package:get/get.dart';

import '../models/registration_model.dart';

class RegistrationProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return RegistrationModel.fromJson(map);
      if (map is List)
        return map.map((item) => RegistrationModel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<RegistrationModel?> getRegistration(int id) async {
    final response = await get('registration/$id');
    return response.body;
  }

  Future<Response<RegistrationModel>> postRegistration(
          RegistrationModel registration) async =>
      await post('registration', registration);

  Future<Response> deleteRegistration(int id) async =>
      await delete('registration/$id');

  register(RegistrationModel model) {
    print(jsonEncode(model));
  }
}