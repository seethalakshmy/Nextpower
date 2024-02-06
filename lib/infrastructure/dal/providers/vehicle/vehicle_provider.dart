import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/base/CommonResponse.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleDetailsResponse.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleListResponse.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleMakersResponse.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleModelsResponse.dart';
import 'dart:convert';
import 'package:project/infrastructure/dal/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:project/infrastructure/storage/app_storage.dart';

class VehicleProvider extends GetConnect {
  final ApiService _apiService = Get.find<ApiService>();

  Future<VehicleListResponse> getVehicleList() async {
    String userId = AppStorage().getUserId();
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'vehicles', postRequest: false,
      params: {
          'id': userId
          });

      VehicleListResponse data =
      VehicleListResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return VehicleListResponse(status: false, message: e.toString());
    }
  }

  Future<VehicleDetailsResponse> getVehicleDetails({required String vehicleId}) async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'get_vehicle', postRequest: false,
          params: {
            'id': vehicleId
          });

      VehicleDetailsResponse data =
      VehicleDetailsResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return VehicleDetailsResponse(status: false, message: e.toString());
    }
  }

  Future<CommonResponse> addVehicle({required String vehicleNumber,required String vehicleModel,required String vehicleMake}) async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'add_vehicle',
          params: {
            'vehicle_number': vehicleNumber,
            'vehicle_model_id': vehicleModel,
            'vehicle_make_id': vehicleMake,
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

  Future<VehicleMakersResponse> getVehicleMakersList() async {
    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'get_vehicle_makers', postRequest: false,);

      VehicleMakersResponse data =
      VehicleMakersResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return VehicleMakersResponse(status: false, message: e.toString());
    }
  }

  Future<VehicleModelsResponse> getVehicleModelsList({required String makerId}) async {

    try {
      http.Response response =
      await _apiService.apiRequest(endPoint: 'get_vehicle_models', postRequest: false,
          params: {
            'id': makerId
          });

      VehicleModelsResponse data =
      VehicleModelsResponse.fromJson(json.decode(response.body));
      return data;
    } catch (e) {
      debugPrint("Api issue in provider : ${e.toString()}");
      return VehicleModelsResponse(status: false, message: e.toString());
    }
  }
}
