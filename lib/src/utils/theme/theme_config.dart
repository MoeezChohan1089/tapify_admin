import 'package:flutter/material.dart';
import 'package:tapify_admin/src/utils/theme/text_theme_config.dart';

class AppTheme {
  AppTheme._();

  ///------ Light Theme Mode Settings ---------///
  static ThemeData light() {
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      textTheme: AppTextStyle.appTextTheme,
      primaryColor: Colors.black,
    );
  }

  ///------ Dark Theme Mode Settings ---------///
  static ThemeData dark() {
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.black,
        textTheme: AppTextStyle.appTextTheme,
        primaryColor: Colors.red);
  }
}

///-----------------------light-theme-settings----------------
// lightThemeConfig() => ThemeData(
//       // fontFamily: 'Poppins',
//       useMaterial3: true
//     ).copyWith(
//       pageTransitionsTheme: const PageTransitionsTheme(
//         builders: <TargetPlatform, PageTransitionsBuilder>{
//           TargetPlatform.android: CupertinoPageTransitionsBuilder(),
//         },
//       ),
//       // primaryColor: customBlueColor,
//       // appBarTheme: const AppBarTheme(color: customBlueColor),
//       // scaffoldBackgroundColor: customLightScaffoldColor,
//       // cardColor: customLightBlueColor,
//       // textSelectionColor: Colors.white,
//       // focusColor: customDarkBlackColor,
//       // buttonColor: customBlueColor,
//       // iconTheme: const IconThemeData(),
//       // textTheme: const TextTheme(
//       //
//       //     // //------
//       //     // headlineLarge: ,
//       //     // headlineMedium: ,
//       //     // headlineSmall: ,
//       //
//       //     // //------
//       //     // titleLarge: ,
//       //     // titleMedium: ,
//       //     // titleSmall: ,
//       //
//       //     // //------
//       //     // bodyLarge: ,
//       //     // bodyMedium: ,
//       //     // bodySmall: ,
//       //
//       //     // //------
//       //     // displayLarge: ,
//       //     // displayMedium: ,
//       //     // displaySmall: ,
//       //
//       //     // //------
//       //     // labelLarge: ,
//       //     // labelMedium: ,
//       //     // labelSmall: ,
//       //
//       //     ),
//     );
