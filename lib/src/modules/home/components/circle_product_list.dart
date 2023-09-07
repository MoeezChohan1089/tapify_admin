import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// import 'package:shopify_flutter/models/models.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tapify_admin/src/modules/home/logic.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../bottom_nav_bar/logic.dart';
import '../../category/view_category_products.dart';
import '../../product_detail/view.dart';
import '../models/product_info_model.dart';

class CircularProductList extends StatefulWidget {
  final dynamic settings;

  // final PanelController? control;

  const CircularProductList(
      {Key? key,
        // this.control,
        required this.settings})
      : super(key: key);

  @override
  State<CircularProductList> createState() => _CircularProductListState();
}

class _CircularProductListState extends State<CircularProductList> {


  final appConfig = AppConfig.to;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appConfig.isLoading.isTrue
          ? ShimerCircularProductPage()
          : Padding(
        padding: widget.settings['margin'] == true? EdgeInsets.symmetric(
            vertical: pageMarginVertical * 2, horizontal: 2)
            :EdgeInsets.only(top: pageMarginVertical, bottom: pageMarginVertical/2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.settings['isTitleHidden'] == false)
                ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.settings['margin'] == true
                    ? pageMarginHorizontal * 2
                    : pageMarginHorizontal,
              ),
              child: SizedBox(
                width: double.maxFinite,
                child: Text("${widget.settings['title']}",
                    textAlign:
                    widget.settings['titleAlignment'] == 'left'
                        ? TextAlign.left
                        : widget.settings['titleAlignment'] ==
                        'center'
                        ? TextAlign.center
                        : TextAlign.right,
                    style: widget.settings['titleSize'] == "small"
                        ? context.text.titleSmall
                        : widget.settings['titleSize'] == "medium"
                        ? context.text.titleMedium
                        : context.text.titleLarge),
              ),
            )
                : const SizedBox(),
            (pageMarginVertical + 2.h).heightBox,

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(
                left: widget.settings['margin'] == true
                    ? pageMarginHorizontal * 2
                    : pageMarginHorizontal,
                bottom:   widget.settings[
                "hideContentTitle"] ==
                    true
                    ? 14.h
                    : 0.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    (widget.settings["metadata"]['productType'] ==
                        "automatic" && widget.settings["metadata"]['dataType'] !=
                        "web-url")
                        ? widget.settings["metadata"]["data"].length + 1
                        : widget.settings["metadata"]["data"].length,
                        (index) {
                      ProductInfo? productInfo;
                      dynamic indexData;
                      if (index <
                          widget.settings["metadata"]["data"].length) {
                        indexData =
                        widget.settings["metadata"]["data"][index];
                        productInfo = appConfig.getProductById(
                          id: indexData["id"],
                          dataType: widget.settings["metadata"]['dataType'],
                        );
                      }

                      return (widget.settings["metadata"]['productType'] ==
                          "automatic" && widget.settings["metadata"]['dataType'] !=
                          "web-url")
                          ? index <
                          widget
                              .settings["metadata"]["data"].length

                      ///--- this is when automatic and under index
                          ? productInfo != null &&
                          appConfig.isLoading.isFalse
                          ? Container(
                        margin: EdgeInsets.only(
                            right: widget.settings[
                            'contentMargin'] ==
                                true
                                ? pageMarginHorizontal * 2
                                : pageMarginHorizontal + 4.w),
                        child: GestureDetector(
                          onTap: () {
                            if (widget.settings[
                            'disableInteraction'] ==
                                false) {
                              HomeLogic.to
                                  .productDetailNavigator(
                                  context: context,
                                  info: productInfo!,
                                  dataType: widget.settings[
                                  "metadata"]
                                  ['dataType']);
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                width: widget.settings[
                                'viewType'] ==
                                    "small"
                                    ? 90
                                    : widget.settings[
                                'viewType'] ==
                                    "medium"
                                    ? 120
                                    : 175,
                                height: widget.settings[
                                'viewType'] ==
                                    "small"
                                    ? 90
                                    : widget.settings[
                                'viewType'] ==
                                    "medium"
                                    ? 120
                                    : 175,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  // border: Border.all(
                                  //   color: AppColors
                                  //       .customIconColor,
                                  //   width: 1,
                                  // ),
                                ),
                                child: CachedNetworkImage(
                                    imageUrl: indexData["path"] ??
                                        productInfo.image,
                                    // imageUrl: productDetail.images.isNotEmpty ?  productDetail.images[0].originalSrc : "",
                                    imageBuilder: (context,
                                        imageProvider) =>
                                        CircleAvatar(
                                          backgroundImage:
                                          imageProvider,
                                          backgroundColor: Colors.transparent,
                                        ),
                                    placeholder: (context, url) =>
                                        productCircleShimmer(),
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

                              widget.settings[
                              "hideContentTitle"] ==
                                  false
                                  ? 10.heightBox
                                  : const SizedBox(),

                              widget.settings[
                              "hideContentTitle"] ==
                                  false
                                  ? SizedBox(
                                width: widget.settings[
                                'viewType'] ==
                                    "small"
                                    ? 90
                                    : widget.settings[
                                'viewType'] ==
                                    "medium"
                                    ? 115
                                    : 160,
                                child: HomeProductsTitle(
                                  title:
                                  productInfo.title,
                                ),
                              )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      )
                          : Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: AppColors.customWhiteTextColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              (pageMarginVertical / 3).heightBox,
                              Container(
                                width: 80.w,
                                height: 18.h,
                                color: AppColors.customWhiteTextColor,
                              ),
                            ],
                          ),
                        ),
                      )

                      ///--- this is when automatic and out of index
                          : Container(
                        margin: EdgeInsets.only(
                            right: widget.settings[
                            'contentMargin'] ==
                                true
                                ? pageMarginHorizontal * 2
                                : pageMarginHorizontal + 4.w),
                        child: GestureDetector(
                          onTap: () {
                            if (widget.settings[
                            'disableInteraction'] ==
                                false) {


                              if(widget.settings[
                              "metadata"]
                              ['dataType'] == "product" && widget.settings[
                              "metadata"]
                              ['productType'] == "automatic"){
                                Get.to(() => CategoryProducts(
                                    collectionID: widget.settings[
                                    "metadata"]
                                    ['automaticProducts']
                                    ['collection']
                                    ['admin_graphql_api_id'],
                                    categoryName: widget.settings[
                                    "metadata"]
                                    ['automaticProducts']
                                    ['collection']['title']),
                                  opaque: false,
                                    transition: Transition.native
                                );
                              } else {
                                BottomNavBarLogic.to.currentPageIndex.value = 1;
                              }


                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                  width: widget.settings[
                                  'viewType'] ==
                                      "small"
                                      ? 90
                                      : widget.settings[
                                  'viewType'] ==
                                      "medium"
                                      ? 125
                                      : 175,
                                  height: widget.settings[
                                  'viewType'] ==
                                      "small"
                                      ? 90
                                      : widget.settings[
                                  'viewType'] ==
                                      "medium"
                                      ? 125
                                      : 175,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.customIconColor.withOpacity(.1),
                                    // border: Border.all(
                                    //   color: AppColors
                                    //       .customIconColor,
                                    //   width: 1,
                                    // ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      (widget.settings[
                                      "metadata"]
                                      ['dataType'] == "product" && widget.settings[
                                      "metadata"]
                                      ['productType'] == "automatic") ?    "View All\n${widget.settings['metadata']['automaticProducts']['collection']['title']}" : "View All\n Collections",
                                      textAlign:
                                      TextAlign.center,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      )

                      ///------ this is when simple/other types of products
                          : productInfo != null &&
                          appConfig.isLoading.isFalse
                          ? Container(
                        margin: EdgeInsets.only(
                            right:
                            widget.settings['contentMargin'] ==
                                true
                                ? pageMarginHorizontal * 2
                                : pageMarginHorizontal + 4.w),
                        child: GestureDetector(
                          onTap: () {
                            if (widget.settings[
                            'disableInteraction'] ==
                                false) {
                              HomeLogic.to.productDetailNavigator(
                                  context: context,
                                  info: productInfo!,
                                  dataType:
                                  widget.settings["metadata"]
                                  ['dataType']);
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                width: widget
                                    .settings['viewType'] ==
                                    "small"
                                    ? 90
                                    : widget.settings['viewType'] ==
                                    "medium"
                                    ? 120
                                    : 175,
                                height: widget
                                    .settings['viewType'] ==
                                    "small"
                                    ? 90
                                    : widget.settings['viewType'] ==
                                    "medium"
                                    ? 120
                                    : 175,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  // border : Border.all(
                                  //   color:
                                  //   AppColors.customIconColor,
                                  //   width: .5,
                                  // ),
                                ),
                                child: CachedNetworkImage(
                                    imageUrl: indexData["path"] ??
                                        productInfo.image,
                                    imageBuilder:
                                        (context, imageProvider) {
                                      return CircleAvatar(
                                        backgroundImage: imageProvider,
                                        backgroundColor: Colors.transparent,
                                        // onBackgroundImageError:  (url, error) =>
                                        // const Icon(Icons.error),
                                      );},
                                    placeholder: (context, url) =>
                                        productCircleShimmer(),

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
                              // SizedBox(
                              //   height: 10,
                              // ),
                              widget.settings["hideContentTitle"] ==
                                  false
                                  ? 10.heightBox
                                  : const SizedBox(),
                              widget.settings["hideContentTitle"] ==
                                  false
                                  ? SizedBox(
                                width: widget.settings[
                                'viewType'] ==
                                    "small"
                                    ? 90
                                    : widget.settings[
                                'viewType'] ==
                                    "medium"
                                    ? 115
                                    : 160,
                                child: HomeProductsTitle(
                                  title: productInfo.title,
                                ),
                                // Text(
                                //   productInfo.title,
                                //   maxLines: 2,
                                //   overflow: TextOverflow.fade,
                                //   textAlign: TextAlign.center,
                                //   style: getHomeProductTitleStyle(context),
                                // ),
                              )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      )
                          : Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: AppColors.customWhiteTextColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              (pageMarginVertical / 3).heightBox,
                              Container(
                                width: 80.w,
                                height: 18.h,
                                color: AppColors.customWhiteTextColor,
                              ),
                            ],
                          ),
                        ),
                      )

                      ;
                    }),
              ),
            ),

          ],
        ),
      );
    });
  }

// _settingModalBottomSheet(context, PanelController controller) {
//   // TextEditingController _controller = new TextEditingController();
//
//   SlidingUpPanel(
//     controller: controller,
//     minHeight: 0,
//     backdropEnabled: true,
//     panel: Center(
//       child: Text("This is the sliding Widget"),
//     ),
//     body: Scaffold(
//       appBar: AppBar(
//         title: Text("SlidingUpPanelExample"),
//       ),
//       body: Center(
//         child: Text("This is the Widget behind the sliding panel"),
//       ),
//     ),
//   );
// }
}