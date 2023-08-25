import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify/src/modules/cart/logic.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../view.dart';

unCompletedCartItemDialog() {
  return showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return ElasticIn(
        duration: const Duration(milliseconds: 500),
        delay: const Duration(milliseconds: 250),
        child: Dialog(
          // backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.r), // Set your desired border radius here
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.customWhiteTextColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                5.heightBox,
                Text("Welcome Back!",
                    style: context.text.labelMedium?.copyWith(
                      fontSize: 18.sp
                    )),
                5.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w
                  ),
                  child: Text(
                    "You forgot this in your cart. Checkout now before it sells out.",
                    textAlign: TextAlign.center,
                    style: context.text.bodyMedium!.copyWith(
                        color: AppColors.appHintColor, height: 1.2),),
                ),
                16.heightBox,

                Container(
                  height: CartLogic.to.currentCart!.lineItems.length == 1 ? 70.h : CartLogic.to.currentCart!.lineItems.length == 2 ? 150.h : CartLogic.to.currentCart!.lineItems.length == 3 ? 200.h : 295.h,
                  child: SingleChildScrollView(
                    physics: CartLogic.to.currentCart!.lineItems.length < 4 ? const NeverScrollableScrollPhysics() : null,
                    child: Column(
                      children: List.generate(CartLogic.to.currentCart!.lineItems.length, (index) => Padding(padding: EdgeInsets.only(
                        bottom: 17.h,
                        right: 10.w,
                        left: 10.w
                      ),
                       child:   Row(
                         children: [
                           SizedBox(
                             width: 55.h,
                             height: 55.h,
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(3.r),
                               child: CachedNetworkImage(
                                 imageUrl:
                                 CartLogic.to.currentCart!.lineItems[index].variant?.image!.originalSrc ?? "",
                                 fit: BoxFit.cover,
                                 placeholder: (context, url) =>
                                     productShimmer(),
                                 errorWidget: (context, url, error) =>
                                 const Icon(Icons.error),
                               ),
                             ),
                           ),
                           15.widthBox,
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   CartLogic.to.currentCart!.lineItems[index].title,
                                       // "${CartLogic.to.currentCart!.lineItems[index].variant?.title != "Default Title" ? item.variant?.title}",
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                   style: context.text.bodyMedium?.copyWith(
                                       height: 1.2
                                   ),
                                 ),
                                 10.heightBox,
                                 Row(
                                   children: [
                                     Text(
                                 CartLogic.to.currentCart!.lineItems[index].variant!.priceV2!.amount == 0? "FREE":   CurrencyController.to.getConvertedPrice(
                                           priceAmount:
                                           CartLogic.to.currentCart!.lineItems[index].variant!.priceV2!.amount ),
                                       style: context.text.bodyMedium
                                           ?.copyWith(
                                           color:
                                           CartLogic.to.currentCart!.lineItems[index].variant?.compareAtPrice?.amount !=
                                               null? AppColors.appPriceRedColor:AppColors.appTextColor),
                                     ),
                                     3.widthBox,
                                     CartLogic.to.currentCart!.lineItems[index].variant?.compareAtPrice?.amount !=
                                         null
                                         ? Text(
                                       CurrencyController.to
                                           .getConvertedPrice(
                                           priceAmount: CartLogic.to.currentCart!.lineItems[index]
                                               .variant
                                               ?.compareAtPrice
                                               ?.amount ??
                                               0),
                                       style: context.text.bodySmall
                                           ?.copyWith(
                                           color: AppColors
                                               .appHintColor,
                                           fontSize: 10.sp,
                                           decoration: TextDecoration
                                               .lineThrough),
                                     )
                                         : const SizedBox(),

                                     // Text(
                                     //   CurrencyController.to.getConvertedPrice(
                                     //       priceAmount: product.price
                                     //   ),
                                     //   style: context.text.bodySmall?.copyWith(
                                     //       color: AppColors.appHintColor,
                                     //       fontSize: 10.sp,
                                     //       decoration: TextDecoration.lineThrough
                                     //   ),
                                     // ),
                                   ],
                                 ),
                               ],
                             ),
                           )
                         ],
                       ),
                      )),
                    ),
                  ),
                ),





                20.heightBox,


                ///---- Buttons
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 31,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  side: BorderSide(
                                    width: 0.5,
                                    color: AppConfig.to.primaryColor.value,
                                  )
                              ),
                              child: Text("Cancel",
                                style: context.text.bodyMedium!.copyWith(
                                    color: AppConfig.to.primaryColor.value,
                                    height: 2.25),)),
                        ),
                      ),
                      10.widthBox,
                      Expanded(
                        child: SizedBox(
                          width: double.maxFinite,
                          height: 31,
                          child: ElevatedButton(
                              onPressed: () async {
                                Get.back();
                                await Future.delayed(const Duration(milliseconds: 200));
                                Get.to(() => CartPage(),
                                    fullscreenDialog: true
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConfig.to.primaryColor.value,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              child: Text("Continue",
                                style: context.text.bodyMedium!.copyWith(
                                    color: Colors.white, height: 2.25),)),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      );
    },
  );
}