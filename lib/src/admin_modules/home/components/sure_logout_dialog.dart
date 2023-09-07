import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../global_controllers/database_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../auth/view.dart';

sureLoggingOffDialog() {
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
          Image.asset(
            Assets.images.connectionImage,
            // width: 100,
          ),
          14.heightBox,
          Text('Are You Sure?',
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
              'You want to log out.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Sofia Pro Medium',
                  fontSize: 14.sp,
                  color: AppColors.customGreyPriceColor),
            ),
          ),
          20.heightBox,
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          side: const BorderSide(
                            width: 0.5,
                            color: AppColors.appHintColor,
                          )),
                      child: Text(
                        "No",
                        style: TextStyle(
                            fontFamily: 'Sofia Pro Regular',
                            fontSize: 14.sp,
                            height: 1.1,
                            color: AppColors.appHintColor),
                      )),
                ),
              ),
              15.widthBox,
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: ElevatedButton(
                      onPressed: () {
                        LocalDatabase.to.box.remove('adminSignedInToken');
                        Get.offAll(AdminSignInPage(isRedirectToWeb: false), transition: Transition.native, opaque: false
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        // backgroundColor: AppConfig.to.primaryColor.value,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                            fontFamily: 'Sofia Pro Regular',
                            fontSize: 14.sp,
                            color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
