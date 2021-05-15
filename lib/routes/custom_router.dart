import 'package:flutter_base_app/src/app/screens/auth_screens/login_screen.dart';
import 'package:flutter_base_app/src/app/screens/auth_screens/password_recovery.dart';
import 'package:flutter_base_app/src/app/screens/auth_screens/signup_screen.dart';
import 'package:flutter_base_app/src/app/screens/main_screen/main_screen.dart';
import 'package:flutter_base_app/src/app/screens/splash.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.id:
        return MaterialPageRoute(
          builder: (_) {
            return SplashScreen();
          },
        );
      case SignUpScreen.id:
        return MaterialPageRoute(
          builder: (_) {
            return SignUpScreen();
          },
        );
      case LoginScreen.id:
        return MaterialPageRoute(
          builder: (_) {
            return LoginScreen();
          },
        );
      case PasswordRecovery.id:
        return MaterialPageRoute(
          builder: (_) {
            return PasswordRecovery();
          },
        );
      case MainScreen.id:
        return MaterialPageRoute(
          builder: (_) {
            return MainScreen();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
