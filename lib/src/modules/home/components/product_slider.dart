import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:tapify/src/utils/home_widgets_stylings.dart';

import '../../../custom_widgets/customText.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class ProductSlider extends StatefulWidget {
  final dynamic settings;

  const ProductSlider({Key? key, required this.settings}) : super(key: key);

  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {

  final String productSliderSize = "horizontal";

  final appConfig = AppConfig.to;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appConfig.innerLoader.value == true? ShimerProductSlidePage():
      // Padding(
      //   padding: widget.settings['margin'] == true
      //       ? EdgeInsets.only(
      //      top: pageMarginVertical,
      //       bottom: pageMarginVertical)
      //       :
      //   EdgeInsets.only(top: pageMarginVertical),
      //   child:
      Column(
        children: [
          (widget.settings['isTitleHidden']) != true
              ? Padding(
            padding: EdgeInsets.only(
                top: 10.h,
                left: 16.w, right: 16.w),
            // padding: EdgeInsets.only(left: pageMarginHorizontal/1.5,),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      '${widget.settings['title']}',
                      textAlign: widget.settings['titleAlignment'] == 'left'
                          ? TextAlign.left
                          : widget.settings['titleAlignment'] == 'center'
                      // ? TextAlign.right
                          ? TextAlign.center
                          : TextAlign.right,
                      style: widget.settings['titleSize'] == 'small'
                          ? context.text.titleSmall
                          : widget.settings['titleSize'] == 'medium'
                          ? context.text.titleMedium
                          : context.text.titleLarge,
                    ),
                  ),
                  (pageMarginVertical - 4).heightBox,
                ],
              ),
            ),
          )
              : const SizedBox(),


          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: widget.settings['margin'] == true ? EdgeInsets.only(
                top: (pageMarginVertical - 4),
                left: pageMarginHorizontal/1.5,
                bottom: pageMarginVertical
            ) : EdgeInsets.zero,
            child: Row(
                children: List.generate(
                    widget.settings["metadata"]["data"].length,
                        (index) {
                      final indexData = widget
                          .settings["metadata"]["data"][index];
                      ProductInfo? productInfo = appConfig.getProductById(
                        id: indexData["id"],
                        dataType: widget.settings["metadata"]['dataType'],
                      );

                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.settings['disableInteraction'] ==
                                  false) {
                                HomeLogic.to.productDetailNavigator(
                                    context: context,
                                    info: productInfo!,
                                    dataType: widget
                                        .settings["metadata"]['dataType']
                                );
                              }
                            },
                            child: Padding(
                              padding:EdgeInsets.only(
                                  right: index ==  widget.settings["metadata"]["data"].length -1 ? 5 : widget.settings['contentMargin'] != true ? pageMarginHorizontal : pageMarginHorizontal * 2),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(3.r),
                                    child: CachedNetworkImage(
                                        imageUrl: indexData["path"] ??
                                            productInfo!.image,
                                        fit: BoxFit.cover,
                                        height: productSliderSize == "horizontal"
                                            ? 150
                                            : productSliderSize == "square"
                                            ? 300
                                            : 350,
                                        width: 285,
                                        color: widget
                                            .settings['titlePosition'] ==
                                            'center' ? Colors.black.withOpacity(0.4) : null,
                                        colorBlendMode: BlendMode.darken,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                            productShimmer(),
                                        errorWidget:
                                            (context, url, error) =>
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(Assets.icons.noImageIcon,
                                                  height: 24.h,
                                                ),
                                              ),
                                            )
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: widget
                                            .settings['titlePosition'] ==
                                            'center'
                                            ? Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            10.heightBox,
                                            HomeProductsTitle(
                                              title: productInfo!.title,
                                              textColor: AppColors.customWhiteTextColor,
                                              titleHeight: 18.h,
                                              // textSize: 16.sp,
                                            ),
                                            // 5.heightBox,
                                            (widget.settings["metadata"]['dataType'] == "collection" || widget.settings["metadata"]['dataType'] == "web-url") ? const SizedBox.shrink() : Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                HomeProductsPrice(
                                                  price: productInfo.price,
                                                  priceColor: AppColors.customWhiteTextColor,
                                                ),
                                                4.widthBox,
                                                productInfo.compareAtPrice!= 0?  Text(
                                                  CurrencyController.to.getConvertedPrice(
                                                      priceAmount: productInfo.compareAtPrice,
                                                      includeSign: false),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  style: context.text.bodySmall?.copyWith(
                                                      color: AppColors.appHintColor,
                                                      fontSize: 11.sp,
                                                      height: .5,
                                                      decoration:
                                                      TextDecoration.lineThrough),
                                                ):SizedBox.shrink(),
                                              ],
                                            ),

                                          ],
                                        )
                                            : const SizedBox(),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          widget.settings['titlePosition'] == 'bottom'
                              ? Container(
                            padding:EdgeInsets.only(
                                right: widget.settings['contentMargin'] != true ? pageMarginHorizontal : pageMarginHorizontal * 2),
                                child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                10.heightBox,
                                HomeProductsTitle(
                                  title: productInfo!.title,
                                  textColor: AppColors.appTextColor,
                                  // textSize: 16.sp,
                                  titleHeight: 18.h,
                                ),
                                (widget.settings["metadata"]['dataType'] == "collection" || widget.settings["metadata"]['dataType'] == "web-url") ? const SizedBox.shrink() : Row(
                                  children: [
                                    HomeProductsPrice(
                                      price: productInfo.price,
                                      priceColor: AppColors.customGreyTextColor,
                                    ),
                                    10.widthBox,
                                    productInfo.compareAtPrice!= 0?  Text(
                                      CurrencyController.to.getConvertedPrice(
                                          priceAmount: productInfo.compareAtPrice,
                                          includeSign: false),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: context.text.bodySmall?.copyWith(
                                          color: AppColors.appHintColor,
                                          fontSize: 11.sp,
                                          height: .5,
                                          decoration:
                                          TextDecoration.lineThrough),
                                    ):SizedBox.shrink(),
                                  ],
                                ),

                                // 5.heightBox,

                            ],
                          ),
                              )
                              : const SizedBox()
                        ],
                      );
                    })),
          ),

        ],
      );
      // );
    });
  }
}