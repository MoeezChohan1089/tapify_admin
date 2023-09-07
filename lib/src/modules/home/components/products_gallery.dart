import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/app_config/config_controller.dart';
// import 'package:shopify_flutter/models/src/product/product.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../api_services/shopify_flutter/models/src/product/product.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../bottom_nav_bar/logic.dart';
import '../../category/view_category_products.dart';
import '../../product_detail/view.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class ProductsGallery extends StatelessWidget {
  final dynamic settings;


  ProductsGallery({Key? key, required this.settings}) : super(key: key);


  double getHeight(String str) {
    final heightMap = {
      'normal-small': 90.h,
      'normal-medium': 128.h,
      'normal-large': 170.h,
      'horizontal-small': 85.h,
      'horizontal-medium': 125.h,
      'horizontal-large': 165.h,
      'vertical-small': 120.h,
      'vertical-medium': 162.h,
      'vertical-large': 215.h,
    };
    return heightMap[str]!.toDouble();
  }

  double getWidth(String str) {
    final widthMap = {
      'normal-small': 90.h,
      'normal-medium': 128.h,
      'normal-large': 170.h,
      'horizontal-small': 112.w,
      'horizontal-medium': 152.w,
      'horizontal-large': 195.w,
      'vertical-small': 85.w,
      'vertical-medium': 120.w,
      'vertical-large': 165.w,
    };
    return widthMap[str]!.toDouble();
  }


  final appConfig = AppConfig.to;
  // final homeController = HomeLogic.to;


  @override
  Widget build(BuildContext context) {

    // _scrollController.jumpTo(0);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: settings['margin'] == true ? pageMarginVertical *
              1.5 : pageMarginVertical
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !settings["isTitleHidden"]
              ? Padding(
            padding: EdgeInsets.only(
              right: pageMarginHorizontal,
              left: settings["margin"]
                  ? pageMarginHorizontal * 2
                  : pageMarginHorizontal,
              top: settings["margin"] ? pageMarginVertical : 0,
            ),
            child: Row(
              mainAxisAlignment: settings["titleAlignment"] == "left"
                  ? MainAxisAlignment.start
                  : settings["titleAlignment"] == "right"
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
              children: [
                Text(settings["title"],
                    textAlign: settings["titleAlignment"] == "left"
                        ? TextAlign.left
                        : settings["titleAlignment"] == "right"
                        ? TextAlign.right
                        : TextAlign.center,
                    style: settings["titleSize"] == "small"
                        ? context.text.titleSmall
                        : settings["titleSize"] == "medium"
                        ? context.text.titleMedium
                        : context.text.titleLarge),
                // Text(
                //   'View All',
                //   style: context.text.bodySmall,
                // ),
              ],
            ),
          )
              : const SizedBox.shrink(),
          pageMarginVertical.heightBox,
          Obx(() {
            return
              // appConfig.isLoading.isTrue ?  const Center(
              //   child: SizedBox(
              //       height: 20,
              //       width: 20,
              //       child: CircularProgressIndicator()),
              // )  :
              appConfig.innerLoader.value == true? ShimerRectProductPage():
              SingleChildScrollView(
                controller: HomeLogic.to.circleProductScroll,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(
                  left: settings["margin"]
                      ? pageMarginHorizontal * 2
                      : pageMarginHorizontal,
                  // bottom: settings["margin"] ? pageMarginVertical - 5 : pageMarginVertical,

                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        (settings["metadata"]['productType'] == "automatic" && settings["metadata"]['dataType'] !=
                            "web-url")
                            ? settings["metadata"]["data"].length + 1
                            : settings["metadata"]["data"].length,
                            (index) {

                          ProductInfo? productInfo;
                          dynamic indexData;
                          if(index < settings["metadata"]["data"].length) {
                            indexData = settings["metadata"]["data"][index];
                            productInfo = appConfig.getProductById(
                              id: indexData["id"],
                              dataType: settings["metadata"]['dataType'],
                            );
                          }


                          return  (settings["metadata"]['productType'] == "automatic" && settings["metadata"]['dataType'] !=
                              "web-url") ?  index < settings["metadata"]["data"].length ?
                          GestureDetector(
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
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: getWidth(
                                  "${settings["displayType"]}-${settings["viewType"]}"),
                              margin: EdgeInsets.only(
                                right: !settings["contentMargin"] ? 18.w : 32.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: getHeight(
                                        "${settings["displayType"]}-${settings["viewType"]}"),
                                    width: getWidth(
                                        "${settings["displayType"]}-${settings["viewType"]}"),
                                    child:

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(3.r),
                                      child: CachedNetworkImage(
                                          imageUrl: indexData["path"] ?? productInfo!.image,


                                          // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                          //     ? productDetail!.images[0].originalSrc
                                          //     : "",
                                          fit: settings['imageFill'] == true ? BoxFit.cover:BoxFit.contain,
                                          height: double.infinity,
                                          width: double.infinity,
                                          placeholder: (context, url) =>
                                              productShimmer(),
                                          errorWidget:
                                              (context, url, error) =>
                                              Center(
                                                child: SvgPicture.asset(Assets.icons.noImageIcon,
                                                  height: 24.h,
                                                ),
                                              )
                                      ),
                                    ),

                                  ),
                                  !settings["hideContentPrice"]
                                      ? (settings["metadata"]['dataType'] == "collection" || settings["metadata"]['dataType'] == "web-url") ? const SizedBox.shrink()  : Column(
                                    children: [
                                      12.heightBox,
                                      HomeProductsPrice(
                                        price: productInfo!.price,
                                      ),
                                    ],
                                  )
                                      : const SizedBox.shrink(),
                                  !settings["hideContentTitle"]
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
                              ),
                            ),
                          )
                              : GestureDetector(
                            onTap: () {
                              if (settings['disableInteraction'] ==
                                  false) {

                                if(settings[
                                "metadata"]
                                ['dataType'] == "product" && settings[
                                "metadata"]
                                ['productType'] == "automatic"){
                                  Get.to(() => CategoryProducts(
                                      collectionID: settings["metadata"]['automaticProducts']['collection']['admin_graphql_api_id'],
                                      categoryName: settings["metadata"]['automaticProducts']['collection']['title']
                                  ), opaque: false, transition: Transition.native);
                                } else {
                                  BottomNavBarLogic.to.currentPageIndex.value = 1;
                                }



                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: getWidth(
                                  "${settings["displayType"]}-${settings["viewType"]}"),
                              margin: EdgeInsets.only(
                                right: !settings["contentMargin"] ? 18.w : 32.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: getHeight(
                                          "${settings["displayType"]}-${settings["viewType"]}"),
                                      width: getWidth(
                                          "${settings["displayType"]}-${settings["viewType"]}"),
                                      decoration: BoxDecoration(
                                          color: AppColors.customIconColor.withOpacity(.1),
                                          // border: Border.all(
                                          //     color: AppColors.customGreyPriceColor
                                          // )
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child:  Text(
                                          (settings[
                                          "metadata"]
                                          ['dataType'] == "product" && settings[
                                          "metadata"]
                                          ['productType'] == "automatic") ?    "View All\n${settings['metadata']['automaticProducts']['collection']['title']}" : "View All\n Collections",
                                          textAlign:
                                          TextAlign.center,
                                        ),
                                      )



                                  ),
                                ],
                              ),
                            ),
                          )

                              : GestureDetector(
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
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: getWidth(
                                  "${settings["displayType"]}-${settings["viewType"]}"),
                              margin: EdgeInsets.only(
                                right: !settings["contentMargin"] ? 18.w : 32.w,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: getHeight(
                                        "${settings["displayType"]}-${settings["viewType"]}"),
                                    width: getWidth(
                                        "${settings["displayType"]}-${settings["viewType"]}"),
                                    child:
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(3.r),
                                      child: CachedNetworkImage(
                                          imageUrl: indexData["path"] ?? productInfo!.image,


                                          // imageUrl: (productDetail?.images ?? []).isNotEmpty
                                          //     ? productDetail!.images[0].originalSrc
                                          //     : "",
                                          fit: settings['imageFill'] == true ? BoxFit.cover:BoxFit.contain,
                                          height: double.infinity,
                                          width: double.infinity,
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) =>
                                              productShimmer(),
                                          errorWidget:
                                              (context, url, error) =>
                                              Container(
                                                // decoration: BoxDecoration(
                                                //   color: Colors.white,
                                                //   // color: Colors.grey.shade100,
                                                // ),
                                                child: Center(
                                                  child: SvgPicture.asset(Assets.icons.noImageIcon,
                                                    height: 24.h,
                                                  ),
                                                ),
                                              )
                                      ),
                                    ),

                                  ),
                                  !settings["hideContentPrice"]
                                      ? (settings["metadata"]['dataType'] == "collection" || settings["metadata"]['dataType'] == "web-url") ? const SizedBox.shrink()  : Column(
                                    children: [
                                      12.heightBox,
                                      HomeProductsPrice(
                                        price: productInfo!.price,
                                      ),
                                    ],
                                  )
                                      : const SizedBox.shrink(),
                                  !settings["hideContentTitle"]
                                  // !settings["hideContentPrice"]
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
                              ),
                            ),
                          );
                        })),
              )
            ;
          })
        ],
      ),
    );
  }
}