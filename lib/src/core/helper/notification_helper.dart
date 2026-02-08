import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../../features/restaurant/restaurant.dart';

final selectNotificationSubject = BehaviorSubject<String>();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse details) {
  if (details.payload != null) {
    selectNotificationSubject.add(details.payload!);
  }
}

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          selectNotificationSubject.add(details.payload!);
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    List<RestaurantItemEntity> restaurants,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      '1',
      'channel_01',
      channelDescription: 'recommended restaurant channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    final restaurant = restaurants[Random().nextInt(restaurants.length)];

    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: 'Jam Makan Telah Tiba! Yuk Cek Rekomendasi Restoran Ini',
      body: '${restaurant.name} di ${restaurant.city}',
      notificationDetails: platformDetails,
      payload: restaurant.id.toString(),
    );
  }
}
