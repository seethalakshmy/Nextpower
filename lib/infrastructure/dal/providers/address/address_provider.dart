import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/address/AddressResponse.dart';
import 'package:project/infrastructure/dal/models/base/CommonResponse.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/models/login/LoginResponse.dart';
import 'package:project/infrastructure/dal/models/states/StatesResponse.dart';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;

class AddressProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<CommonResponse> addAddress(
      {
        required String addressline2,
        required String addressline1,
        required String city,
        required String stateId,
        required String postalCode,
        required String countryId,
        required String companyName,
        required String gstNo,
      }) async {
    try {
      http.Response response = await _apiService.apiRequest(
          endPoint: 'add_saved_address',
          params: {
            'address_line1': addressline1,
            'address_line2': addressline2,
            'city': city,
            'state_id': stateId,
            'postal_code': postalCode,
            'country_id': countryId,
            'company_name': companyName,
            'gst_no': gstNo,
          }
      );

      CommonResponse data = CommonResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return CommonResponse(status: false, message: e.toString());
    }
  }

  Future<AddressResponse> getAddress() async {
    try {
      http.Response response =
          await _apiService.apiRequest(endPoint: 'get_saved_address', postRequest: false);

      AddressResponse data =
      AddressResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return AddressResponse(status: false, message: e.toString());
    }
  }

  Future<StatesResponse> getStates({required String countryId}) async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'states',
        params: {
        'country_id':countryId
        }
      );

      StatesResponse data =
      StatesResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return StatesResponse(status: false, message: e.toString());
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
}
