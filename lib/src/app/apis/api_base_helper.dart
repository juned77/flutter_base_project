import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_base_app/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'AppException.dart';
import 'api_config.dart';

class ApiBaseHelper {
  static String baseUrl = BASE_URL;
  late SharedPreferences sharedPreferences;

  static final ApiBaseHelper _singleton = ApiBaseHelper._internal();

  factory ApiBaseHelper() {
    return _singleton;
  }

  ApiBaseHelper._internal() {
    init();
  }

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<dynamic> getApiCall(String url) async {
    var responseJson;
    log('get -${baseUrl + url}');
    try {
      final response = await http.get(Uri.parse(baseUrl + url), headers: <String, String>{
        'x-api-key': 'FdTRZTbNLC1B',
      });
      responseJson = _returnResponse(response: response);
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
      responseJson = _returnResponse(response: response);
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
        responseJson = _returnResponse(response: response);
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
        responseJson = _returnResponse(response: response);
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

  callMultipartApi(
      {required String apiName,
      required Map<String, String> requestBody,
      File? image,
      String? fileParamName,
      required Function(dynamic data) onSucess,
      required Function(dynamic data) onFailure,
      required Function(bool loading) loading}) async {
    String? xAuthToken = sharedPreferences.getString(PrefKeys.AUTH_TOKEN);

    loading(true);
    var request = http.MultipartRequest('POST', Uri.parse(BASE_URL + apiName));
    request.headers.addAll(<String, String>{
      'Content-Type': 'multipart/form-data',
      'authorization': xAuthToken ?? '',
      'deviceType': 'mobile',
    });
    if (fileParamName != null || image != null) {
      request.files.add(http.MultipartFile(fileParamName!, image!.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    }

    request.fields.addAll(requestBody);
    var apiResponse;

    http.Response response = await http.Response.fromStream(await request.send());
    try {
      apiResponse = _returnResponse(response: response);

      onSucess(apiResponse);
    } catch (e) {
      apiResponse = json.decode(response.body.toString());

      onFailure(apiResponse);
    } finally {
      loading(false);
    }
  }

  dynamic _returnResponse({required http.Response response}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // log(responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());

      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw ForbiddenException(response.body.toString());

      case 404:
        throw NotFoundException(response.body.toString());
      case 500:
        throw InternalServerErrorException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
