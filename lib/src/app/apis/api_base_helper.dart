import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/app/common/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'AppException.dart';
import 'api_config.dart';

class ApiBaseHelper {
  static String baseUrl = BASE_URL;
  Future<dynamic> getApiCall(String url) async {
    var responseJson;
    log('get -${baseUrl + url}');
    try {
      final response = await http.get(Uri.parse(baseUrl + url), headers: <String, String>{
        'x-api-key': 'FdTRZTbNLC1B',
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteApiCall(String url) async {
    var responseJson;
    log('delete -${baseUrl + url}');
    try {
      final response = await http.delete(Uri.parse(baseUrl + url), headers: <String, String>{});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postApiCall(String url, Map<String, dynamic> jsonData) async {
    var responseJson;
    /* SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(PrefKeys.AUTHENTICATION);
    var userId = prefs.getString(PrefKeys.USER_ID); */
    log('post -${baseUrl + url}');
    try {
      final http.Response response = await http.post(
        Uri.parse(baseUrl + url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(jsonData),
      );

      try {
        responseJson = _returnResponse(response);
      } catch (e) {
        // prefs.setBool(PrefKeys.IS_LOGGED_IN, false);

        // locator<NavigationService>().pushNamedAndRemoveUntil(LoginScreen.id);
      }
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> putApiCall(String url, Map<String, dynamic> jsonData) async {
    var responseJson;
    log('put -${baseUrl + url}');
    try {
      final http.Response response = await http.put(
        Uri.parse(baseUrl + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );

      try {
        responseJson = _returnResponse(response);
      } catch (e) {
        // prefs.setBool(PrefKeys.IS_LOGGED_IN, false);

        // locator<NavigationService>().pushNamedAndRemoveUntil(LoginScreen.id);
      }
    } on SocketException {
      // throw FetchDataException('No Internet connection');
      responseJson = {"message": "No Internet connection"};
    }
    return responseJson;
  }

  Future<dynamic> callMultipartApi(
      {BuildContext context, String apiName, Map<String, String> requestBody, File image, String fileName}) async {
    print(requestBody);

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          BASE_URL + apiName,
        ));

    if (image != null) {
      request.files.add(http.MultipartFile(fileName ?? 'file', image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    }

    request.fields.addAll(requestBody);

    showProgressDialog(context);

    http.Response response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: jsonDecode(response.body)['message']);
      print(response.body);
      return jsonDecode(response.body);
    } else if (response.statusCode == 202 || response.statusCode == 401) {
      print(response.body);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(jsonDecode(response.body)['message']),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // log(responseJson.toString());
        return responseJson;
      case 400:
        // throw BadRequestException(response.body.toString());
        var responseJson = json.decode(response.body.toString());
        // log(responseJson.toString());
        return responseJson;
      case 401:
        var responseJson = json.decode(response.body.toString());
        // log(responseJson.toString());
        return responseJson;
      case 403:
        // throw UnauthorisedException(response.body.toString());
        var responseJson = json.decode(response.body.toString());
        // log(responseJson.toString());
        return responseJson;
      case 404:
        var responseJson = json.decode(response.body.toString());

        return responseJson;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
