import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:commzy/src/data/error/failure.dart';
import 'package:commzy/src/data/network/base_service_api.dart';
import 'package:commzy/src/models/error/error_model.dart';
import 'package:http/http.dart' as http;

class NetworkServiceApi extends BaseServiceApi {
  dynamic apiResponse(http.Response response) {
    var res = ErrorModel();
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      default:
        throw Failure(
          (res.fatal == null || res.fatal! == false)
              ? '${res.message.toString()} - status code: ${response.statusCode}'
              : 'Server is busy.Please try again later.',
        );
    }
  }

  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      var response = await http.get(Uri.parse(url));
      jsonResponse = apiResponse(response);
    } on SocketException {
      throw InternetException(
        'No Internet.Please check your internet connection.',
      );
    } on TimeoutException catch (error) {
      throw RequestTimeOut(error.message);
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> postApi(String url, data) async {
    dynamic jsonResponse;
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      jsonResponse = apiResponse(response);
    } on SocketException {
      throw InternetException(
        'No Internet.Please check your internet connection.',
      );
    } on TimeoutException catch (error) {
      throw RequestTimeOut(error.message);
    }
    return jsonResponse;
  }
}
