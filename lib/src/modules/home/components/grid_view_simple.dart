import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/category/logic.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../custom_widgets/custom_product_bottom_sheet.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../wishlist/logic.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class ProductGridViewSimple extends StatelessWidget {
  final dynamic settings;

  ProductGridViewSimple({Key? key, required this.settings}) : super(key: key);

  double calculateAspectRatio(String size, String viewType, bool isTitleHidden,
      bool showAddToCartButton, bool isPriceHidden) {
    if (size == 'normal') {
      if (viewType == 'small') {
        // Small size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.75; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.60; //------- when image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return settings["contentMargin"]
              ? .56
              : 0.58; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.64; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.64; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return settings["contentMargin"]
              ? .7
              : 0.8; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return settings["contentMargin"]
              ? 0.65
              : 0.7; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return settings["contentMargin"] ? .95 : 1.1; //----- when only image
        }
      } else if (viewType == 'medium') {
        // Medium size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return settings["contentMargin"]
              ? .76
              : 0.76; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.55; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return settings["contentMargin"]
              ? .5
              : 0.55; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.6; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.6; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.7; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return settings["contentMargin"]
              ? .6
              : 0.65; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.8; //----- when only image
        }
      } else if (viewType == 'large') {
        // Large size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.75; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.63; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.68; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.68; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.65; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.78; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.78; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.9; //----- when only image
        }
      }
    } else if (size == 'horizontal') {
      if (viewType == 'small') {
        // Small size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.83; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.60; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.72; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.70; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.70; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.9; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.9; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 1.2; //----- when only image
        }
      } else if (viewType == 'medium') {
        // Medium size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.8; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.6; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.7; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.7; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.7; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.8; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.8; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 1.0; //----- when only image
        }
      } else if (viewType == 'large') {
        // Large size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.8; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.7; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.75; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.75; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.75; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.85; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.85; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 1.0; //----- when only image
        }
      }
    } else if (size == 'vertical') {
      if (viewType == 'small') {
        // Small size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.63; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.45; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.52; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.50; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.50; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.6; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.6; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.7; //----- when only image
        }
      } else if (viewType == 'medium') {
        // Medium size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.63; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.45; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.52; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.50; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.50; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.6; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.6; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.7; //----- when only image
        }
      } else if (viewType == 'large') {
        // Large size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.6; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.5; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.55; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.5; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.5; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.6; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.6; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.7; //----- when only image
        }
      }
    }

    return 0.4; // Default aspect ratio if no conditions match
  }

  final appConfig = AppConfig.to;
  final logic1 = Get.put(CategoryLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appConfig.innerLoader.isTrue
          ? ShimerProductGridPage()
          : Padding(
              padding: settings["margin"]
                  ? EdgeInsets.only(
                      top: pageMarginVertical,
                      bottom: pageMarginVertical / 1.5,
                      right: pageMarginHorizontal / 1.5,
                      left: pageMarginHorizontal / 1.5)
                  : EdgeInsets.only(
                      bottom: pageMarginVertical / 1.5,
                    ),
              child: Column(
                children: [
                  !settings["isTitleHidden"]
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  settings["titleAlignment"] == "left"
                                      ? MainAxisAlignment.start
                                      : settings["titleAlignment"] == "right"
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.center,
                              children: [
                                Text(settings["title"],
                                    textAlign: settings["titleAlignment"] ==
                                            "left"
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
                            pageMarginVertical.heightBox,
                          ],
                        )
                      : const SizedBox.shrink(),
                  gridviewBuilder(context)
                ],
              ),
            );
    });
  }

  gridviewBuilder(BuildContext context) {
    return settings["viewType"] == "small"
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: settings["metadata"]["data"].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: calculateAspectRatio(
                settings["displayType"],
                settings["viewType"],
                settings["hideContentTitle"],
                settings["showAddToCart"],
                settings["hideContentPrice"],
              ),
              crossAxisSpacing: settings["contentMargin"] ? 16.w : 2.w,
              mainAxisSpacing: 5.h,
              // mainAxisSpacing: settings["contentMargin"] ? 10.h: 0.h,
            ),
            itemBuilder: (context, index) {
              final indexData = settings["metadata"]["data"][index];
              ProductInfo? productInfo = appConfig.getProductById(
                id: indexData["id"],
                dataType: settings["metadata"]['dataType'],
              );

              return widgetBuilder(context, productInfo, indexData);
            })
        : (settings["viewType"] == "medium"
            ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: settings["metadata"]["data"].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: calculateAspectRatio(
                    settings["displayType"],
                    settings["viewType"],
                    settings["hideContentTitle"],
                    settings["showAddToCart"],
                    settings["hideContentPrice"],
                  ),
                  crossAxisSpacing: settings["contentMargin"] ? 12.w : 1.w,
                  // mainAxisSpacing: 5.h,
                  mainAxisSpacing: settings["contentMargin"] ? 8.w : 4.w,
                ),
                itemBuilder: (context, index) {
                  final indexData = settings["metadata"]["data"][index];
                  ProductInfo? productInfo = appConfig.getProductById(
                    id: indexData["id"],
                    dataType: settings["metadata"]['dataType'],
                  );

                  return widgetBuilder(context, productInfo, indexData);
                })
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: settings["metadata"]["data"].length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: calculateAspectRatio(
                    settings["displayType"],
                    settings["viewType"],
                    settings["hideContentTitle"],
                    settings["showAddToCart"],
                    settings["hideContentPrice"],
                  ),
                  crossAxisSpacing: settings["contentMargin"] ? 16.w : 2.w,
                  mainAxisSpacing: 8.h,

                  // mainAxisSpacing: settings["contentMargin"] ? 10.h:0.h,
                ),
                itemBuilder: (context, index) {
                  final indexData = settings["metadata"]["data"][index];
                  ProductInfo? productInfo = appConfig.getProductById(
                    id: indexData["id"],
                    dataType: settings["metadata"]['dataType'],
                  );
                  return widgetBuilder(context, productInfo, indexData);
                }));
  }

  widgetBuilder(
      BuildContext context, ProductInfo? productInfo, dynamic indexData) {
    return GestureDetector(
      onTap: () {
        print("available for sale: ${productInfo.availableForSale}");
        if (settings['disableInteraction'] == false) {
          HomeLogic.to.productDetailNavigator(
              context: context,
              info: productInfo,
              dataType: settings["metadata"]['dataType']);
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: settings["hideBorders"]
                    ? null
                    : Border.all(color: AppColors.appBordersColor, width: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.r),
                  topRight: Radius.circular(3.r),
                  bottomLeft: settings["showAddToCart"]
                      ? Radius.circular(0.r)
                      : Radius.circular(3.r),
                  bottomRight: settings["showAddToCart"]
                      ? Radius.circular(0.r)
                      : Radius.circular(3.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.r),
                  topRight: Radius.circular(3.r),
                  bottomLeft: settings["showAddToCart"]
                      ? Radius.circular(0.r)
                      : Radius.circular(3.r),
                  bottomRight: settings["showAddToCart"]
                      ? Radius.circular(0.r)
                      : Radius.circular(3.r),
                ),
                child: productInfo!.image.isNotEmpty
                    ? FadeInImage.memoryNetwork(
                        image: indexData["path"] ?? productInfo.image,
                        fit: settings['imageFill'] == true
                            ? BoxFit.cover
                            : BoxFit.contain,
                        height: double.infinity,
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
          settings["viewType"] != "small"
              ? settings["showAddToCart"]
                  ? GestureDetector(
                      onTap: () {
                        if (productInfo.availableForSale == true) {
                          HapticFeedback.lightImpact();
                          ProductSheet.to.productDetailBottomSheet(
                              context: context,
                              fetchProductDetail: true,
                              productInfo: productInfo);
                        }
                      },
                      child: Container(
                        height: 28.h,
                        decoration: BoxDecoration(
                          color: productInfo.availableForSale == true
                              ? AppConfig.to.quickViewBGColor.value
                              : AppColors.appHintColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3.r),
                            bottomRight: Radius.circular(3.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: productInfo.availableForSale == true
                                  ? AppConfig.to.quickViewBGColor.value
                                  : AppColors.appHintColor,
                              blurRadius: 0,
                              offset: Offset(0, -1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: productInfo.availableForSale == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color:
                                          AppConfig.to.quickViewTextColor.value,
                                      size: 12.sp,
                                    ),
                                    2.widthBox,
                                    Text(
                                      // productInfo.isAvailable == true ?
                                      "Quick Add  ",
                                      // "":"Out Of Stock",
                                      style: context.text.bodySmall?.copyWith(
                                        color: AppConfig
                                            .to.quickViewTextColor.value,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "SOLD OUT",
                                      textAlign: TextAlign.center,
                                      style: context.text.bodySmall?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink(),
          !settings["hideContentPrice"] ? 8.heightBox : 0.heightBox,
          !settings["hideContentPrice"]
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            productInfo.price == 0
                                ? "FREE"
                                : CurrencyController.to.getConvertedPrice(
                                    priceAmount: productInfo.price),
                            maxLines: 1,
                            style: context.text.bodyMedium?.copyWith(
                                color: productInfo.compareAtPrice != 0
                                    ? AppColors.appPriceRedColor
                                    : AppColors.appTextColor,
                                letterSpacing: .01,
                                height: .5),
                          ),
                          productInfo.compareAtPrice != 0
                              ? Row(
                                  children: [
                                    4.widthBox,
                                    Text(
                                      CurrencyController.to.getConvertedPrice(
                                          priceAmount:
                                              productInfo.compareAtPrice,
                                          includeSign: false),
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      style: context.text.bodySmall?.copyWith(
                                          color: AppColors.appHintColor,
                                          fontSize: 11.sp,
                                          height: .5,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    3.widthBox,
                    settings['viewType'] == 'large'
                        ? Obx(() {
                            bool isProductInWishlist = WishlistLogic.to
                                    .checkIfExistsInBookmark(
                                        id: productInfo.id) !=
                                -1;
                            return GestureDetector(
                              onTap: () {
                                // HapticFeedback.lightImpact();

                                WishlistLogic.to.getProductFromID(
                                    context: context,
                                    productID: productInfo.id);

                                // WishlistLogic.to.addOrRemoveBookmark(
                                //     context: context,
                                //     product: productsList.value[index]);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: settings['viewType'] != 'small'
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: SvgPicture.asset(
                                          isProductInWishlist
                                              ? Assets.icons.heartFilled
                                              : Assets.icons.heartOutlined,
                                          height: 20.h,
                                          color: isProductInWishlist
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      )
                                    : SizedBox(),
                              ),
                            );
                          })
                        : const SizedBox(),
                  ],
                )
              : const SizedBox.shrink(),
          4.heightBox,
          !settings["hideContentTitle"]
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.yellow,
                        padding: const EdgeInsets.only(top: 3),

                        height: 20,
                        // height: settings["hideContentPrice"]
                        //     ? 30 : 20,
                        child: Text(
                          // "hi this is dummy text for title to check how the line will work",
                          productInfo!.title,
                          maxLines: settings["hideContentPrice"] ? 2 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.text.bodySmall?.copyWith(
                            height: 1.0,
                            color: AppColors.appTextColor,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ),
                    3.widthBox,
                    settings["hideContentPrice"]
                        ? Obx(() {
                            bool isProductInWishlist = WishlistLogic.to
                                    .checkIfExistsInBookmark(
                                        id: productInfo!.id) !=
                                -1;
                            return GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();

                                WishlistLogic.to.getProductFromID(
                                    context: context,
                                    productID: productInfo.id);

                                // WishlistLogic.to.addOrRemoveBookmark(
                                //     context: context,
                                //     product: productInfo);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: SizedBox(
                                  // color: Colors.yellow,

                                  height: 20,
                                  child: settings['viewType'] == 'large'
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: SvgPicture.asset(
                                            isProductInWishlist
                                                ? Assets.icons.heartFilled
                                                : Assets.icons.heartOutlined,
                                            height: 20.h,
                                            color: isProductInWishlist
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                              ),
                            );
                          })
                        : SizedBox(),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
