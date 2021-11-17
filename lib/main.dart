import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/app/services/push_notification_service.dart';
import 'src/main_application.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await PushNotificationService().setupInteractedMessage();
    runApp(MainApplication());
  }, (error, stack) {
    print('main error - $error');
    print('main stack - $stack');
  }, zoneSpecification: ZoneSpecification());
}
