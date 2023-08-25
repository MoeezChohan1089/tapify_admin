import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../global_controllers/app_config/config_controller.dart';
import '../modules/cart/logic.dart';
import '../utils/constants/assets.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/margins_spacnings.dart';

customDialogueBox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: AppColors.customWhiteTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              8.0), // Set your desired border radius here
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.customWhiteTextColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: 6.w,
                        top: 5.h
                    ),
                    child: GestureDetector(onTap: () {
                      Navigator.of(context).pop();
                    }, child: Icon(Icons.close, size: 20.sp,)),
                  ),
                ],
              ),
              SvgPicture.asset(
                Assets.icons.cartIconClearAll,  height: 65.h,),
              24.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Would you like to proceed with emptying your cart?",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium!.copyWith(
                          color: AppColors.customGreyPriceColor,
                          height: 1.1,
                          fontSize: 14.sp),)),
              ),
              15.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,
                    vertical: pageMarginVertical),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child:
                      SizedBox(
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () async {
                              // Vibration.vibrate(duration: 100);
                              HapticFeedback.lightImpact();
                              Navigator.of(context).pop();
                              // ProductDetailLogic.to.addProductToCart();
                            },

                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white,

                                elevation: 0,
                                // Set the text color of the button
                                padding: const EdgeInsets.all(8),
                                // Set the padding around the button content
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                                side: BorderSide(
                                  width: 0.5,
                                  color: AppColors.appHintColor,

                                  // color: AppConfig.to.primaryColor.value,
                                )
                            ),
                            child: Text("Not Now",
                              style: context.text.bodyMedium!.copyWith(
                                  color: AppColors.appHintColor,

                                  // color: AppConfig.to.primaryColor.value,
                                  // color: AppConfig.to.primaryColor.value,
                                  height: 1.1),)),
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    GetBuilder<CartLogic>(builder: (logic) {
                      return Expanded(
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () async {
                                logic.isProcessing.value = true;
                                HapticFeedback.lightImpact();
                                Navigator.of(context).pop();
                                await Future.delayed(const Duration(seconds: 1));
                                await logic.resetCart();
                                logic.isProcessing.value = false;
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConfig.to.primaryColor.value,
                                // backgroundColor: AppColors.appPriceRedColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                // Set the text color of the button
                                padding: const EdgeInsets.all(8),
                                // Set the padding around the button content
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.r),
                                ),
                              ),
                              child: Text("Yes, Clear",
                                style: context.text.bodyMedium!.copyWith(
                                    color: Colors.white, height: 1.1),)),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}