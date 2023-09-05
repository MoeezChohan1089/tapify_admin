import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tapify_admin/src/admin_modules/splash/view.dart';
import 'package:tapify_admin/src/utils/theme/text_theme_config.dart';

import 'src/global_controllers/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await GetStorage.init();
  await DependencyInjection.init();

  ///----- notification functions
  // Get.put(NotificationService());
  // notificationInitializeMain();
  // tz.initializeTimeZones();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  // await NotificationService().init();
  // await NotificationService().requestIOSPermissions();
  ///--------------------------

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatefulWidget {
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: analytics);
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  // home_Page() async {
  //   await FirebaseAnalytics.instance.logEvent(
  //     name: "ADMIN_SCREEN",
  //     parameters: {"home": "Admin Screen"},
  //   );
  // }
  //
  // Json_Page() async {
  //   await FirebaseAnalytics.instance.logEvent(
  //     name: "NOTIFICATION_PAGE",
  //     parameters: {"home": "JSON Admin"},
  //   );
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              // primarySwatch: Colors.red,
              colorSchemeSeed: Colors.white,
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              textTheme: AppTextStyle.appTextTheme,
              // primaryColor: Colors.black,
              // Or another color
            ),
            home: AdminSplashPage(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          );
        });
  }
}
