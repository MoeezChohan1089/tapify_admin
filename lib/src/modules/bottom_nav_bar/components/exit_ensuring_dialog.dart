import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';

Future showExitEnsureDialog() async {
  return await Get.defaultDialog<bool>(
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
          SvgPicture.asset(
            Assets.icons.exitIcon,
            // height: 15.h,
          ),
          14.heightBox,
          Text('Are you sure?',
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
              'Do you really want to exit app?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Sofia Pro Medium',
                  fontSize: 14.sp,
                  color: AppColors.customGreyPriceColor),
            ),
          ),
          20.heightBox,
          // Row(
          //   children: [
          //     Expanded(
          //       child: GlobalElevatedButton(
          //         text: "No",
          //         onPressed: () => Navigator.of(Get.context!).pop(false),
          //         isLoading: false,
          //         // applyHorizontalPadding: true,
          //       ),
          //     ),
          //     // 10.widthBox,
          //     Expanded(child: Container())
          //   ],
          // ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(Get.context!).pop(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConfig.to.primaryColor.value,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                      child: Text(
                        "Not Now",
                        style: TextStyle(
                            fontFamily: 'Sofia Pro Regular',
                            fontSize: 14.sp,
                            // height: 1.2,
                            color: Colors.white),
                      )),
                ),
              ),
              15.widthBox,
              Expanded(
                child: SizedBox(
                  height: 34.h,
                  child: ElevatedButton(
                      onPressed: () => Navigator.of(Get.context!).pop(true),
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
                        "Yes",
                        style: TextStyle(
                            fontFamily: 'Sofia Pro Regular',
                            fontSize: 14.sp,
                            height: 1.1,
                            color: AppColors.appHintColor),
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
