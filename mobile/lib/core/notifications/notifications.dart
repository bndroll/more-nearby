import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
late AndroidNotificationChannel _androidNotificationChannel;



bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  _androidNotificationChannel = const AndroidNotificationChannel(
    'custom_high_important_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  if(Platform.isAndroid) {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  const android = AndroidInitializationSettings('@mipmap/launcher_icon');
  final ios = DarwinInitializationSettings(
      notificationCategories: [
        DarwinNotificationCategory(
            'leave',
            actions: [
              DarwinNotificationAction.plain('0', 'Нет', options: {DarwinNotificationActionOption.foreground}),
              DarwinNotificationAction.plain('1', 'Да', options: {DarwinNotificationActionOption.foreground}),
            ]
        ),
        const DarwinNotificationCategory('chats'),
        const DarwinNotificationCategory('messages')
      ]
  );
  final settings = InitializationSettings(android: android, iOS: ios);
  await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: (_) {},
      onDidReceiveNotificationResponse: (_) {}
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> initNotifications() async {
  await setupFlutterNotifications();

}
