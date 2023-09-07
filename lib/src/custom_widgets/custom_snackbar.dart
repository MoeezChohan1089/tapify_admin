import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../global_controllers/app_config/config_controller.dart';

void showToastMessage({required String message}) {

  Get.closeAllSnackbars();

  Get.showSnackbar(
    GetSnackBar(
      isDismissible: true,
      message: message,
      messageText: Obx(() {
        return Text(message,
          style: TextStyle(
              color: AppConfig.to.secondaryColor.value,
              fontSize: 16.sp
          ),
        );
      }),
      duration: const Duration(seconds: 3),
      backgroundColor: AppConfig.to.primaryColor.value,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      borderRadius: 5.r,
      margin: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h
      ),
    ),
  );

  // showToast(
  //   message,
  //   context: context,
  //   animation: StyledToastAnimation.slideFromTop,
  //   reverseAnimation: StyledToastAnimation.slideFromTop,
  //   position: StyledToastPosition.top,
  //   animDuration: const Duration(seconds: 1),
  //   duration: const Duration(seconds: 3),
  //   curve: Curves.elasticOut,
  //   reverseCurve: Curves.linear,
  //   backgroundColor: Colors.black,
  //   borderRadius: BorderRadius.circular(8),
  //   fullWidth: true,
  //   textAlign: TextAlign.start,
  //   toastHorizontalMargin: 20,
  //   textPadding: EdgeInsets.symmetric(
  //     vertical: 14.h,
  //     horizontal: 18.w
  //   ),
  //   textStyle: TextStyle(
  //     fontFamily: 'Sofia Pro Regular',
  //     color: Colors.white,
  //     letterSpacing: -0.5,
  //     fontSize: 15.sp,
  //   ),
  // );
}