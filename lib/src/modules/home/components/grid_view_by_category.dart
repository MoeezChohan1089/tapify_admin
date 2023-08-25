import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../custom_widgets/custom_product_bottom_sheet.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/global_instances.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/quickViewBottomSheet.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../wishlist/logic.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class ProductGridViewByCategory extends StatefulWidget {
  final dynamic settings;

  ProductGridViewByCategory({Key? key, required this.settings})
      : super(key: key);

  @override
  State<ProductGridViewByCategory> createState() => _ProductGridViewByCategoryState();
}

class _ProductGridViewByCategoryState extends State<ProductGridViewByCategory> {
  ///------ variables
  final appConfig = AppConfig.to;
  final homeLogic = HomeLogic.to;



  double calculateAspectRatio(String size, String viewType, bool isTitleHidden,
      bool showAddToCartButton, bool isPriceHidden) {
    if (size == 'normal') {
      if (viewType == 'small') {
        // Small size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.75; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.70; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.65; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.64; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.64; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.8; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.8; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 1.1; //----- when only image
        }
      } else if (viewType == 'medium') {
        // Medium size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.7; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.6; //------- when image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.6; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.6; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.6; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.7; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.7; //------ when only title and image
        } else if (isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.8; //----- when only image
        }
      } else if (viewType == 'large') {
        // Large size calculations
        if (isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.7; //----- when image + button
        } else if (!isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.6; //------- when only image + title + price + button
        } else if (!isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.65; //----- when image + title + price
        } else if (isTitleHidden && showAddToCartButton && !isPriceHidden) {
          return 0.65; //------ when image + price +  button
        } else if (!isTitleHidden && showAddToCartButton && isPriceHidden) {
          return 0.65; //---- when image + title + button
        } else if (isTitleHidden && !showAddToCartButton && !isPriceHidden) {
          return 0.75; //----- when only price and image
        } else if (!isTitleHidden && !showAddToCartButton && isPriceHidden) {
          return 0.75; //------ when only title and image
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
          return 0.70; //------- when only image + title + price + button
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
          return 0.50; //------- when only image + title + price + button
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getProducts(isChangingCategory: false);
  }

  @override
  Widget build(BuildContext context) {
    ///----- Get the initial Products
    // getProducts();

    return Obx(() {
      return
        appConfig.innerLoader.value == true
            ? ShimerProductGridPage()
            :
        Padding(
          padding: widget.settings["margin"]
              ? EdgeInsets.only(
              // top: pageMarginVertical/1.5,
              bottom: pageMarginVertical / 1.5,
              right: pageMarginHorizontal/1.5,
              left: pageMarginHorizontal/1.5)
              : EdgeInsets.zero,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.settings['isTitleHidden'] == false? (pageMarginVertical/1.5).heightBox:const SizedBox(),
              widget.settings['isTitleHidden'] == false?  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(child: Text(widget.settings['title'], textAlign: widget.settings['titleAlignment'] == 'left'? TextAlign.start: widget.settings['titleAlignment'] == 'center'? TextAlign.center:TextAlign.end,  style: widget.settings['titleSize'] == "small" ? context.text
                      .titleSmall : widget.settings['titleSize'] == "medium" ? context
                      .text.titleMedium : context.text.titleLarge)),
                  // Text('View All',
                  //     style: context.text.bodySmall
                  // ),

                ],
              ) : const SizedBox(),
              widget.settings['isTitleHidden'] == false? (pageMarginVertical * 1.1).heightBox:0.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                      widget.settings["metadata"]["data"].length, (index) {
                    final indexData = widget.settings["metadata"]["data"][index];

                    ProductInfo? productInfo = appConfig.getProductById(
                      // "gid://shopify/Product/${indexData["id"]}"
                      id: indexData["id"],
                      dataType: widget.settings["metadata"]['dataType'],
                    );

                    return Padding(
                      padding: EdgeInsets.only(right: pageMarginHorizontal),
                      child: InkWell(
                        onTap: () {
                          homeLogic.selectedCollectionIndex.value = index;
                          homeLogic.getProducts();
                          // getProducts(isChangingCategory: true);
                        },
                        child: Container(
                        // child: AnimatedContainer(
                        //   duration: const Duration(milliseconds: 500),
                          // width: 200.w,
                          padding: EdgeInsets.only(
                            left: pageMarginHorizontal + 3.w,
                            right: pageMarginHorizontal + 3.w,
                            top: 15.h,
                            bottom: 13.h
                          ),
                          decoration: BoxDecoration(
                              color: homeLogic.selectedCollectionIndex.value == index
                                  ? widget.settings['backgroundColor'].toString().toColor()
                                  : Colors.transparent,
                              border: Border.all(color: homeLogic.selectedCollectionIndex.value == index
                                  ? widget.settings['backgroundColor'].toString().toColor():Colors.black)),
                          child: Text(
                            productInfo!.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.bodyMedium?.copyWith(
                              color: homeLogic.selectedCollectionIndex.value == index
                                  ? widget.settings['textColor'].toString().toColor()
                                  : Colors.black,
                              height: 0.001,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              (pageMarginVertical * 1.3).heightBox,
              homeLogic.isLoading.isTrue
                  ? ShimerProductGridPage()
                  : gridviewBuilder()
            ],
          ),
        );
    });
  }



  gridviewBuilder() {
    return
      widget.settings["viewType"] == "small"
          ? GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeLogic.productsByTagsList.value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: calculateAspectRatio(
              widget.settings["displayType"],
              widget.settings["viewType"],
              widget.settings["hideContentTitle"],
              widget.settings["showAddToCart"],
              widget.settings["hideContentPrice"],
            ),
            crossAxisSpacing: widget.settings["contentMargin"] ? 16.w : 1.w,
            mainAxisSpacing: widget.settings["contentMargin"] ? 16.h:0.h,
          ),
          itemBuilder: (context, index) {
            return widgetBuilder(context, index);
          })
          :
      widget.settings["viewType"] == "medium"
          ? GridView.builder(
          shrinkWrap: true,
          // padding: EdgeInsets.symmetric(
          //   horizontal: settings["margin"]
          //       ? pageMarginHorizontal * 1
          //       : pageMarginHorizontal - 10.w,
          //       // : pageMarginHorizontal - 10.w,
          // ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeLogic.productsByTagsList.value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: calculateAspectRatio(
              widget.settings["displayType"],
              widget.settings["viewType"],
              widget.settings["hideContentTitle"],
              widget.settings["showAddToCart"],
              widget.settings["hideContentPrice"],
            ),
            crossAxisSpacing: widget.settings["contentMargin"] ? 16.w : 1.w,
            mainAxisSpacing: widget.settings["contentMargin"] ? 16.h:0.h,
          ),
          itemBuilder: (context, index) {
            return widgetBuilder(context, index);
          })
          :
      GridView.builder(
          shrinkWrap: true,
          // padding: EdgeInsets.symmetric(
          //   horizontal: settings["margin"]
          //       ? pageMarginHorizontal * 1.5
          //       : pageMarginHorizontal - 10.w,
          // ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeLogic.productsByTagsList.value.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: calculateAspectRatio(
              widget.settings["displayType"],
              widget.settings["viewType"],
              widget.settings["hideContentTitle"],
              widget.settings["showAddToCart"],
              widget.settings["hideContentPrice"],
            ),
            crossAxisSpacing: widget.settings["contentMargin"] ? 16.w : 1.w,
            mainAxisSpacing: widget.settings["contentMargin"] ? 16.h:0.h,
          ),
          itemBuilder: (context, index) {
            return widgetBuilder(context, index);
          });
  }

  widgetBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.settings['disableInteraction'] == false) {
          HomeLogic.to.productDetailNavigator(
              context: context,
              info: ProductInfo(
                  id: homeLogic.productsByTagsList.value[index].id,
                  title: "",
                  price: 0.0,
                  compareAtPrice: 0.0,
                  availableForSale: true,
                  webUrl: "",
                  image: ""),
              dataType: "product");
        }
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: widget.settings["hideBorders"]
                    ? null
                    : Border.all(color: AppColors.appBordersColor, width: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.r),
                  topRight: Radius.circular(3.r),
                  bottomLeft: widget.settings["showAddToCart"] ? Radius.circular(0.r): Radius.circular(3.r),
                  bottomRight: widget.settings["showAddToCart"] ? Radius.circular(0.r): Radius.circular(3.r),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.r),
                  topRight: Radius.circular(3.r),
                  bottomLeft: widget.settings["showAddToCart"] ? Radius.circular(0.r): Radius.circular(3.r),
                  bottomRight: widget.settings["showAddToCart"] ? Radius.circular(0.r): Radius.circular(3.r),
                ),
                child: homeLogic.productsByTagsList.value[index].image.isNotEmpty? FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: homeLogic.productsByTagsList.value[index].image,
                  fit: widget.settings['imageFill'] == true ? BoxFit.cover:BoxFit.contain,
                  height: double.infinity,
                  width: double.infinity,
                  imageErrorBuilder: (context, url,
                      error) => Container(
                    color: Colors.grey.shade200,
                    // color: Colors.grey.shade200,
                    child: Center(
                      child: SvgPicture.asset(Assets.icons.noImageIcon,
                        height: 25.h,
                      ),
                    ),
                  ),
                  // progressIndicatorBuilder:
                  //     (context, url, downloadProgress) =>
                  //     productShimmer(),
                  // errorWidget: (context, url, error) => const Icon(Icons.error),
                ):Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: SvgPicture.asset(Assets.icons.noImageIcon,
                      height: 25.h,
                    ),
                  ),
                ),
              ),
            ),
          ),
          widget.settings["viewType"] != "small" ?
          widget.settings["showAddToCart"]? homeLogic.productsByTagsList.value[index].availableForSale?  Obx(() {

            return GestureDetector(
              onTap: () {

                HapticFeedback.lightImpact();
                ProductSheet.to.productDetailBottomSheet(context: context, product: homeLogic.productsByTagsList.value[index]);
                // settingModalBottomSheet(context, productsList.value[index]);
              },
              child: Container(
                height: 28.h,
                decoration: BoxDecoration(
                  color: AppConfig.to.quickViewBGColor.value,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3.r),
                    bottomRight: Radius.circular(3.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppConfig.to.quickViewBGColor.value,
                      blurRadius: 0,
                      offset: Offset(0, -1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.add,
                        color: AppConfig.to.quickViewTextColor.value,
                        size: 12.sp,
                      ),

                      2.widthBox,

                      Text("Quick Add ",
                        style: context.text.bodySmall?.copyWith(
                          color: AppConfig.to.quickViewTextColor.value,
                        ),
                      )
                    ],
                  ),
                ),

              ),
            );
          }): Container(
            height: 28.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5.r),
                bottomRight: Radius.circular(5.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SOLD OUT",
                  style: context.text.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          )
        : const SizedBox.shrink():const SizedBox.shrink(),

          !widget.settings["hideContentPrice"]? 8.heightBox:0.heightBox,

          !widget.settings["hideContentPrice"]
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              Expanded(
                child:
                Row(
                  children: [
                    Text(
                      homeLogic.productsByTagsList.value[index].price == 0 ? "FREE" : CurrencyController.to.getConvertedPrice(
                          priceAmount: homeLogic.productsByTagsList.value[index].price
                      ),
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: context.text.bodyMedium?.copyWith(
                          color: homeLogic.productsByTagsList.value[index].compareAtPrice != 0 ?AppColors.appPriceRedColor:AppColors.appTextColor,
                          letterSpacing: .01,
                          height: .5
                      ),
                    ),
                    6.widthBox,
                    homeLogic.productsByTagsList.value[index].compareAtPrice != 0? Text(
                      CurrencyController.to.getConvertedPrice(
                          priceAmount: homeLogic.productsByTagsList.value[index].compareAtPrice,
                          includeSign: false
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style: context.text.bodySmall?.copyWith(
                          color: AppColors.appHintColor,
                          fontSize: 10.sp,
                          height: .5,
                          decoration: TextDecoration.lineThrough
                      ),
                    ):SizedBox.shrink()
                  ],
                ),
              ),

              3.widthBox,

              widget.settings["viewType"] == "large" ?  Obx(() {
                bool isProductInWishlist = WishlistLogic.to
                    .checkIfExistsInBookmark(
                    id: homeLogic.productsByTagsList.value[index].id) != -1;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    WishlistLogic.to.addOrRemoveBookmark(
                        context: context,
                        product: homeLogic.productsByTagsList.value[index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 4.w
                    ),
                    child:  Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        isProductInWishlist
                            ? Assets.icons.heartFilled
                            : Assets.icons.heartOutlined,
                        height: 20.h,
                        color: isProductInWishlist ? Colors.red : Colors
                            .black,
                      ),
                    ),
                  ),
                );
              }) : const SizedBox(),
            ],
          ): const SizedBox.shrink(),



          !widget.settings["hideContentTitle"]
              ?
          Column(
            children: [
              8.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        homeLogic.productsByTagsList.value[index].title,
                        maxLines: widget.settings["hideContentPrice"]
                            ? 2:1,
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

                  widget.settings["hideContentPrice"]
                      ?  Obx(() {
                    bool isProductInWishlist = WishlistLogic.to
                        .checkIfExistsInBookmark(
                        id: homeLogic.productsByTagsList.value[index].id) != -1;
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        WishlistLogic.to.addOrRemoveBookmark(
                            context: context,
                            product: homeLogic.productsByTagsList.value[index]);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 4.w
                        ),
                        child: widget.settings["viewType"] != 'small'? Align(
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            isProductInWishlist
                                ? Assets.icons.heartFilled
                                : Assets.icons.heartOutlined,
                            height: 20.h,
                            color: isProductInWishlist ? Colors.red : Colors
                                .black,
                          ),
                        ) : const SizedBox(),
                      ),
                    );
                  }) : const SizedBox(),
                ],
              ),
              8.heightBox
            ],
          )
              : const SizedBox.shrink(),

        ],
      ),
    );
  }
}