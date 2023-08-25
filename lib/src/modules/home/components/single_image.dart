import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../custom_widgets/product_viewer_web.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class SingleImageWidget extends StatelessWidget {
  final dynamic settings;

  SingleImageWidget({Key? key, required this.settings}) : super(key: key);

  final String imageSize = "square";

  double getWidth(String str) {
    switch (str) {
      case 'normal-small':
        return 300;
      case 'normal-small':
        return 142;
      case 'normal-small':
        return 180;
      case 'horizontal-small':
        return 230;
      case 'horizontal-small':
        return 212;
      case 'horizontal-small':
        return 248;
      case 'vertical-small':
        return 400;
      case 'vertical-small':
        return 140;
      case 'vertical-small':
        return 179;
      case 'auto-small':
        return -1;
      case 'auto-small':
        return 140;
      case 'auto-small':
        return 179;
      default:
        return 0; // return a default value if the string doesn't match any case
    }
  }

  customBoxCategory(String src) {
    Image image = Image.asset(src);

    return Container(
      // padding: EdgeInsets.symmetric(
      //   horizontal: pageMarginHorizontal
      // ),
      width: double.maxFinite,
      height: getWidth("${settings['displayType']}-${settings['viewType']}"),
      // height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.customIconColor),
      ),
      child: Image.asset(
        src,
        fit: BoxFit.fill,
      ),
    );
  }

  final appConfig = AppConfig.to;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appConfig.innerLoader.value == true
          ? productShimmer()
          : Column(
              children: [
                (settings['isTitleHidden'] == false)
                    ? SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: settings['margin'] == true
                              ? EdgeInsets.symmetric(
                                  horizontal: pageMarginHorizontal / 1.5,
                                  vertical: pageMarginVertical / 1.5)
                              : EdgeInsets.symmetric(
                                  vertical: pageMarginVertical / 1.5,
                                  horizontal: pageMarginHorizontal / 1.5),
                          child: Text('${settings['title']}',
                              textAlign: settings['titleAlignment'] == "left"
                                  ? TextAlign.left
                                  : settings['titleAlignment'] == "center"
                                      ? TextAlign.center
                                      : TextAlign.right,
                              style: settings['titleSize'] == "small"
                                  ? context.text.titleSmall
                                  : settings['titleSize'] == "medium"
                                      ? context.text.titleMedium
                                      : context.text.titleLarge),
                        ),
                      )
                    : const SizedBox(),

                (settings["image"] != null &&
                        settings["metadata"]["data"].isEmpty)
                    ? singleImageVariant()
                    : customImageVariant(context),

                // Column(
                //   children: List.generate(
                //      settings['metadata']['data'].isEmpty ? 1 : settings['metadata']['data'].length
                //       , (index) {
                //     ProductInfo? productInfo;
                //        if(settings['metadata']['data'].isNotEmpty) {
                //          final indexData = settings["metadata"]["data"][index];
                //          ProductInfo? productInfo = appConfig.getProductById(
                //            id: indexData["id"],
                //            dataType: settings["metadata"]['dataType'],
                //          );
                //        }
                //
                //     return GestureDetector(
                //       onTap: () {
                //         if (settings['disableInteraction'] ==
                //             false && settings['metadata']['data'].isNotEmpty) {
                //           HomeLogic.to.productDetailNavigator(
                //               context: context,
                //               info: productInfo!,
                //               dataType: settings["metadata"]['dataType']
                //           );
                //         }
                //       },
                //       child: Column(
                //         children: [
                //           Stack(
                //             children: [
                //              Padding(
                //                 padding: settings['margin'] == true? EdgeInsets.symmetric(horizontal: pageMarginHorizontal/1.5,  vertical: settings['contentMargin'] == true ? pageMarginVertical:0):EdgeInsets.zero,
                //                 child: Container(
                //                 width: double.maxFinite,
                //                   height: settings['displayType'] == "normal" ? 300: settings['displayType'] == "vertical"? 400: settings['displayType'] == "auto"? null:230,
                //                   decoration: BoxDecoration(
                //                     borderRadius: settings['margin'] == true? BorderRadius.circular(5.r):BorderRadius.circular(0),
                //                    ),
                //                   child: ClipRRect(
                //                     borderRadius: settings['margin'] == true? BorderRadius.circular(3.r):BorderRadius.circular(0),
                //                     child: CachedNetworkImage(
                //                       imageUrl:
                //                       settings['image'] ?? productInfo?.image,
                //                       color: settings['titlePosition'] == "center" ?  Colors.black.withOpacity(0.4):null,
                //                       colorBlendMode: settings['titlePosition'] == "center" ? BlendMode.darken:null,
                //                       fit: BoxFit.cover,
                //                       height: settings['displayType'] == "normal"? 300: settings['displayType'] == "vertical"? 600: settings['displayType'] == "auto"? null:230,
                //                       width: double.infinity,
                //                       progressIndicatorBuilder:
                //                           (context, url, downloadProgress) =>
                //                           productShimmer(),
                //                       errorWidget: (context, url, error) =>
                //                       const Icon(Icons.error),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 left: 0,
                //                 right: 0,
                //                 top: 0,
                //                 bottom: 0,
                //                 child: settings['titlePosition'] == "center" ? Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //
                //
                //                     (settings["metadata"]['dataType'] ==
                //                         "collection" ||
                //                         settings["metadata"]['dataType'] == "web-url")
                //                         ? const SizedBox.shrink(): Column(
                //                       children: [
                //                         12.heightBox,
                //                         HomeProductsPrice(
                //                           price: productInfo!.price,
                //                           priceColor: AppColors.customWhiteTextColor,
                //                         ),
                //                       ],
                //                     )
                //                         ,
                //                     HomeProductsTitle(
                //                       title: productInfo!.title,
                //                       textColor: AppColors.customWhiteTextColor,
                //                     ),
                //
                //                     //------ Price
                //                     // productInfo.price != 0.0 ?  Text.rich(
                //                     //   TextSpan(
                //                     //     children: <InlineSpan>[
                //                     //       WidgetSpan(
                //                     //         child: Padding(
                //                     //           padding: const EdgeInsets.only(right: 10), // Add the desired space here
                //                     //           child: Text(
                //                     //             ' \$80',
                //                     //             style: context.text.bodyLarge?.copyWith(
                //                     //               color: AppColors.customGreyTextColor,
                //                     //             ),
                //                     //           ),
                //                     //         ),
                //                     //       ),
                //                     //       WidgetSpan(
                //                     //         child: Text(
                //                     //           '\$100',
                //                     //           style: context.text.bodyLarge?.copyWith(
                //                     //             color: AppColors.customGreyTextColor,
                //                     //             decoration: TextDecoration.lineThrough,
                //                     //           ),
                //                     //           // style: TextStyle(
                //                     //           //   color: AppColors.customIconColor,
                //                     //           //   fontFamily: "Sofia Pro Regular",
                //                     //           //   decoration: TextDecoration.lineThrough,
                //                     //           // ),
                //                     //         ),
                //                     //       ),
                //                     //     ],
                //                     //   ),
                //                     // ) : const SizedBox.shrink(),
                //                   ],
                //                 ) : SizedBox(),)
                //             ],
                //           ),
                //
                //
                //           (settings["metadata"]['dataType'] == "collection" ||
                //               settings["metadata"]['dataType'] == "web-url")
                //               ? (pageMarginVertical).heightBox
                //               : (pageMarginVertical / 2).heightBox,
                //           settings['titlePosition'] == "bottom" ? Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               (settings["metadata"]['dataType'] == "collection" ||
                //                   settings["metadata"]['dataType'] == "web-url")
                //                   ? const SizedBox.shrink()
                //                   : Column(
                //                 children: [
                //                   12.heightBox,
                //                   HomeProductsPrice(
                //                     price: productInfo!.price,
                //                   ),
                //                 ],
                //               ),
                //               HomeProductsTitle(
                //                 title: productInfo!.title,
                //               ),
                //             ],
                //           ) : const SizedBox(),
                //         ],
                //       ),
                //     );
                //   }),
                // ),
              ],
            );
    });
  }

  singleImageVariant() {
    return GestureDetector(
      onTap: () {
        if (settings['disableInteraction'] == false &&
            settings["web_url"] != null) {
          ///------ Open the Web
          Get.to(() => WebViewProduct(
                productUrl: settings["web_url"],
              ));
        }
      },
      child: Padding(
        padding: settings['margin'] == true
            ? EdgeInsets.only(
                left: pageMarginHorizontal / 1.5,
                right: pageMarginHorizontal / 1.5,
                bottom: settings['contentMargin'] == true
                    ? pageMarginVertical * 1.7
                    : pageMarginHorizontal / 1.5,
                top: settings['contentMargin'] == true
                    ? pageMarginVertical * 2.1
                    : pageMarginHorizontal / 1.5)
            : settings['contentMargin'] == true
                ? EdgeInsets.only(
                    top: pageMarginVertical * 1.5, bottom: pageMarginVertical)
                : EdgeInsets.zero,
        child: Container(
          width: double.maxFinite,
          height: settings['displayType'] == "normal"
              ? 300
              : settings['displayType'] == "vertical"
                  ? 400
                  : settings['displayType'] == "auto"
                      ? null
                      : 230,
          decoration: BoxDecoration(
            borderRadius: settings['margin'] == true
                ? BorderRadius.circular(5.r)
                : BorderRadius.circular(0),
          ),
          child: ClipRRect(
            borderRadius: settings['margin'] == true
                ? BorderRadius.circular(3.r)
                : BorderRadius.circular(0),
            child: settings['image'] != null
                ? FadeInImage.memoryNetwork(
                    image: settings['image'],
                    // color: settings['titlePosition'] == "center" ?  Colors.black.withOpacity(0.4):null,
                    // colorBlendMode: settings['titlePosition'] == "center" ? BlendMode.darken:null,
                    fit: BoxFit.cover,
                    height: settings['displayType'] == "normal"
                        ? 300
                        : settings['displayType'] == "vertical"
                            ? 600
                            : settings['displayType'] == "auto"
                                ? null
                                : 230,
                    width: double.infinity,
                    imageErrorBuilder: (context, url, error) => Container(
                      color: Colors.grey.shade200,
                      // color: Colors.grey.shade200,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.icons.noImageIcon,
                          height: 25.h,
                        ),
                      ),
                    ),

                    // progressIndicatorBuilder:
                    //     (context, url, downloadProgress) =>
                    //     productShimmer(),
                    // errorWidget: (context, url, error) =>
                    // const Icon(Icons.error),
                    placeholder: kTransparentImage,
                  )
                : Container(
                    color: Colors.grey.shade200,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.icons.noImageIcon,
                        height: 25.h,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  customImageVariant(BuildContext context) {
    ProductInfo? productInfo = appConfig.getProductById(
      id: settings["metadata"]["data"][0]["id"],
      dataType: settings["metadata"]['dataType'],
    );

    return GestureDetector(
      onTap: () {
        if (settings['disableInteraction'] == false &&
            settings['metadata']['data'].isNotEmpty) {
          HomeLogic.to.productDetailNavigator(
              context: context,
              info: productInfo!,
              dataType: settings["metadata"]['dataType']);
        }
      },
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: settings['margin'] == true
                    ? EdgeInsets.only(
                        left: pageMarginHorizontal / 1.5,
                        right: pageMarginHorizontal / 1.5,
                        bottom: settings['contentMargin'] == true
                            ? pageMarginVertical
                            : 0,
                        top: settings['contentMargin'] == true
                            ? pageMarginVertical
                            : pageMarginHorizontal / 1.5)
                    : settings['contentMargin'] == true
                        ? EdgeInsets.only(
                            top: pageMarginVertical + 15,
                            bottom: pageMarginVertical - 5)
                        : EdgeInsets.zero,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: settings['displayType'] == "normal"
                          ? 300
                          : settings['displayType'] == "vertical"
                              ? 400
                              : settings['displayType'] == "auto"
                                  ? null
                                  : 230,
                      decoration: BoxDecoration(
                        borderRadius: settings['margin'] == true
                            ? BorderRadius.circular(5.r)
                            : BorderRadius.circular(0),
                      ),
                      child: ClipRRect(
                        borderRadius: settings['margin'] == true
                            ? BorderRadius.circular(3.r)
                            : BorderRadius.circular(0),
                        child: Stack(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[300],
                                height: settings['displayType'] == "normal"
                                    ? 300
                                    : settings['displayType'] == "vertical"
                                        ? 600
                                        : settings['displayType'] == "auto"
                                            ? null
                                            : 230,
                                width: double.infinity,
                              ),
                            ),
                            FadeInImage.memoryNetwork(
                              image: settings['image'] ??
                                  "${productInfo?.image.split("?v=")[0]}?width=300}",
                              fit: BoxFit.cover,
                              height: settings['displayType'] == "normal"
                                  ? 300
                                  : settings['displayType'] == "vertical"
                                      ? 600
                                      : settings['displayType'] == "auto"
                                          ? null
                                          : 230,
                              width: double.infinity,
                              imageErrorBuilder: (context, url, error) =>
                                  Container(
                                color: Colors.grey.shade200,
                                // color: Colors.grey.shade200,
                                child: Center(
                                  child: SvgPicture.asset(
                                    Assets.icons.noImageIcon,
                                    height: 25.h,
                                  ),
                                ),
                              ),
                              // progressIndicatorBuilder:
                              //     (context, url, downloadProgress) =>
                              //     productShimmer(),
                              // errorWidget: (context, url, error) =>
                              // const Icon(Icons.error),
                              placeholder: kTransparentImage,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        width: double.maxFinite,
                        height: settings['displayType'] == "normal"
                            ? 300
                            : settings['displayType'] == "vertical"
                                ? 400
                                : settings['displayType'] == "auto"
                                    ? null
                                    : 230,
                        // height: 400,
                        decoration: BoxDecoration(
                          color: settings['titlePosition'] == "center"
                              ? Colors.black.withOpacity(0.4)
                              : null,
                          borderRadius: settings['margin'] == true
                              ? BorderRadius.circular(5.r)
                              : BorderRadius.circular(0),
                          // colorBlendMode: settings['titlePosition'] == "center" ? BlendMode.darken:null,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: settings['titlePosition'] == "center"
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (settings["metadata"]['dataType'] == "collection" ||
                                    settings["metadata"]['dataType'] ==
                                        "web-url")
                                ? const SizedBox.shrink()
                                : Column(
                                    children: [
                                      12.heightBox,
                                      HomeProductsPrice(
                                        price: productInfo!.price,
                                        priceColor:
                                            AppColors.customWhiteTextColor,
                                      ),
                                    ],
                                  ),
                            HomeProductsTitle(
                              title: productInfo!.title,
                              textColor: AppColors.customWhiteTextColor,
                            ),

                            //------ Price
                            // productInfo.price != 0.0 ?  Text.rich(
                            //   TextSpan(
                            //     children: <InlineSpan>[
                            //       WidgetSpan(
                            //         child: Padding(
                            //           padding: const EdgeInsets.only(right: 10), // Add the desired space here
                            //           child: Text(
                            //             ' \$80',
                            //             style: context.text.bodyLarge?.copyWith(
                            //               color: AppColors.customGreyTextColor,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       WidgetSpan(
                            //         child: Text(
                            //           '\$100',
                            //           style: context.text.bodyLarge?.copyWith(
                            //             color: AppColors.customGreyTextColor,
                            //             decoration: TextDecoration.lineThrough,
                            //           ),
                            //           // style: TextStyle(
                            //           //   color: AppColors.customIconColor,
                            //           //   fontFamily: "Sofia Pro Regular",
                            //           //   decoration: TextDecoration.lineThrough,
                            //           // ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ) : const SizedBox.shrink(),
                          ],
                        )
                      : const SizedBox())
            ],
          ),
          (settings["metadata"]['dataType'] == "collection" ||
                  settings["metadata"]['dataType'] == "web-url")
              ? (pageMarginVertical).heightBox
              : (pageMarginVertical / 2).heightBox,
          settings['titlePosition'] == "bottom"
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (settings["metadata"]['dataType'] == "collection" ||
                            settings["metadata"]['dataType'] == "web-url")
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              12.heightBox,
                              HomeProductsPrice(
                                price: productInfo!.price,
                              ),
                            ],
                          ),
                    HomeProductsTitle(
                      title: productInfo!.title,
                    ),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
