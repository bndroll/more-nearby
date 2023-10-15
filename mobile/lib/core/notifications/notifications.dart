import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
late AndroidNotificationChannel _androidNotificationChannel;

handleBackgroundNessgaes(NotificationResponse s){}

handleLocalMEssgaes(NotificationResponse ew){}

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

  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
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
      onDidReceiveBackgroundNotificationResponse: handleBackgroundNessgaes,
      onDidReceiveNotificationResponse: handleLocalMEssgaes
  );
  isFlutterLocalNotificationsInitialized = true;
}

Future<void> initNotifications() async {
  await setupFlutterNotifications();

}

Future<void> showNotification(
    {
      String? title,
      String? text,
      StyleInformation? styleInformation,
      Duration cancelAfter = const Duration(minutes: 20),
      List<AndroidNotificationAction> actions = const []
    }) async {
    _flutterLocalNotificationsPlugin.show(
        title.hashCode,
        title,
        text,
        NotificationDetails(
            android: AndroidNotificationDetails(
                _androidNotificationChannel.id,
                _androidNotificationChannel.name,
                channelDescription: _androidNotificationChannel.description,
                styleInformation: styleInformation,
                timeoutAfter: cancelAfter.inMilliseconds,
                actions: actions
            ),
        ),
    );
  }
