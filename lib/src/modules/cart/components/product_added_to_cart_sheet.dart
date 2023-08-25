import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../product_detail/logic.dart';
import '../view.dart';

productAddedbottomSheet(BuildContext context, selectedImageUrl, vendor, title,
    price, comparePrice) {
  final logic = Get.put(ProductDetailLogic());
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return Wrap(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: SafeArea(
                    child: Column(
                  children: [
                    5.heightBox,

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: pageMarginHorizontal,
                          vertical: pageMarginVertical / 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 80.h,
                            height: 80.h,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 80.h,
                                  height: 80.h,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.r),
                                      child: FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          imageErrorBuilder: (context, url,
                                                  error) =>
                                              Container(
                                                color: Colors.grey.shade200,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    Assets.icons.noImageIcon,
                                                    height: 25.h,
                                                  ),
                                                ),
                                              ),
                                          fit: BoxFit.cover,
                                          image: selectedImageUrl)),
                                ),
                                Container(
                                  width: 80.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color:
                                                AppConfig.to.primaryColor.value,
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Expanded(
                          //   child: SizedBox(
                          //     width: 82.h,
                          //     height: 82.h,
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(3.r),
                          //       child: CachedNetworkImage(
                          //         imageUrl: selectedImageUrl,
                          //         fit: BoxFit.cover,
                          //         placeholder: (context, url) =>
                          //             productShimmer(),
                          //         errorWidget: (context, url, error) =>
                          //         const Icon(Icons.error),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          10.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                vendor ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.text.bodySmall?.copyWith(
                                    color: AppColors.appHintColor,
                                    fontSize: 10.sp),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  title ?? "",
                                  maxLines: 1,
                                  // overflow: TextOverflow.ellipsis,
                                  style: context.text.bodySmall?.copyWith(
                                      color: AppColors.appTextColor,
                                      // color: AppColors.appProductCardTitleColor,
                                      fontSize: 13.sp),
                                ),
                              ),
                              8.heightBox,
                              Row(
                                children: [
                                  Text(
                                    price == 0
                                        ? "FREE"
                                        : CurrencyController.to
                                            .getConvertedPrice(
                                                priceAmount: price ?? 0),
                                    maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                    style: context.text.bodyMedium?.copyWith(
                                        color: comparePrice != 0
                                            ? AppColors.appPriceRedColor
                                            : AppColors.appTextColor,
                                        letterSpacing: .01,
                                        height: .5),
                                  ),
                                  6.widthBox,
                                  comparePrice != 0
                                      ? Row(
                                          children: [
                                            4.widthBox,
                                            Text(
                                              CurrencyController.to
                                                  .getConvertedPrice(
                                                      priceAmount:
                                                          comparePrice ?? 0,
                                                      includeSign: false),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              style: context.text.bodySmall
                                                  ?.copyWith(
                                                      color: AppColors
                                                          .appHintColor,
                                                      fontSize: 11.sp,
                                                      height: .5,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                            ),
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                              8.heightBox,
                              Text(
                                "Product added to cart successfully!",
                                maxLines: 2,
                                style: context.text.bodyMedium
                                    ?.copyWith(fontSize: 15.sp),
                              )
                            ],
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.close,
                                color: AppColors.appHintColor,
                                size: 20.sp,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    5.heightBox,

                    // Padding(
                    //   padding: EdgeInsets.only(
                    //       right: pageMarginHorizontal,
                    //       left: pageMarginHorizontal,
                    //       bottom: pageMarginVertical * 1.5
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //
                    //
                    //       Icon(
                    //         Icons.check_circle,
                    //         color: AppConfig.to.primaryColor.value,
                    //         size: 28.sp,
                    //       ),
                    //
                    //       8.widthBox,
                    //       Expanded(child: Text(
                    //         "Product added to cart successfully!",
                    //         maxLines: 2,
                    //         style: context.text.bodyLarge,
                    //       ))
                    //     ],
                    //   ),
                    // ),

                    5.heightBox,

                    logic.quickBottomSheet.value == 'cart'
                        ? GlobalElevatedButton(
                            text: "Done",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            isLoading: false,
                            applyHorizontalPadding: true,
                          )
                        : GlobalElevatedButton(
                            text: "go to cart",
                            onPressed: () {
                              Navigator.pop(context);
                              HapticFeedback.lightImpact();
                              Get.to(() => CartPage(),
                                  transition: Transition.downToUp,
                                  fullscreenDialog: true,
                                  duration: const Duration(milliseconds: 250));
                            },
                            isLoading: false,
                            applyHorizontalPadding: true,
                          ),

                    15.heightBox,
                  ],
                )),
              ),
            ],
          );
        });
      });
}
