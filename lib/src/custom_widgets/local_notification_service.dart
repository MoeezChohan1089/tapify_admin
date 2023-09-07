import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../modules/bottom_nav_bar/view.dart';
import '../modules/cart/view.dart';
import '../modules/category/view_category_products.dart';
import '../modules/product_detail/view_product_detail.dart';

class NotificationService {
  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialization Settings for iOS
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //Initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  onSelectNotification(String? payload) async {
    //Navigate to wherever you want
    print('Notification tapped. Payload: $payload');

    if (payload != null) {
      Map<String, dynamic> notificationData =
      jsonDecode(payload) as Map<String, dynamic>;

      String? notificationType = notificationData['type'];
      String? productId = notificationData['id'];
      String? productName = notificationData['name'];

      // Now you can navigate based on the notificationType and other data
      // Check the notificationType and navigate accordingly
      if (notificationType == 'product') {
        // Navigate to the product detail page using productId
        Get.to(() =>
            NewProductDetails(productId: "gid://shopify/Product/$productId"
              // productId: productId!,
            ), transition: Transition.native);
      } else if (notificationType == 'collection') {
        // Navigate to the category page using category information
        Get.to(() => CategoryProducts(
          categoryName: productName!,
          collectionID: "gid://shopify/Collection/$productId",
          // collectionID: productId!,
        ), transition: Transition.native);
        // Navigator.push(
        //   context, // You need to have access to the context here
        //   MaterialPageRoute(
        //     builder: (context) => CategoryPage(),
        //   ),
        // );
      } else if (notificationType == 'custom' || notificationType == 'text') {
        Get.offAll(() => BottomNavBarPage());
      }
    } else {
      Get.to(CartPage(), transition: Transition.native, fullscreenDialog: true);
    }
  }

  requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> showNotifications({id, title, body, payload}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<void> scheduleNotifications({id, title, body, time, payLoad}) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(time, tz.local),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'your channel id', 'your channel name',
                  channelDescription: 'your channel description')),
          androidAllowWhileIdle: true,
          payload: payLoad,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    } catch (e) {
      print(e);
    }
  }
}