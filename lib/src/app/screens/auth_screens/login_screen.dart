import 'dart:ui';

import 'package:flutter_base_app/src/app/common/custom_text_field.dart';
import 'package:flutter_base_app/src/app/common/progress_dialog.dart';
import 'package:flutter_base_app/src/app/common/text_widget.dart';
import 'package:flutter_base_app/src/app/screens/auth_screens/auth_models.dart';
import 'package:flutter_base_app/src/app/screens/auth_screens/password_recovery.dart';
import 'package:flutter_base_app/src/res/app_colors.dart';
import 'package:flutter_base_app/src/utils/constants.dart';
import 'package:flutter/material.dart';



class LoginScreen extends StatefulWidget {
  static const String id = '/LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier errorStringNotifier = ValueNotifier('');
  LoginModel loginModel = LoginModel();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 60),
                              appNameWidget,
                              SizedBox(height: 92),
                              ValueListenableBuilder(
                                valueListenable: errorStringNotifier,
                                builder: (context, value, child) {
                                  return Container(
                                    // color: Colors.grey[300],
                                    constraints: BoxConstraints(minHeight: 30),
                                    child: TextWidget(
                                      text: '$value',
                                      color: AppColors.roman,
                                      textAlign: TextAlign.center,
                                      textSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                              CustomTextField(
                                labelText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                maxLength: 30,
                                obscureText: false,
                                onChanged: (String string) {
                                  loginModel.userEmail = string;
                                },
                              ),
                              SizedBox(height: 24),
                              CustomTextField(
                                maxLength: 30,
                                labelText: 'Password',
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                isPasswordVisiblityEnable: true,
                                onChanged: (String string) {
                                  loginModel.userPassword = string;
                                },
                              ),
                              SizedBox(height: 36),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: signUpButtonStyle,
                                  onPressed: () {
                                    // navigateToNamedRoute(context, MainScreen.id);
                                    if (validation(loginModel)) {
                                      errorStringNotifier.value = '';
                                      removeTextFieldFocus(context);
                                      showProgressDialog(context);
                                      // authRepo.loginUser(loginModel, context, errorStringNotifier);
                                    }
                                  },
                                  child: TextWidget(
                                    text: 'Log In',
                                    color: Colors.white,
                                    textSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              // SizedBox(height: 8),
                              TextButton(
                                onPressed: () {
                                  navigateToNamedRoute(context, PasswordRecovery.id);
                                },
                                child: TextWidget(
                                  textAlign: TextAlign.center,
                                  text: 'Forgot your password?',
                                  color: AppColors.lightForestGreen,
                                  textSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(child: Divider(color: AppColors.frenchGrey)),
                                  TextWidget(
                                    text: 'OR',
                                    textSize: 16,
                                    padding: EdgeInsets.symmetric(horizontal: 26),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Expanded(child: Divider(color: AppColors.frenchGrey)),
                                ],
                              ),
                              SizedBox(height: 19),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Colors.grey[200]),
                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: AppColors.cloudBurst),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    // authRepo.signInWithApple(context);
                                  },
                                  child: TextWidget(
                                    text: 'Continue with Apple',
                                    color: AppColors.martinique,
                                    textSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppColors.bleuDeFrance),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showProgressDialog(context);
                                    // authRepo.signInWithGoogle(context);
                                  },
                                  child: TextWidget(
                                    text: 'Continue with Google',
                                    color: Colors.white,
                                    textSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 36),
                            TextWidget(
                              text: 'Don’t have an account yet?',
                              textSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            InkWell(
                              onTap: () {
                                navigatePop(context);
                              },
                              child: TextWidget(
                                text: 'Sign up',
                                textSize: 16,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 36),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool validation(LoginModel loginModel) {
    var regExp = new RegExp(emailPattern);
    if (loginModel.userEmail == null || loginModel.userEmail.isEmpty) {
      // showSnackBar('Please enter email', context);
      errorStringNotifier.value = 'Please enter email';
      return false;
    } else if (!regExp.hasMatch(loginModel.userEmail)) {
      // showSnackBar('Please enter valid mail address', context);
      errorStringNotifier.value = 'Please enter valid mail address';
      return false;
    } else if (loginModel.userPassword == null || loginModel.userPassword.isEmpty) {
      // showSnackBar('Please enter pasword', context);
      errorStringNotifier.value = 'Please enter pasword';
      return false;
    } else {
      return true;
    }
  }
}
