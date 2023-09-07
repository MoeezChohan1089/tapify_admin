import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class ProductsCarousel extends StatefulWidget {
  final dynamic settings;

  ProductsCarousel({Key? key, required this.settings}) : super(key: key);

  @override
  State<ProductsCarousel> createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<ProductsCarousel> {
  // final carouselType = "Vertical-Small";
  double getFraction(String str) {
    final heightMap = {
      'normal-small': 0.5,
      'normal-medium': 0.55,
      'normal-large': 0.70,
      'horizontal-small': 0.5,
      'horizontal-medium': 0.55,
      'horizontal-large': 0.6,
      'vertical-small': 0.45,
      'vertical-medium': 0.55,
      'vertical-large': 0.75,
    };
    return heightMap[str]!.toDouble();
  }

  double getHeight(String str) {
    final heightMap = {
      'normal-small': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 250.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 260.h
          : 290.h,
      'normal-medium': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 270.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 280.h
          : 310.h,
      // 'normal-medium': 310.h,
      'normal-large': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 330.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 340.h
          : 370.h,
      // 'normal-large': 370.h,
      'horizontal-small': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 180.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 190.h
          : 220.h,
      // 'horizontal-small': 220.h,
      'horizontal-medium': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 200.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 210.h
          : 240.h,
      // 'horizontal-medium': 240.h,
      'horizontal-large': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 240.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 250.h
          : 280.h,
      // 'horizontal-large': 280.h,
      'vertical-small': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 320.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 330.h
          : 360.h,
      // 'vertical-small': 360.h,
      'vertical-medium': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 360.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 370.h
          : 400.h,
      // 'vertical-medium': 400.h,
      'vertical-large': (widget.settings["hideContentPrice"] &&
          widget.settings["hideContentTitle"])
          ? 390.h
          : (widget.settings["hideContentPrice"] ||
          widget.settings["hideContentTitle"])
          ? 400.h
          : 430.h,
      // 'vertical-large': 430.h,
    };
    return heightMap[str]!.toDouble();
  }

  final appConfig = AppConfig.to;

  // Rx<int> currentPage = 0.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // currentPage.value =
    // widget.settings["metadata"]["data"].length > 1 ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    // Rx<int> currentPage = 0.obs;

    return Obx(() {
      return appConfig.innerLoader.value == true
          ? Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: ShimerCarosalPage(),
          )
          : Padding(
        padding: EdgeInsets.symmetric(vertical: pageMarginVertical),
        child: Column(
          children: [
            !widget.settings["isTitleHidden"]
                ? Padding(
              padding: EdgeInsets.only(
                right: pageMarginHorizontal,
                left: widget.settings["margin"]
                    ? pageMarginHorizontal / 1.5
                    : pageMarginHorizontal / 1.5,
                top: widget.settings["margin"] ? 0 : 0,
              ),
              child: Row(
                mainAxisAlignment: widget
                    .settings["titleAlignment"] ==
                    "left"
                    ? MainAxisAlignment.start
                    : widget.settings["titleAlignment"] == "right"
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.center,
                children: [
                  Text(widget.settings["title"],
                      textAlign:
                      widget.settings["titleAlignment"] ==
                          "left"
                          ? TextAlign.left
                          : widget.settings["titleAlignment"] ==
                          "right"
                          ? TextAlign.right
                          : TextAlign.center,
                      style: widget.settings["titleSize"] == "small"
                          ? context.text.titleSmall
                          : widget.settings["titleSize"] == "medium"
                          ? context.text.titleMedium
                          : context.text.titleLarge),
                ],
              ),
            )
                : const SizedBox.shrink(),
            Container(
              color: Colors.yellow,
              child: pageMarginVertical.heightBox,
            ),
            Padding(
              padding: widget.settings["margin"]
                  ? EdgeInsets.only(
                right: pageMarginHorizontal / 1.5,
                left: pageMarginHorizontal / 1.5,
                top: pageMarginVertical,
              )
                  : const EdgeInsets.all(0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: getHeight(
                      "${widget.settings["displayType"]}-${widget.settings["viewType"]}"),
                  viewportFraction: getFraction(
                      "${widget.settings["displayType"]}-${widget.settings["viewType"]}"),
                  enableInfiniteScroll: false,
                  initialPage:
                  widget.settings["metadata"]["data"].length > 1
                      ? 1
                      : 0,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor:
                  // widget.settings["contentMargin"] == true
                  //     ? 0.45
                  //     :
                  0.3,
                  onPageChanged: (index, _) {
                    HomeLogic.to.currentCarouselIndex.value = index;
                  },
                  scrollDirection: Axis.horizontal,
                ),

                items: List.generate(
                    widget.settings["metadata"]["data"].length,
                        (itemIndex) {
                      final indexData =
                      widget.settings["metadata"]["data"][itemIndex];

                      ProductInfo? productInfo = appConfig.getProductById(
                        id: indexData["id"],
                        dataType: widget.settings["metadata"]['dataType'],
                      );
                      return GestureDetector(
                        onTap: () {
                          if (widget.settings['disableInteraction'] ==
                              false) {
                            HomeLogic.to.productDetailNavigator(
                                context: context,
                                info: productInfo!,
                                dataType: widget.settings["metadata"]
                                ['dataType']);
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                // color: Colors.green,
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                    widget.settings["contentMargin"] ==
                                        true
                                        ? 12.0
                                        : 3.0,),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.r),
                                  child:  ExtendedImage.network(
                                    indexData["path"] ??
                                        productInfo!.image,
                                    fit: widget.settings['imageFill'] == true
                                        ? BoxFit.cover
                                        : BoxFit.contain,
                                    height: double.infinity,
                                    width: double.infinity,
                                    cache: true,
                                    loadStateChanged: (ExtendedImageState state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return Container(
                                            height: double.maxFinite,
                                            width: double.maxFinite,
                                            color: Colors.white,
                                          );
                                      //   Shimmer.fromColors(
                                      //   baseColor: Colors.grey[300]!,
                                      //   highlightColor: Colors.grey[100]!,
                                      //   child: Container(
                                      //     width: 300,
                                      //     height: 200,
                                      //     color: Colors.grey[300],
                                      //   ),
                                      // );
                                        case LoadState.completed:
                                          return null; //return null, so it continues to display the loaded image
                                        case LoadState.failed:
                                          return Container(
                                              color: Colors.grey.shade200,
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  Assets.icons.noImageIcon,
                                                  height: 25.h,
                                                ),
                                              ));
                                        default:
                                          return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),

                            (widget.settings["hideContentPrice"] &&
                                widget.settings["hideContentTitle"])
                                ? const SizedBox.shrink()
                                : Obx(() {
                              return HomeLogic.to.currentCarouselIndex
                                  .value ==
                                  itemIndex
                                  ? Column(
                                children: [
                                  // SizedBox(height: 12.0),
                                  !widget.settings[
                                  "hideContentPrice"]
                                      ? (widget.settings["metadata"]
                                  [
                                  'dataType'] ==
                                      "collection" ||
                                      widget.settings[
                                      "metadata"]
                                      [
                                      'dataType'] ==
                                          "web-url")
                                      ? const SizedBox
                                      .shrink()
                                      : Column(
                                    children: [
                                      12.heightBox,
                                      HomeProductsPrice(
                                        price:
                                        productInfo!
                                            .price,
                                      ),
                                    ],
                                  )
                                      : const SizedBox.shrink(),
                                  !widget.settings[
                                  "hideContentTitle"]
                                      ? Column(
                                    children: [
                                      10.heightBox,
                                      HomeProductsTitle(
                                        title: productInfo!
                                            .title,
                                        titleHeight: 20.h,
                                      ),
                                    ],
                                  )
                                      : const SizedBox.shrink()
                                ],
                              )
                                  : 44.heightBox;
                            })
                            // : const SizedBox.shrink(),
                          ],
                        ),
                      );
                    }),

                // itemCount: widget.settings["metadata"]["data"].length,
                // itemBuilder: (BuildContext context, int itemIndex,
                //     int pageViewIndex) {
                //   final indexData =
                //       widget.settings["metadata"]["data"][itemIndex];
                //
                //   ProductInfo? productInfo = appConfig.getProductById(
                //     id: indexData["id"],
                //     dataType: widget.settings["metadata"]['dataType'],
                //   );
                //
                //   return GestureDetector(
                //     onTap: () {
                //       if (widget.settings['disableInteraction'] ==
                //           false) {
                //         HomeLogic.to.productDetailNavigator(
                //             context: context,
                //             info: productInfo!,
                //             dataType: widget.settings["metadata"]
                //                 ['dataType']);
                //       }
                //     },
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Expanded(
                //           child: Container(
                //             // color: Colors.green,
                //             margin: EdgeInsets.symmetric(
                //                 horizontal:
                //                     widget.settings["contentMargin"] ==
                //                             true
                //                         ? 12.0
                //                         : 3.0),
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(5.r),
                //               child: CachedNetworkImage(
                //                   imageUrl: indexData["path"] ??
                //                       productInfo!.image,
                //                   fit: widget.settings['imageFill'] ==
                //                           true
                //                       ? BoxFit.cover
                //                       : BoxFit.contain,
                //                   height: double.infinity,
                //                   width: double.infinity,
                //                   progressIndicatorBuilder: (context,
                //                           url, downloadProgress) =>
                //                       productShimmer(),
                //                   errorWidget: (context, url, error) =>
                //                       Center(
                //                         child: SvgPicture.asset(
                //                           Assets.icons.noImageIcon,
                //                           height: 24.h,
                //                         ),
                //                       )),
                //             ),
                //           ),
                //         ),
                //
                //         (widget.settings["hideContentPrice"] &&
                //                 widget.settings["hideContentTitle"])
                //             ? const SizedBox.shrink()
                //             : Obx(() {
                //                 return HomeLogic.to.currentCarouselIndex
                //                             .value ==
                //                         itemIndex
                //                     ? Column(
                //                         children: [
                //                           // SizedBox(height: 12.0),
                //                           !widget.settings[
                //                                   "hideContentPrice"]
                //                               ? (widget.settings["metadata"]
                //                                               [
                //                                               'dataType'] ==
                //                                           "collection" ||
                //                                       widget.settings[
                //                                                   "metadata"]
                //                                               [
                //                                               'dataType'] ==
                //                                           "web-url")
                //                                   ? const SizedBox
                //                                       .shrink()
                //                                   : Column(
                //                                       children: [
                //                                         12.heightBox,
                //                                         HomeProductsPrice(
                //                                           price:
                //                                               productInfo!
                //                                                   .price,
                //                                         ),
                //                                       ],
                //                                     )
                //                               : const SizedBox.shrink(),
                //                           !widget.settings[
                //                                   "hideContentTitle"]
                //                               ? Column(
                //                                   children: [
                //                                     10.heightBox,
                //                                     HomeProductsTitle(
                //                                       title:
                //                                           productInfo!
                //                                               .title,
                //                                       titleHeight: 20.h,
                //                                     ),
                //                                   ],
                //                                 )
                //                               : const SizedBox.shrink()
                //                         ],
                //                       )
                //                     : 44.heightBox;
                //               })
                //         // : const SizedBox.shrink(),
                //       ],
                //     ),
                //   );
                //
                // }
              ),
            )
          ],
        ),
      );
    });
  }
}