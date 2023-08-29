import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';

invalidQRCodeDialog() {
  Get.defaultDialog(
    barrierDismissible: true,
    contentPadding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    title: " ",
    titleStyle: const TextStyle(fontSize: .1),
    content: Container(
      decoration: BoxDecoration(
        color: AppColors.customWhiteTextColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          5.heightBox,
          Icon(
            Icons.error_outline_outlined,
            color: Colors.red,
            size: 45.sp,
          ),
          14.heightBox,
          Text('Sorry, QR Code is Invalid',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Sofia Pro Semi Bold',
                fontSize: 16.sp,
                color: AppColors.appTextColor,
              )),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Provided QR code doesn't belong to a shop, please try with valid shop QR code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Sofia Pro Medium',
                  fontSize: 14.sp,
                  color: AppColors.customGreyPriceColor),
            ),
          ),
          10.heightBox,
        ],
      ),
    ),
  );
}
