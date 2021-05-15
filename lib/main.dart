import 'dart:async';

import 'package:flutter/material.dart';

import 'main_application.dart';
import 'src/app/services/locator.dart';

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
