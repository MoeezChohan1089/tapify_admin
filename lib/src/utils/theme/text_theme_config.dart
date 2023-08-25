import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class AppTextStyle {
  AppTextStyle._();
  static TextTheme get appTextTheme => TextTheme(
    //------
    headlineLarge: _headlineTextLarge,
    headlineMedium: _headlineTextMedium,
    headlineSmall: _headlineTextSmall,

    //------
    titleLarge: _titleTextLarge,
    titleMedium: _titleTextMedium,
    titleSmall: _titleTextSmall,

    //------
    bodyLarge: _bodyTextLarge,
    bodyMedium: _bodyTextMedium,
    bodySmall: _bodyTextSmall,

    //------
    displayLarge: _displayTextLarge,
    displayMedium: _displayTextMedium,
    displaySmall: _displayTextSmall,

    //------
    labelLarge: _labelTextLarge,
    labelMedium: _labelTextMedium,
    labelSmall: _labelTextSmall,

  );

  static TextStyle get _baseTextStyle => const TextStyle(
    fontFamily: 'Sofia Pro Regular',
    color: AppColors.appTextColor,
    letterSpacing: -0.1
  );

  ///--------- Headline Text Styles (Large Medium Small)  ----------///
  static TextStyle get _headlineTextLarge => _baseTextStyle.copyWith(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle get _headlineTextMedium => _baseTextStyle.copyWith(
    fontSize: 24.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get _headlineTextSmall => _baseTextStyle.copyWith(
    fontSize: 22.sp,
    fontWeight: FontWeight.w400,
  );

  ///--------- Title Text Styles (Large Medium Small)  ----------///
  static TextStyle get _titleTextLarge => _baseTextStyle.copyWith(
    fontSize: 28.sp,
  );
  static TextStyle get _titleTextMedium => _baseTextStyle.copyWith(
    fontSize: 22.sp,
  );
  static TextStyle get _titleTextSmall => _baseTextStyle.copyWith(
    fontSize: 16.sp,
  );

  ///--------- Body Text Styles (Large Medium Small)  ----------///
  static TextStyle get _bodyTextLarge => _baseTextStyle.copyWith(
    fontSize: 16.sp,
  );
  static TextStyle get _bodyTextMedium => _baseTextStyle.copyWith(
    fontSize: 14.sp,
  );
  static TextStyle get _bodyTextSmall => _baseTextStyle.copyWith(
    fontSize: 12.sp,
  );

  ///--------- Display Text Styles (Large Medium Small)  ----------///
  static TextStyle get _displayTextLarge => _baseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get _displayTextMedium => _baseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get _displayTextSmall => _baseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );

  ///--------- Label Text Styles (Large Medium Small)  ----------///
  static TextStyle get _labelTextLarge => _baseTextStyle.copyWith(
    fontFamily: 'Sofia Pro Medium',
    fontSize: 22.sp,
  );
  static TextStyle get _labelTextMedium => _baseTextStyle.copyWith(
    fontFamily: 'Sofia Pro Semi Bold',
    fontSize: 16.sp,
  );
  static TextStyle get _labelTextSmall => _baseTextStyle.copyWith(
    fontFamily: 'Sofia Pro Medium',
    fontSize: 17.sp,
  );
}