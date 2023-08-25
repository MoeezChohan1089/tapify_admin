import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../modules/bottom_nav_bar/view.dart';
import '../modules/cart/view.dart';
import '../utils/constants/assets.dart';
import '../utils/constants/colors.dart';
import 'loader_pulse.dart';

addToCartDialogue({required BuildContext context}){
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return BounceInUp(
        duration: const Duration(milliseconds: 500),
        child: Dialog(
          backgroundColor: AppColors.customWhiteTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Set your desired border radius here
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.customWhiteTextColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Assets.images.emptyCartImage,
                  width: 100,
                ),
                SizedBox(height: 20.0),
                Text("Cart Updated", style: context.text.bodyMedium!.copyWith(color: Colors.black, fontSize: 16, height: 1.1),),
                SizedBox(height: 10.0),
                Text("Item Successfully added to cart!", textAlign: TextAlign.center, style: context.text.bodyMedium!.copyWith(color: AppColors.customGreyTextColor, height: 1.1),),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 32,
                        child: ElevatedButton(
                            onPressed: () async {
                              HapticFeedback.lightImpact();
                              Navigator.pop(dialogContext);
                              Get.off(()=> BottomNavBarPage());
                              // logic.deleteUser(context: context, id: deleteAcc[0]['id']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 0,// Set the text color of the button
                              padding: const EdgeInsets.all(8), // Set the padding around the button content
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: Text("Continue", style: context.text.bodyMedium!.copyWith(color: Colors.white, height: 1.1),)),
                      ),
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: double.maxFinite,
                        height: 32,
                        child: ElevatedButton(
                            onPressed: () {
                              // Vibration.vibrate(duration: 100);
                              HapticFeedback.lightImpact();
                              // Navigator.of(context).pop();
                              Navigator.pop(dialogContext);
                              Future.delayed(Duration(seconds: 500),(){
                                Center(
                                  child: GFLoader(
                                    type: GFLoaderType.circle,
                                    loaderColorOne: Color(0xff232C5A),
                                    loaderColorTwo: Color(0xff232C5A),
                                    loaderColorThree: Color(0xff6F637E),
                                    size: 45,
                                  ),
                                );
                              });
                              Future.delayed(Duration(milliseconds: 500),(){
                                Get.off(()=> CartPage(), transition: Transition.rightToLeft, duration: Duration(milliseconds: 450));
                              });

                              // ProductDetailLogic.to.addProductToCart();
                            },

                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.white,

                                elevation: 0,// Set the text color of the button
                                padding: const EdgeInsets.all(8), // Set the padding around the button content
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                side: const BorderSide(
                                  width: 1.0,
                                  color: Colors.black,
                                )
                            ),
                            child: Text("Go to Cart", style: context.text.bodyMedium!.copyWith(color: Colors.black, height: 1.1),)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}