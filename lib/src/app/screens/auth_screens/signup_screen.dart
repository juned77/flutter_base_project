import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_app/src/app/common/custom_text_field.dart';
import 'package:flutter_base_app/src/app/common/progress_dialog.dart';

import 'package:flutter_base_app/src/utils/constants.dart';


import '../../../common_imports.dart';
import 'auth_models.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = '/SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  LoginModel loginModel = LoginModel();

  String globalErrorString = '';
  ValueNotifier errorStringNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              // color: Colors.grey[400],
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
                              isPasswordVisiblityEnable: true,
                              obscureText: true,
                              onChanged: (String string) {
                                loginModel.userPassword = string;
                              },
                            ),
                            SizedBox(height: 36),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: FontStyles.fontName,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                                children: [
                                  TextSpan(text: 'By signing up you agree to '),
                                  TextSpan(text: 'Terms of User ', style: TextStyle(color: AppColors.dodgerBlue)),
                                  TextSpan(text: 'and '),
                                  TextSpan(text: 'Privacy Policy.', style: TextStyle(color: AppColors.dodgerBlue)),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: signUpButtonStyle,
                                onPressed: () {
                                  if (validation(loginModel)) {
                                    errorStringNotifier.value = '';
                                    removeTextFieldFocus(context);
                                    showProgressDialog(context);
                                    // authRepo.registerUser(loginModel, context, errorStringNotifier);
                                  }
                                },
                                child: TextWidget(
                                  text: 'Sign Up',
                                  color: Colors.white,
                                  textSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(child: Divider(color: AppColors.frenchGrey)),
                                TextWidget(
                                  text: 'OR',
                                  textSize: 16,
                                  padding: EdgeInsets.symmetric(horizontal: 26),
                                  fontWeight: FontStyles.medium,
                                ),
                                Expanded(child: Divider(color: AppColors.frenchGrey)),
                              ],
                            ),
                            SizedBox(height: 20),
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
                      // SizedBox(height: 60),
                      Column(
                        children: [
                          SizedBox(height: 36),
                          TextWidget(
                            text: 'Already have a account?',
                            textSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          InkWell(
                            onTap: () {
                              // removeTextFieldFocus(context);
                              navigateToNamedRoute(context, LoginScreen.id);
                            },
                            child: TextWidget(
                              text: 'Login here',
                              textSize: 16,
                              color: AppColors.primaryColor,
                              fontWeight: FontStyles.medium,
                            ),
                          ),
                          SizedBox(height: 36),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
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
    } else if (loginModel.userPassword != null &&
        loginModel.userPassword.isNotEmpty &&
        loginModel.userPassword.length < 6) {
      // showSnackBar('Password must be atleast of 6 character', context);

      errorStringNotifier.value = 'Password must be atleast of 6 character';
      return false;
    } else {
      return true;
    }
  }
}
