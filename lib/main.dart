import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'src/module/auth/view.dart';
import 'src/utils/theme/theme_config.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  home_Page() async {
    await FirebaseAnalytics.instance.logEvent(
      name: "ADMIN_SCREEN",
      parameters: {
        "home" : "Admin Screen"
      },
    );
  }

  Json_Page() async {
    await FirebaseAnalytics.instance.logEvent(
      name: "NOTIFICATION_PAGE",
      parameters: {
        "home" : "JSON Admin"
      },
    );
  }

  @override
  void initState() {
    home_Page();
    Json_Page();
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
            navigatorObservers: <NavigatorObserver>[MyApp.observer],
            theme: AppTheme.light(),
            home: AuthPage(),
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
