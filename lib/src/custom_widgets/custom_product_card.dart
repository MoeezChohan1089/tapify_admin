import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/modules/product_detail/view.dart';
import 'package:tapify/src/utils/constants/assets.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:tapify/src/utils/skeleton_loaders/shimmerLoader.dart';
import 'package:transparent_image/transparent_image.dart';

import '../api_services/shopify_flutter/models/models.dart';
import '../global_controllers/app_config/config_controller.dart';
import '../global_controllers/currency_controller.dart';
import '../modules/product_detail/view_product_detail.dart';
import '../modules/wishlist/logic.dart';
import '../utils/quickViewBottomSheet.dart';
import 'custom_product_bottom_sheet.dart';

class CustomProductCard extends StatelessWidget {
  final Product product;

  CustomProductCard({super.key, required this.product});

  final bool showQuickAdd =
  AppConfig.to.appSettingsStoreSettings["quickAddInProduct"];

  @override
  Widget build(BuildContext context) {
    // print("link => ${product.image}");

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();

        // logic.isRouteOk.value = true;
        print("id value of product=====${product.id}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewProductDetails(
                  productId: product.id,
                )));
        // Get.to(() => ProductDetailPage(
        //   productId: product.id,
        // ));
      },
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [


          ///------ Second Try
          // Expanded(
          //   child: SizedBox(
          //     width: double.maxFinite,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: [
          //         Expanded(
          //           child: Container(
          //             width: double.maxFinite,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(5.r),
          //                 topRight: Radius.circular(5.r),
          //                 bottomRight: showQuickAdd
          //                     ? const Radius.circular(0)
          //                     : Radius.circular(5.r),
          //                 bottomLeft: showQuickAdd
          //                     ? const Radius.circular(0)
          //                     : Radius.circular(5.r),
          //               ),
          //             ),
          //                   child: product.images.isNotEmpty ? FadeInImage.memoryNetwork(
          //                     placeholder: kTransparentImage,
          //                     imageErrorBuilder: (context, url,
          //                           error) => Container(
          //                       color: Colors.black,
          //                       // color: Colors.grey.shade200,
          //                       child: Center(
          //                         child: SvgPicture.asset(Assets.icons.noImageIcon,
          //                           height: 25.h,
          //                         ),
          //                       ),
          //                     ),
          //                     fit: BoxFit.cover,
          //                     image:
          //                     // product.images.isNotEmpty
          //                     //     ?
          //                     "${product.image.split("?v=")[0]}?width=300}"
          //                     //     :
          //                     // "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
          //                   ) : Container(
          //                     color: Colors.grey.shade200,
          //                     child: Center(
          //                       child: SvgPicture.asset(Assets.icons.noImageIcon,
          //                         height: 25.h,
          //                       ),
          //                     ),
          //                   ),
          //           ),
          //         ),
          //         if (showQuickAdd)
          //           Align(
          //             alignment: Alignment.topRight,
          //             child: product.availableForSale
          //                 ? GestureDetector(
          //               onTap: () {
          //                 HapticFeedback.lightImpact();
          //                 ProductSheet.to.productDetailBottomSheet(
          //                   context: context,
          //                   product: product,
          //                 );
          //               },
          //               child: Container(
          //                 height: 28.h,
          //                 decoration: BoxDecoration(
          //                   color: AppConfig.to.quickViewBGColor.value,
          //                   borderRadius: BorderRadius.only(
          //                     bottomLeft: Radius.circular(5.r),
          //                     bottomRight: Radius.circular(5.r),
          //                   ),
          //                 ),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Icon(
          //                       Icons.add,
          //                       color: AppConfig.to.quickViewTextColor.value,
          //                       size: 12.sp,
          //                     ),
          //                     2.widthBox,
          //                     Text(
          //                       "Quick Add  ",
          //                       style: context.text.bodySmall?.copyWith(
          //                         color: AppConfig.to.quickViewTextColor.value,
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             )
          //                 : Container(
          //               height: 28.h,
          //               decoration: BoxDecoration(
          //                 color: Colors.grey,
          //                 borderRadius: BorderRadius.only(
          //                   bottomLeft: Radius.circular(5.r),
          //                   bottomRight: Radius.circular(5.r),
          //                 ),
          //               ),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                     "SOLD OUT",
          //                     style: context.text.bodySmall?.copyWith(
          //                       color: Colors.white,
          //                     ),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
          // ),



          ///----- Old One
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.r),
                  topRight: Radius.circular(5.r),
                  bottomRight: showQuickAdd
                      ? const Radius.circular(0)
                      : Radius.circular(5.r),
                  bottomLeft: showQuickAdd
                      ? const Radius.circular(0)
                      : Radius.circular(5.r),
                ),

                child: product.images.isNotEmpty ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
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
                    fit: BoxFit.cover,
                    image:
                    // product.images.isNotEmpty
                    //     ?
                    "${product.image.split("?v=")[0]}?width=300 "
                  //     :
                  // "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                ) : Container(
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
          showQuickAdd
              ? product.availableForSale
              ? Obx(() {
            return GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                ProductSheet.to.productDetailBottomSheet(context: context, product: product);
                // settingModalBottomSheet(context, product);
              },
              child: Container(
                height: 26.5.h,
                decoration: BoxDecoration(
                  color: AppConfig.to.quickViewBGColor.value,
                  boxShadow: [
                    BoxShadow(
                      color: AppConfig.to.quickViewBGColor.value,
                      blurRadius: 0,
                      offset: const Offset(1, 0),
                    ),
                  ],
                  // border: Border(
                  //   top: BorderSide(
                  //     color: AppConfig.to.quickViewBGColor.value, // Specify the color of the border
                  //     // width: 2.0,         // Specify the width of the border
                  //   ),
                  // ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.r),
                    bottomRight: Radius.circular(5.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppConfig.to.quickViewTextColor.value,
                      size: 12.sp,
                    ),
                    2.widthBox,
                    Text(
                      "Quick Add  ",
                      style: context.text.bodySmall?.copyWith(
                        color: AppConfig.to.quickViewTextColor.value,
                      ),
                    )
                  ],
                ),
              ),
            );
          })
              : Container(
            height: 26.5.h,
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
              : const SizedBox.shrink(),



          8.heightBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.vendor.capitalize!,
                          style: context.text.bodySmall?.copyWith(
                            color: AppColors.appHintColor,
                            fontSize: 10.sp,
                            height: .5,
                          ),
                        ),
                        10.heightBox,
                        Row(
                          children: [
                            Text(
                              product.price == 0 ? "FREE" : CurrencyController.to.getConvertedPrice(
                                  priceAmount: product.price),
                              maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: context.text.bodyMedium?.copyWith(
                                  color: product.compareAtPrice != 0
                                      ? AppColors.appPriceRedColor
                                      : AppColors.appTextColor,
                                  letterSpacing: .01,
                                  height: .5),
                            ),
                            product.compareAtPrice != 0
                                ? Row(
                              children: [
                                4.widthBox,
                                Text(
                                  CurrencyController.to.getConvertedPrice(
                                      priceAmount: product.compareAtPrice,
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
                        6.heightBox,
                      ],
                    ),
                  ),
                  3.widthBox,
                  Obx(() {
                    bool isProductInWishlist = WishlistLogic.to
                        .checkIfExistsInBookmark(id: product.id) !=
                        -1;
                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        WishlistLogic.to.addOrRemoveBookmark(
                            context: context, product: product);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: SvgPicture.asset(
                          isProductInWishlist
                              ? Assets.icons.heartFilled
                              : Assets.icons.heartOutlined,
                          height: 20.h,
                          color:
                          isProductInWishlist ? Colors.red : Colors.black,
                        ),
                      ),
                    );
                  }),
                ],
              ),
              1.heightBox,
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodySmall?.copyWith(
                  height: 1.0,
                  color: AppColors.appTextColor,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}