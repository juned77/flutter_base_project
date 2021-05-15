import 'dart:async';

import 'package:flutter_base_app/main_application.dart';

import 'package:flutter/material.dart';
import 'package:flutter_base_app/src/app/services/locator.dart';

void main() {
  runZonedGuarded(() async {
    setupLocator();
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MainApplication());
  }, (error, stack) {
    print('main error - $error');
    print('main stack - $stack');
  }, zoneSpecification: ZoneSpecification());
}
