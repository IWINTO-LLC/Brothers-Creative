import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../features/notification/notification_screen.dart';

class FirebaseApiController extends GetxController {
  static FirebaseApiController get instance => Get.find();

  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel', 'High Importance Channel',
      description: 'This channel for importance notifications',
      importance: Importance.defaultImportance);
  final _localNotifications = FlutterLocalNotificationsPlugin();
  @override
  void onInit() {
    initNotifications();

    super.onInit();
  }

  RemoteMessage currentMessage = const RemoteMessage();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    final fCMToken = await _firebaseMessaging.getToken();
    if (kDebugMode) {
      print('Token ** $fCMToken');
    }
    initPushNotifications();
    //initLocalNotifications();
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/ic_luncher')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
//android\app\src\main\res\drawable-v21\ic_launcher.png
    const android = AndroidInitializationSettings('@drawable-v21/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _localNotifications.initialize(
      settings,
      //   onSelectNotification: (payload) {}
    );
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    currentMessage = message;
    Get.offAll(() => const NotificationScreen());
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Title:${message.notification?.title}');
      print('body:${message.notification?.body}');
      print('PayLoad:${jsonDecode(message.data as String)['value']}');
    }
  }
}
