import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_base_app/src/app/apis/simplified_uri.dart';
import 'package:flutter_base_app/src/app/screens/auth_screens/login_screen.dart';
import 'package:flutter_base_app/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'AppException.dart';
import 'api_config.dart';

class ApiBaseHelper {
  static String baseUrl = BASE_URL;

  static final ApiBaseHelper _singleton = ApiBaseHelper._internal();

  factory ApiBaseHelper() {
    return _singleton;
  }
  SharedPreferences? _sharedPreferences;

  ApiBaseHelper._internal() {
    _init();
  }

  _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  getAddressFromGoogle(
      {required Map<String, dynamic> jsonData,
      required Function(dynamic data) onSucess,
      required Function(dynamic data) onFailure}) async {
    var apiResponse;

    final uri = Uri.https('maps.googleapis.com', 'maps/api/geocode/json', jsonData);
    try {
      final http.Response response = await http.post(
        uri,
        body: jsonEncode(jsonData),
      );

      try {
        apiResponse = _returnResponse(response: response);
        onSucess(apiResponse);
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        onFailure(apiResponse);
      }
    } on SocketException {
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure(jsonData);
      // throw FetchDataException('No Internet connection');
    }
  }

  getApiCall(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Function(dynamic data)? onSucess,
      Function(dynamic data)? onFailure,
      Function(bool loading)? loading,
      SharedPreferences? sharedPreferences}) async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    String? xAuthToken = _sharedPreferences!.getString(PrefKeys.ACCESS_TOKEN);

    if (xAuthToken != null) {
      xAuthToken = 'Bearer ' + xAuthToken;
    }

    var apiResponse;
    log('get -${baseUrl + url}');
    loading?.call(true);

    final Uri uri = SimplifiedUri.uri(baseUrl + url, queryParameters);

    try {
      final http.Response response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': xAuthToken ?? '',
          'deviceType': 'mobile',
        },
      );

      try {
        apiResponse = _returnResponse(response: response);
        loading?.call(false);
        onSucess?.call(apiResponse);
        return apiResponse;
      } on UnauthorisedException {
        loading?.call(false);
        _sharedPreferences!.resetPrefs();
        NavKey.navKey.currentState!.pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        loading?.call(false);
        onFailure?.call(apiResponse);
        return apiResponse;
      } finally {}
    } on SocketException {
      loading?.call(false);
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure?.call(jsonData);
    }
  }

  getFakeApiCall(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Function(dynamic data)? onSucess,
      Function(dynamic data)? onFailure,
      Function(bool loading)? loading,
      SharedPreferences? sharedPreferences}) async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    String? xAuthToken = _sharedPreferences!.getString(PrefKeys.ACCESS_TOKEN);

    if (xAuthToken != null) {
      xAuthToken = 'Bearer ' + xAuthToken;
    }

    var apiResponse;
    log('get -$url');
    loading?.call(true);

    final Uri uri = SimplifiedUri.uri(url, queryParameters);

    try {
      final http.Response response = await http.get(
        uri,
        headers: <String, String>{'app-id': '613ef7c522d11d1ac74534ff'},
      );

      try {
        apiResponse = _returnResponse(response: response);
        loading?.call(false);
        onSucess?.call(apiResponse);
        return apiResponse;
      } on UnauthorisedException {
        loading?.call(false);
        _sharedPreferences!.resetPrefs();
        NavKey.navKey.currentState!.pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        loading?.call(false);
        onFailure?.call(apiResponse);
        return apiResponse;
      } finally {}
    } on SocketException {
      loading?.call(false);
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure?.call(jsonData);
    }
  }

  deleteApiCall(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Function(dynamic data)? onSucess,
      Function(dynamic data)? onFailure,
      Function(bool loading)? loading,
      SharedPreferences? sharedPreferences}) async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    String? xAuthToken = _sharedPreferences!.getString(PrefKeys.ACCESS_TOKEN);

    if (xAuthToken != null) {
      xAuthToken = 'Bearer ' + xAuthToken;
    }

    var apiResponse;
    log('delete -${baseUrl + url}');
    loading?.call(true);

    try {
      final http.Response response = await http.delete(
        Uri.parse(baseUrl + url),
        body: jsonEncode(queryParameters ?? {}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': xAuthToken ?? '',
          'deviceType': 'mobile',
        },
      );

      try {
        apiResponse = _returnResponse(response: response);
        loading?.call(false);
        onSucess?.call(apiResponse);
        return apiResponse;
      } on UnauthorisedException {
        loading?.call(false);
        _sharedPreferences!.resetPrefs();
        NavKey.navKey.currentState!.pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        loading?.call(false);
        onFailure?.call(apiResponse);
        return apiResponse;
      } finally {}
    } on SocketException {
      loading?.call(false);
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure?.call(jsonData);
    }
  }

  postApiCall(
      {required String url,
      Map<String, dynamic>? jsonData,
      Function(dynamic data)? onSucess,
      Function(dynamic data)? onFailure,
      Function(bool loading)? loading}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? xAuthToken = prefs.getString(PrefKeys.ACCESS_TOKEN);

    if (xAuthToken != null) {
      xAuthToken = 'Bearer ' + xAuthToken;
    }

    var apiResponse;
    log('post -${baseUrl + url}');
    loading?.call(true);

    try {
      final http.Response response = await http.post(
        Uri.parse(baseUrl + url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': xAuthToken ?? '',
        },
        body: jsonEncode(jsonData),
      );

      try {
        apiResponse = _returnResponse(response: response);
        onSucess?.call(apiResponse);
        return apiResponse;
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        onFailure?.call(apiResponse);
        return apiResponse;
      } finally {
        loading?.call(false);
      }
    } on SocketException {
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure?.call(jsonData);
      // throw FetchDataException('No Internet connection');
    }
  }

  putApiCall(
      {required String url,
      required Map<String, dynamic> jsonData,
       Function(dynamic data)? onSucess,
       Function(dynamic data)? onFailure,
      Function(bool isLoading)? loading}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? xAuthToken = prefs.getString(PrefKeys.ACCESS_TOKEN);

    if (xAuthToken != null) {
      xAuthToken = 'Bearer ' + xAuthToken;
    }

    var apiResponse;
    log('put -${baseUrl + url}');
    try {
      final http.Response response = await http.put(
        Uri.parse(baseUrl + url),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': xAuthToken ?? '',
          'web': 'web',
          'deviceToken': '',
        },
        body: jsonEncode(jsonData),
      );

      try {
        apiResponse = _returnResponse(response: response);
        onSucess?.call(apiResponse);
      } catch (e) {
        apiResponse = json.decode(response.body.toString());
        onFailure?.call(apiResponse);
      }
    } on SocketException {
      Map<String, String> jsonData = {'message': 'No Internet connection'};
      await Future.delayed(const Duration(seconds: 2));
      onFailure?.call(jsonData);
      // throw FetchDataException('No Internet connection');
    }
  }

  callMultipartApi(
      {required String apiName,
      required Map<String, String> requestBody,
      Map<String, String>? headers,
      File? image,
      String? fileParamName,
      String? requestType,
       Function(dynamic onSucessJson)? onSucess,
       Function(dynamic onFailureJson)? onFailure,
       Function(bool isLoading)? loading}) async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }

    String? xAuthToken = _sharedPreferences!.getString(PrefKeys.ACCESS_TOKEN);

    if (xAuthToken != null) {
      xAuthToken = 'Bearer ' + xAuthToken;
    }

    loading?.call(true);
    var request = http.MultipartRequest(requestType ?? 'POST', Uri.parse(BASE_URL + apiName));
    request.headers.addAll(headers ??
        <String, String>{
          'Content-Type': 'multipart/form-data',
          'authorization': xAuthToken ?? '',
        });
    if (fileParamName != null && image != null) {
      request.files.add(http.MultipartFile(fileParamName, image.readAsBytes().asStream(), image.lengthSync(),
          filename: image.path.split("/").last));
    }

    request.fields.addAll(requestBody);
    var apiResponse;

    http.Response response = await http.Response.fromStream(await request.send());
    try {
      apiResponse = _returnResponse(response: response);
      loading?.call(false);

      onSucess?.call(apiResponse);
    } catch (e) {
      apiResponse = json.decode(response.body.toString());
      loading?.call(false);

      onFailure?.call(apiResponse);
    } finally {
      loading?.call(false);
    }

    return apiResponse;
  }

  dynamic _returnResponse({required http.Response response}) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        // log(responseJson.toString());
        return responseJson;
      case 201:
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
