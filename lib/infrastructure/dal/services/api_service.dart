import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/storage/app_storage.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiService extends GetConnect implements GetxService {
  final String baseUrl;
  late Map<String, String> _headers;

  ApiService({required this.baseUrl}) {
    _headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'grant_type': 'client_credentials',
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Credentials": "true",
      // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
  }

  Future<dynamic> apiRequest(
      {required String endPoint,
      bool postRequest = true,
      Map<String, dynamic>? params}) async {
    debugPrint("\nURL:${baseUrl + endPoint}");
    debugPrint("-----REQUEST PARAMS-------\n$params");
    updateToken();
    late http.Response res;
    try {
      if (postRequest) {
        res = await http.post(Uri.parse(baseUrl + endPoint),
            body: jsonEncode(params), headers: _headers);
      } else {
        String totalUrl = "";
        if (params != null && params.isNotEmpty) {
          String queryString = Uri(queryParameters: params).query;
          totalUrl = "${baseUrl + endPoint}?$queryString";
        } else {
          totalUrl = baseUrl + endPoint;
        }
        res = await http.get(Uri.parse(totalUrl), headers: _headers);
      }
      debugPrint(
          '-----RESPONSE:${baseUrl + endPoint} : ${res.statusCode}---\n ${res.body}\n\n');
      if (res.statusCode == 200) {
        return res;
      } else {
        return http.Response(
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
          },
          json.encode({
            'status': false,
            'message': LocaleKeys.internal_server_error.tr
          }),
          500,
        );
      }
    } on SocketException catch (e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  void updateToken() {
    if (AppStorage().getLoggedIn()) {
      _headers['Authorization'] = "Bearer ${AppStorage().getAccessToken()}";
    }
  }
}
