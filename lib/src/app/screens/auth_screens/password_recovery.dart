import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/app/common/custom_text_field.dart';
import 'package:flutter_base_app/src/app/common/progress_dialog.dart';

import 'package:flutter_base_app/src/utils/constants.dart';

import '../../../common_imports.dart';
import 'auth_models.dart';

class PasswordRecovery extends StatefulWidget {
  static const String id = '/PasswordRecovery';
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  ValueNotifier errorStringNotifier = ValueNotifier('');
  LoginModel loginModel = LoginModel();

  bool linkSent = false;
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 36),
                            TextWidget(
                              text: 'Password Recovery',
                              color: AppColors.martinique,
                              textSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 56),
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
                            TextWidget(
                              text: 'Enter your account email',
                              textSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.martinique,
                            ),
                            SizedBox(height: 12),
                            CustomTextField(
                              controller: emailController,
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              maxLength: 30,
                              obscureText: false,
                              onChanged: (string) {
                                loginModel.userEmail = string;
                              },
                            ),
                            SizedBox(height: 36),
                            SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                style: signUpButtonStyle,
                                onPressed: () {
                                  if (validation(loginModel)) {
                                    errorStringNotifier.value = '';
                                    removeTextFieldFocus(context);
                                    showProgressDialog(context);
                                  }
                                },
                                child: TextWidget(
                                  text: 'Submit',
                                  color: Colors.white,
                                  textSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 36),
                            Visibility(
                              visible: linkSent,
                              // visible: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Recovery link sent!',
                                    textSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColor,
                                  ),
                                  TextWidget(
                                    text: 'Please check your email now for the password recovery link.',
                                    textSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.martinique,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            navigatePop(context);
                          },
                          child: Column(
                            children: [
                              TextWidget(
                                text: 'Remember your password?',
                                textSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              TextWidget(
                                text: 'Go back',
                                textSize: 16,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 36),
                            ],
                          ),
                        )
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
    } else {
      return true;
    }
  }
}
