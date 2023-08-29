import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';

fetchingShopDetails() {
  Get.defaultDialog(
    barrierDismissible: false,
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
          const SpinKitThreeBounce(
            color: AppColors.appTextColor,
            size: 23.0,
          ),
          14.heightBox,
          Text('Please wait...',
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
              'We are fetching details of the store',
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
