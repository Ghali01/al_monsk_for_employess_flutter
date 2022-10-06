import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotifications {
  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void init() async {
    await localNotificationsPlugin.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')));
  }

  static void send(String title, String text) async {
    await localNotificationsPlugin.show(
        Random().nextInt(10000),
        title,
        text,
        const NotificationDetails(
            android: AndroidNotificationDetails('ch1', 'ch1',
                importance: Importance.max)));
  }
}
