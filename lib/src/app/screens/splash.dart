import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/res/app_colors.dart';
import 'package:flutter_base_app/src/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screens/signup_screen.dart';
import 'main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    goToNext(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }

  goToNext(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool(PrefKeys.IS_LOGGED_IN);
    // String userName = prefs.getString(PrefKeys.USER_NAME);
    // String userCompanyName = prefs.getString(PrefKeys.COMPANY_NAME);
    // int userCompanyId = prefs.getInt(PrefKeys.COMPANY_ID);

    if (isLogin != null && isLogin) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
      /* Future.delayed(Duration(milliseconds: 500)).then((value) {
        Navigator.pushReplacementNamed(context, MainScreen.id);
      });*/
    } else {
      Navigator.pushReplacementNamed(context, SignUpScreen.id);
      /* Future.delayed(Duration(milliseconds: 500)).then((value) {
        Navigator.pushReplacementNamed(context, SignUpScreen.id);
      });*/
    }
    /* Future.delayed(Duration(milliseconds: 500)).then((value) {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }); */
  }
}
