import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/core.dart';
import '../di/app_injection.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> bootstrap({bool isTest = false}) async {
  final NotificationHelper notificationHelper = NotificationHelper();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await injection();

  if (!isTest) {
    await workManagerInstance.initialize(callbackDispatcher);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  }
}
