import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../product_detail/logic.dart';
import '../logic.dart';
import '../models/product_info_model.dart';


class ProductsSlideShow extends StatelessWidget {
  final dynamic settings;


  ProductsSlideShow({Key? key, required this.settings}) : super(key: key);

  // final Map<String, dynamic> settings = {
  //   "isTitleHidden": true,
  //   "title": 'Your Title',
  //   "titleAlignment": 'left',
  //   "titleSize": 'medium',
  //   "displayType": 'horizontal',
  //   "titlePosition": 'bottom',
  //   "margin": false,
  //   "contentMargin": false,
  //   "disableInteraction": false,
  //   "metadata": []
  // };


  // final logic = Get.find<HomeLogic>();

  // final logic1 = Get.find<ProductDetailLogic>();

  // final String slideSize = "horizontal";

  // horizontal, square, vertical
  // final String slidePadding = "horizontal";

  // final bool selectedPad = false;

  // horizontal, square, vertical

  final appConfig = AppConfig.to;
  final logic = Get.find<HomeLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appConfig.innerLoader.value == true? ShimerRectSliderPage(): Padding(
        padding: settings['margin'] == true
            ? EdgeInsets.only(
            top: pageMarginHorizontal/1.5,  bottom: pageMarginHorizontal/1.5, left: pageMarginHorizontal/1.5, right: pageMarginHorizontal/1.5)
            : EdgeInsets.only( top: 0),
        child: Column(
          children: [
            // padding: EdgeInsets.only(
            //   left: pageMarginHorizontal,
            // ),
            (settings["isTitleHidden"] == false) ? Padding(
              padding: EdgeInsets.only(
                bottom: 8.h,
                left: settings['margin'] == false ? 10.w:0.w,
                top: settings['margin'] == true ? 0.h : 6.h,
                right: settings['margin'] == false ? 10.w:0.w,
              ),

              child: SizedBox(
                // margin: settings['titleAlignment'] != 'center' ? EdgeInsets
                //     .symmetric(horizontal: pageMarginHorizontal) : EdgeInsets
                //     .symmetric(horizontal: 0),
                width: double.maxFinite,
                child: Text('${settings["title"]}',
                  textAlign: settings['titleAlignment'] == 'left'
                      ? TextAlign.left
                      : settings['titleAlignment'] == 'center'
                      ? TextAlign.center
                      : TextAlign.right,
                  style: settings['titleSize'] == 'small' ? context.text
                      .titleSmall : settings['titleSize'] == 'medium' ? context
                      .text.titleMedium : context.text.titleLarge,
                ),
              ),
            ) : const SizedBox(),
            Padding(
              padding: settings['contentMargin'] == true ? EdgeInsets.symmetric(
                  vertical: pageMarginVertical/1.3, ) : EdgeInsets.symmetric(
                vertical: 0,),
                // vertical: pageMarginVertical / 2,),
              child: SizedBox(
                height: settings['displayType'] == "horizontal"
                    ? 230
                    : settings['displayType'] == "normal" ? 300 : settings['displayType'] == "auto" ? null : 400,
                child: Stack(

                  alignment: Alignment.bottomCenter,

                  children: [
                    CarouselSlider(
                      items: List.generate(
                          settings["metadata"]["data"].length,
                              (index) {
                            final indexData = settings["metadata"]["data"][index];

                            ProductInfo? productInfo = appConfig.getProductById(
                              id: indexData["id"],
                              dataType: settings["metadata"]['dataType'],
                            );


                            return GestureDetector(
                              onTap: () {
                                if (settings['disableInteraction'] ==
                                    false) {
                                  HomeLogic.to.productDetailNavigator(
                                      context: context,
                                      info: productInfo!,
                                      dataType: settings["metadata"]['dataType']
                                  );
                                }
                              },
                              child: Stack(
                                children: [

                                  ClipRRect(
                                    borderRadius: settings["margin"] == true? BorderRadius.circular(3.r):BorderRadius.circular(0.r),
                                    child: CachedNetworkImage(
                                      imageUrl: indexData["path"] ??
                                          productInfo!.image,
                                      fit: BoxFit.cover,
                                        height: settings['displayType'] == "horizontal"
                                            ? 230
                                            : settings['displayType'] == "normal" ? 300 : settings['displayType'] == "auto" ? null : 400,
                                        width: double.infinity,
                                       color: settings['titlePosition'] ==
                                            'center' || settings['titlePosition'] ==
                                           'hidden' ? Colors.black.withOpacity(0.4) : null,
                                        colorBlendMode: BlendMode.darken,

                                        progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                      productShimmer(),
                                        errorWidget:
                                            (context, url, error) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                // color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(100.r),
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(Assets.icons.noImageIcon,
                                                  height: 24.h,
                                                ),
                                              ),
                                            )
                                    ),
                                  ),

                                  // Image.network(
                                  //   indexData["path"] ?? productInfo.image,
                                  //   width: double.maxFinite,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: settings['titlePosition'] ==
                                          'center' ? Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          // settings["hideContentPrice"] == false
                                          //     ?
                                          (settings["metadata"]['dataType'] == "collection" || settings["metadata"]['dataType'] == "web-url") ? const SizedBox.shrink()  : Column(
                                            children: [
                                              12.heightBox,
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  HomeProductsPrice(
                                                    price: productInfo!.price,
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
                                          ),
                                              // : const SizedBox.shrink(),


                                          7.heightBox,
                                          HomeProductsTitle(
                                            title: productInfo!.title,
                                            textColor: Colors.white,
                                          ),

                                          //
                                          settings["hideContentTitle"] == false
                                              ? Column(
                                            children: [
                                              7.heightBox,
                                              HomeProductsTitle(
                                                title: productInfo!.title,
                                              ),
                                            ],
                                          )
                                              : const SizedBox.shrink()


                                        ],
                                      ) : const SizedBox()),

                                ],
                              ),
                            );
                          }


                        //         CachedNetworkImage(
                        //   imageUrl: (widget.modelProduct.images ?? [])
                        //       .isNotEmpty
                        //       ? '${widget.modelProduct.images![index].src!.split('?')[0]}?width=400'
                        //       : "",
                        //   fit: BoxFit.cover,
                        //   height: double.infinity,
                        //   width: double.infinity,
                        //   progressIndicatorBuilder:
                        //       (context, url, downloadProgress) =>
                        //       CircularProgressIndicator(
                        //           value: downloadProgress.progress),
                        //   errorWidget: (context, url, error) =>
                        //   const Icon(Icons.error),
                        // ),
                      ),
                      options: CarouselOptions(
                          height: context.deviceHeight/1.5,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          autoPlay: true,
                          enableInfiniteScroll: true,
                          // reverse: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, _) {
                            logic.currentImageIndex.value = index;
                          }
                      ),
                    ),

                    Positioned(
                      bottom: settings['margin'] == true?  pageMarginVertical : pageMarginVertical,
                      child: settings['titlePosition'] == 'center' || settings['titlePosition'] == 'hidden'? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(settings["metadata"]["data"]
                            .length, (index) {
                          return  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(
                                    milliseconds: 250),
                                height: 7.h,
                                width:
                                logic.currentImageIndex.value ==
                                    index
                                    ? 25.h
                                    : 7.h,
                                decoration: logic.currentImageIndex
                                    .value ==
                                    index
                                    ? BoxDecoration(
                                    color: AppConfig
                                        .to.primaryColor.value,
                                    borderRadius:
                                    BorderRadius.circular(
                                        50.r))
                                    : BoxDecoration(
                                    color: AppColors
                                        .appBordersColor,
                                    borderRadius:
                                    BorderRadius.circular(
                                        50.r)),
                              ),
                              4.widthBox
                            ],
                          );
                        }




                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Container(
                            //       height: 10.h,
                            //       width: logic.currentImageIndex.value ==
                            //           index ? 23.w:10.w,
                            //       decoration: BoxDecoration(
                            //           borderRadius: logic.currentImageIndex.value ==
                            //               index ? BorderRadius.circular(5.r):null,
                            //           color: logic.currentImageIndex.value ==
                            //               index ? AppConfig.to.primaryColor.value : AppColors.appHintColor,
                            //           shape: logic.currentImageIndex.value ==
                            //               index? BoxShape.rectangle:BoxShape.circle,
                            //           border: logic.currentImageIndex.value ==
                            //               index ? null : Border.all(
                            //               color: Colors.grey,
                            //               width: 1
                            //           )
                            //       ),
                            //     ),
                            //     4.widthBox,
                            //
                            //   ],
                            // )
                        ),
                      ):SizedBox(),
                    ),

                  ],
                ),
              ),
            ),


            settings['titlePosition'] == 'bottom' ? Column(
              children: List.generate(settings["metadata"]["data"].length,
                      (index) {
                    final indexData = settings["metadata"]["data"][index];

                    ProductInfo? productInfo = appConfig.getProductById(
                      id: indexData["id"],
                      dataType: settings["metadata"]['dataType'],
                    );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center,
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      children: [
                            (settings["metadata"]['dataType'] == "collection" || settings["metadata"]['dataType'] == "web-url") ? const SizedBox.shrink()  : logic.currentImageIndex.value == index? Column(
                          children: [
                            12.heightBox,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                HomeProductsPrice(
                                  price: productInfo!.price,
                                  priceColor: productInfo.compareAtPrice!= 0? AppColors.appPriceRedColor:AppColors.appTextColor,
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
                            : const SizedBox.shrink(),
                        logic.currentImageIndex.value == index? Column(
                          children: [
                            10.heightBox,
                            HomeProductsTitle(
                              title: productInfo!.title,
                            ),
                          ],
                        )
                            : const SizedBox.shrink(),
                        //   HomeProductsPrice(
                        //   price: productInfo!.price,
                        // ):SizedBox(),
                        // logic.currentImageIndex.value == index?  HomeProductsTitle(
                        //   title: productInfo!.title,
                        // ) :SizedBox(),

                      ],
                    );
                  }),
            ) : const SizedBox(),


            settings['titlePosition'] == 'bottom'? Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(settings["metadata"]["data"]
                    .length, (index) {
                 return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          top: 0,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(
                              milliseconds: 250),
                          height: 7.h,
                          width:
                          logic.currentImageIndex.value ==
                              index
                              ? 25.h
                              : 7.h,
                          decoration: logic.currentImageIndex
                              .value ==
                              index
                              ? BoxDecoration(
                              color: AppConfig
                                  .to.primaryColor.value,
                              borderRadius:
                              BorderRadius.circular(
                                  50.r))
                              : BoxDecoration(
                              color: AppColors
                                  .appBordersColor,
                              borderRadius:
                              BorderRadius.circular(
                                  50.r)),
                        ),
                      ),
                      4.widthBox
                    ],
                  );
                }



                    // Row(
                    //   // mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Container(
                    //       height: 10.h,
                    //       width: logic.currentImageIndex.value ==
                    //           index ? 23.w:10.w,
                    //       decoration: BoxDecoration(
                    //         borderRadius: logic.currentImageIndex.value ==
                    //             index ? BorderRadius.circular(5.r):null,
                    //           color: logic.currentImageIndex.value ==
                    //               index ? AppConfig.to.primaryColor.value : AppColors.appHintColor,
                    //           shape: logic.currentImageIndex.value ==
                    //               index? BoxShape.rectangle:BoxShape.circle,
                    //           border: logic.currentImageIndex.value ==
                    //               index ? null : Border.all(
                    //               color: Colors.grey,
                    //               width: 1
                    //           )
                    //       ),
                    //     ),
                    //     4.widthBox,
                    //
                    //   ],
                    // )
                ),
              ),
            ):SizedBox(),
          ],
        ),
      );
    });
  }
}