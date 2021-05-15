//-------------------Pref Keys--------------------------

import 'package:flutter/material.dart';

import '../common_imports.dart';


class PrefKeys {
  static const SET_SELECTED_LANGUAGE = 'SET_SELECTED_LANGUAGE';
  static const LOGOUT = 'LOGOUT';
  static const USER_INFO = 'USER_INFO';
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const AUTHENTICATION = 'AUTHENTICATION';
  static const USER_ID = "USER_ID";
  static const USER_EMAIL = "USER_EMAIL";
  static const USER_MODEL = 'USER_MODEL';
  static const GENDER = "GENDER";
  static const USER_NAME = "USER_NAME";
  static const COMPANY_ID = "COMPANY_ID";
  static const COMPANY_NAME = "COMPANY_NAME";
  static const USER_DATA = "USER_DATA";

  static const DEVICE_ID = "DEVICE_ID";
  static const EMAIL = "EMAIL";
  static const FIREBASE_NOTIFICATION_ID = "FIREBASE_NOTIFICATION_ID";
  static const PINCODE = "PINCODE";
  static const API_TOKEN = "API_TOKEN";
  static const FIREBASE_NOTIFICATION_TOKEN = 'FIREBASE_NOTIFICATION_TOKEN';
  static const LOG_IN_EMAIL = "LOG_IN_EMAIL";
  static const LOG_IN_PASS = "LOG_IN_PASS";
}

final emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

navigateToNamedRoute(BuildContext context, String routeName, [Object arguments]) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
  Navigator.pushNamed(context, routeName, arguments: arguments);
}

pushNamedAndRemoveUntil(BuildContext context, String routeName, String removeUntilRoute, [Object arguments]) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
  //Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  Navigator.pushNamedAndRemoveUntil(context, routeName, ModalRoute.withName(removeUntilRoute));
}

pushNamedAndRemoveAll(BuildContext context, String routeName) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
  Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
}

navigatePop(BuildContext context) {
  Navigator.pop(context);
}

removeTextFieldFocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

ButtonStyle signUpButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: Colors.transparent),
    ),
  ),
);

TextWidget appNameWidget = TextWidget(
  text: 'App Name',
  textAlign: TextAlign.center,
  fontFamily: 'Comfortaa',
  fontWeight: FontWeight.w700,
  textSize: 22,
  color: AppColors.primaryColor,
);
