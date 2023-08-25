import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void notificationInitializeMain() async {
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.requestPermission(
      sound: true, badge: true, alert: true, provisional: true);
}

late AndroidNotificationChannel channelNew;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPluginNew;

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    //
    // ///------Get Device FCM Token
    // await FirebaseMessaging.instance.getToken().then((value) {
    //   log("Token saved :: ${value}");
    // });
    //
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
    //
    // ///------Get Device FCM Token
    // await FirebaseMessaging.instance.getToken().then((value) {
    //   log("Token saved :: ${value}");
    // });
  } else {
    print('User declined or has not accepted permission');
  }
}

void listenFCM() async {
  FirebaseMessaging.instance.subscribeToTopic("tapify-demo1");
  await FirebaseMessaging.instance.getToken().then((value) {
    log("Token saved :: ${value}");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      // String? productId = message.data['productId'];
      // String? productName = message.data['productName'];

      print(
          "getting the notiifcation : ${message.data['id']} : ${message.data['type']} : ${message.data['name']} ");

      String dataJson = jsonEncode(message.data);

      flutterLocalNotificationsPluginNew.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelNew.id,
            channelNew.name,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: dataJson, // Pass the entire data as the payload
      );
    }
  });
}

void loadFCM() async {
  if (!kIsWeb) {
    channelNew = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableVibration: true,
    );

    flutterLocalNotificationsPluginNew = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPluginNew
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}