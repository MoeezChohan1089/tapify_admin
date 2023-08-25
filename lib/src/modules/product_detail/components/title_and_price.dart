import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../global_controllers/currency_controller.dart';
import '../../../global_controllers/reviews/reviews_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../wishlist/logic.dart';
import '../logic.dart';


class TitleAndPrice extends StatelessWidget {
  TitleAndPrice({Key? key}) : super(key: key);

  final logic = Get.find<ProductDetailLogic>();


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // double parseDouble(String value) {
      //   final cleanedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');
      //   return double.tryParse(cleanedValue) ?? 0.0;
      // }
      //
      // if (logic.product != null &&
      //     logic.selectedVariantIndex.value != null &&
      //     logic.product!.productVariants != null) {
      //   double price = parseDouble(logic.product!.productVariants[logic.selectedVariantIndex.value].price.formattedPrice);
      //   logic.convertCurrency(price);
      // } else {
      //   // Handle the case when any of the required values are null.
      // }
      //
      // if (logic.product != null) {
      //   double price2 = parseDouble(logic.product!.formattedPrice);
      //   logic.convertCurrency(price2);
      // } else {
      //   // Handle the case when logic.product is null.
      // }
      //
      // if (logic.product != null && logic.product!.compareAtPriceFormatted != null) {
      //   double price3 = parseDouble(logic.product!.compareAtPriceFormatted);
      //   logic.convertCurrency2(price3);
      // }

      return logic.productDetailLoader.value == true
          ? ShimertitlePage()
          : Padding(
        padding: EdgeInsets.only(
          left: pageMarginHorizontal,
          right: pageMarginHorizontal,
          top: logic.product?.images.length == 1 ? pageMarginVertical : pageMarginVertical * 1.8,
          bottom: pageMarginVertical,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          logic.product?.vendor.capitalize ?? "",
                          style: context.text.bodySmall?.copyWith(
                              height: 1.1, color: AppColors.appHintColor, fontSize: 14.sp),
                        ),
                        (pageMarginVertical / 2).heightBox,
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                logic.product?.title ?? "",
                                style: context.text.bodyMedium
                                    ?.copyWith(height: 1.1, fontSize: 20.sp),
                              ),
                            ),
                          ],
                        ),
                        (pageMarginVertical / 2).heightBox,

                        ///----- Prices
                        logic.listOfOptions.isEmpty ?
                              ///----- price for simple product
                              Row(
                          children: [
                             Text(
                               // (logic.product?.compareAtPrice ?? 0) == 0 ?  "FREE":
                              logic.product?.price == 0? "FREE": CurrencyController.to.getConvertedPrice(
                                  priceAmount: logic.product?.price ?? 0
                              ),
                              style: context.text.bodyMedium?.copyWith(height: 1.1, color:  ((logic.product?.compareAtPrice ?? 0) != 0) ? AppColors.appPriceRedColor : AppColors.appTextColor),
                            ),
                             8.widthBox,
                            ((logic.product?.compareAtPrice ?? 0) != 0) ?
                            Text(
                              CurrencyController.to.getConvertedPrice(
                                  priceAmount: logic.product?.compareAtPrice ?? 0,
                                includeSign: false
                              ),
                              style: context.text.bodyMedium?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.appHintColor,
                                height: 1.1,
                              ),
                            ) : const SizedBox(),





                            ///------- Reviews & Stars
                            logic.productReviews.value['review_count'] == null
                                ? const SizedBox()
                                : Container(
                              margin: const EdgeInsets.only(bottom: 4, left: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    itemSize: 17.sp,
                                    initialRating: logic.productReviews
                                        .value['review_count'] > 0 ? logic.productReviews
                                        .value['avg_rating'] : 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    unratedColor: AppColors.appHintColor.withOpacity(.7),
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    itemBuilder: (context, _) =>
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xfffbb03b),
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),

                                  4.widthBox,
                                  Text('(${logic.productReviews
                                      .value['review_count']})', style: context
                                      .text.bodyMedium?.copyWith(
                                      height: 0.1,
                                    color: AppColors.appHintColor
                                  ))
                                ],
                              ),
                            ),
                          ],
                        )
                            :
                        ///------- price for variant product
                        Row(
                          children: [
                            Text(
                              // '${logic.product?.productVariants[logic.selectedVariantIndex.value].price.formattedPrice ?? 0.00}',
                              CurrencyController.to.getConvertedPrice(
                                  priceAmount: logic.product?.productVariants[logic
                                      .selectedVariantIndex.value].price.amount ??
                                      0.00
                              ),
                              style: context.text.bodyMedium?.copyWith(height: 1.1,

                                  color: ((logic.product?.productVariants[logic.selectedVariantIndex.value].compareAtPrice ?? 0) != 0) ? AppColors.appPriceRedColor : AppColors.appTextColor

                              ),

                            ),
                            8.widthBox,
                            ((logic.product?.productVariants[logic
                                .selectedVariantIndex.value].compareAtPrice ?? 0) !=
                                0) ?
                            Text(
                              // '${(logic.product?.productVariants[logic.selectedVariantIndex.value].compareAtPrice?.formattedPrice ?? 0)}',

                              CurrencyController.to.getConvertedPrice(
                                  priceAmount: logic.product?.productVariants[logic
                                      .selectedVariantIndex.value].compareAtPrice
                                      ?.amount ?? 0.00,
                                includeSign: false
                              ),
                              style: context.text.bodyMedium?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14.sp,
                                color: AppColors.appHintColor,
                                height: 1.1,
                              ),
                            ) : const SizedBox(),


                            ///------- Reviews & Stars
                            logic.productReviews.value['review_count'] == null
                                ? const SizedBox()
                                : Container(
                              margin: const EdgeInsets.only(bottom: 4, left: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    itemSize: 17.sp,
                                    initialRating: logic.productReviews
                                        .value['review_count'] > 0 ? logic.productReviews
                                        .value['avg_rating'] : 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    unratedColor: AppColors.appHintColor.withOpacity(.7),
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    itemBuilder: (context, _) =>
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xfffbb03b),
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),

                                  4.widthBox,
                                  Text('(${logic.productReviews
                                      .value['review_count']})', style: context
                                      .text.bodyMedium?.copyWith(
                                      height: 0.1,
                                    color: AppColors.appHintColor
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),


                        (pageMarginVertical / 3).heightBox,

                      ],
                    )),


                Obx(() {
                  bool isProductInWishlist = WishlistLogic.to.checkIfExistsInBookmark(id:  logic.product?.id ?? "") != -1;
                  return GestureDetector(
                    onTap: () =>  WishlistLogic.to.addOrRemoveBookmark(context: context, product: logic.product!),
                    child: SvgPicture.asset(
                        Assets.icons.heartFilled,
                       color: isProductInWishlist ? Colors.red : Colors.grey.shade200,
                    ),
                  );

                  //   LikeButton(
                  //     size: 30.sp,
                  //     isLiked: isProductInWishlist,
                  //     likeCountAnimationType: LikeCountAnimationType.part,
                  //     onTap: (bool isLiked) async {
                  //       HapticFeedback.lightImpact();
                  //       WishlistLogic.to.addOrRemoveBookmark(context: context, product: logic.product!);
                  //       return !isLiked;
                  //     }
                  // );
                }),


              ],
            ),
          ],
        ),
      );
    });
  }
}