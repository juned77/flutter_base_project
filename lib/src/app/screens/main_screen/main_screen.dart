

import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/app/common/text_widget.dart';
import 'package:flutter_base_app/src/app/screens/auth_screens/signup_screen.dart';
import 'package:flutter_base_app/src/res/app_colors.dart';
import 'package:flutter_base_app/src/utils/constants.dart';

class MainScreen extends StatefulWidget {
  static const String id = '/MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String email;

  @override
  void initState() {
    email = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 60),
                  appNameWidget,
                  SizedBox(height: 84),
                  TextWidget(
                    text: 'Welcome,',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w300,
                    textSize: 28,
                    color: AppColors.martinique,
                  ),
                  SizedBox(height: 8),
                  TextWidget(
                    text: '$email',
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w300,
                    textSize: 16,
                    color: AppColors.martinique,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: signUpButtonStyle,
                      onPressed: () {
                        pushNamedAndRemoveUntil(context, SignUpScreen.id, MainScreen.id);
                      },
                      child: TextWidget(
                        text: 'Log out',
                        color: Colors.white,
                        textSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 72),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
