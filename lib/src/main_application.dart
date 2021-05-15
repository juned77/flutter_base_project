import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'shelf.dart';
import 'app/screens/splash.dart';

import 'routes/custom_router.dart';

class MainApplication extends StatefulWidget {
  @override
  _MainApplicationState createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication> {
  // final FirebaseServices _firebaseService = locator<FirebaseServices>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    startUpLogic();
    return MaterialApp(
      title: 'Authentication App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        backgroundColor: Colors.white,
        fontFamily: FontStyles.fontName,
        appBarTheme: AppBarTheme(
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      initialRoute: SplashScreen.id,
      onGenerateRoute: CustomRouter.generateRoute,
    );
  }

  startUpLogic() async {
    // _firebaseService.initialise();
  }
}
