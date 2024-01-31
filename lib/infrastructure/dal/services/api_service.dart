import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  Future<dynamic> apicall(
  {required String url,bool postRequest = true,Map<String, dynamic>? params}
      ) async{
    debugPrint("URL:${baseUrl + url}");
    debugPrint("\n-----REQUEST PARAMS-------\n$params");
    updateToken();
    late http.Response res;
    try{

      if(postRequest){
        res = await http.post(Uri.parse(baseUrl + url),
            body: jsonEncode(params), headers: _headers);
      }else{
        res = await http.get(Uri.parse(baseUrl + url), headers: _headers);
      }




    } on SocketException catch (e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } catch (e) {
      throw Exception("Something Went Wrong");
    }


  }

  void updateToken(){
    //if login
  }

  Future<dynamic> apiRequest(
      {required String url,
      Method? method = Method.POST,
      Map<String, dynamic>? params}) async {
    debugPrint(baseUrl + url);
    debugPrint("\n-----params-------\n$params");
    Response response;
    try {
      if (method == Method.POST) {
        response = await post(baseUrl + url, params);
      }else {
        response = await get(baseUrl + url, headers: _headers);
      }

      debugPrint(
          "\n ----Response---- \n status code : ${response.statusCode}\n body : ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something Went Wrong");
      }
    } on SocketException catch (e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  updateHeaders() {
    _headers['Authorization'] = '';
  }
}
