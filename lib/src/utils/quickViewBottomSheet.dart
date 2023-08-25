import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:tapify/src/utils/skeleton_loaders/shimmerLoader.dart';
import 'package:vibration/vibration.dart';

import '../api_services/shopify_flutter/models/models.dart';
import '../api_services/shopify_flutter/models/src/product/product_variant/product_variant.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../custom_widgets/custom_snackbar.dart';
import '../global_controllers/currency_controller.dart';
import '../modules/auth/components/custom_button.dart';
import '../modules/cart/components/product_added_to_cart_sheet.dart';
import '../modules/cart/logic.dart';
import '../modules/product_detail/logic.dart';
import '../modules/product_detail/view.dart';
import 'constants/colors.dart';

// final logic = Get.find<ProductDetailLogic>();
// // final logic1 = Get.put(ProductDetailLogic());
//
//
// void settingModalBottomSheet(context, Product product, ) {
//   final logic = Get.put(ProductDetailLogic());
//
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     logic.getProductDetailAPICall(
//         context: context, productId: product.id, isCartProductId: false);
//   });
//
//   final bool buttonText = AppConfig.to.appSettingsCartAndCheckout["navigationCustomers"];
//
//
//
//
//
//   showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       elevation: 0.0,
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         print("value of bottom sheet ID: ${product.id}====");
//         return Obx(() {
//           print("value of logic product price=====${logic.product?.price}");
//           return Wrap(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(5),
//                         topRight: Radius.circular(5))),
//                 child: SafeArea(
//                     child: Column(
//                       children: [
//
//                         5.heightBox,
//
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: pageMarginHorizontal,
//                               vertical: pageMarginVertical / 2),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 82.h,
//                                 height: 82.h,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.r),
//                                   child: CachedNetworkImage(
//                                     imageUrl: product.images.isNotEmpty
//                                         ? '${product.images[0].originalSrc
//                                         .split('?')[0]}?width=400'
//                                         : '',
//                                     fit: BoxFit.cover,
//                                     height: double.infinity,
//                                     width: double.infinity,
//                                     progressIndicatorBuilder:
//                                         (context, url, downloadProgress) =>
//                                         productShimmer(),
//                                     errorWidget: (context, url, error) =>
//                                     const Icon(Icons.error),
//                                   ),
//                                 ),
//                               ),
//                               10.widthBox,
//                               Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   Text(product.vendor.capitalize ?? "",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: context.text.bodySmall?.copyWith(
//                                         color: AppColors.appHintColor,
//                                         fontSize: 10.sp
//                                     ),
//                                   ),
//                                   4.heightBox,
//
//                                   SizedBox(
//                                     width: 200,
//                                     child: Text(product.title ?? "",
//                                       maxLines: 1,
//                                       // overflow: TextOverflow.ellipsis,
//                                       style: context.text.bodySmall?.copyWith(
//                                           color: AppColors.appTextColor,
//                                           // color: AppColors.appProductCardTitleColor,
//                                           fontSize: 13.sp
//                                       ),
//                                     ),
//                                   ),
//                                   2.heightBox,
//
//                                   Row(
//                                     children: [
//                                       Text(
//                                     logic.product?.productVariants[logic
//               .selectedVariantIndex.value].price.amount == 0? "FREE":  CurrencyController.to.getConvertedPrice(
//                                             priceAmount: logic.product?.productVariants[logic
//                                                 .selectedVariantIndex.value].price.amount ?? 0
//                                         ),
//                                         style: context.text.bodyMedium
//                                             ?.copyWith(
//                                             color: product.compareAtPrice != 0 ? AppColors.appPriceRedColor: AppColors.appTextColor
//                                         ),
//                                       ),
//                                       3.widthBox,
//                                      product.compareAtPrice != 0? Text(
//                                         CurrencyController.to.getConvertedPrice(
//                                             priceAmount: logic.product?.compareAtPrice ?? 0
//                                         ),
//                                         style: context.text.bodySmall?.copyWith(
//                                             color: AppColors.appHintColor,
//                                             fontSize: 10.sp,
//                                             decoration: TextDecoration
//                                                 .lineThrough
//                                         ),
//                                       ):const SizedBox(),
//                                     ],
//                                   ),
//
//                                   // Row(
//                                   //   children: [
//                                   //     Text(
//                                   //       CurrencyController.to.getConvertedPrice(
//                                   //           priceAmount: product.price ??
//                                   //               0
//                                   //       ),
//                                   //       style: context.text.titleMedium
//                                   //           ?.copyWith(color: AppColors
//                                   //           .customBlackTextColor,
//                                   //           fontSize: 12.sp,
//                                   //           fontWeight: FontWeight.w500),),
//                                   //     6.widthBox,
//                                   //     Text(
//                                   //       CurrencyController.to.getConvertedPrice(
//                                   //           priceAmount: product
//                                   //               .compareAtPrice ?? 0
//                                   //       ),
//                                   //       style: context.text.titleMedium
//                                   //           ?.copyWith(
//                                   //         color: AppColors.customBlackTextColor,
//                                   //         fontSize: 12.sp,
//                                   //         fontWeight: FontWeight.w500,
//                                   //         decoration: TextDecoration
//                                   //             .lineThrough,),),
//                                   //
//                                   //   ],
//                                   // ),
//
//
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.of(context).pop();
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ProductDetailPage(
//                                                     productId: product.id,
//                                                   )));
//                                     },
//                                     child: DecoratedBox(
//                                       decoration: BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             color: AppConfig.to.primaryColor
//                                                 .value,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Text("View Details",
//                                         style: context.text.bodyMedium
//                                             ?.copyWith(
//                                             color: AppConfig.to.primaryColor
//                                                 .value
//                                         ),),
//                                     ),
//                                   ),
//                                   // Text("View Details",
//                                   //   style: context.text.titleMedium?.copyWith(color: AppColors.customGreyTextColor, fontSize: 14.sp, decoration: TextDecoration.underline,decorationThickness: 2.0,),),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Divider(
//                           color: AppColors.appBordersColor,
//                           thickness: .5,
//                         ),
//                         GetBuilder<ProductDetailLogic>(builder: (logic) {
//                           return logic.listOfOptions.length != 0 ? logic
//                               .productDetailLoader.value == true
//                               ? ShimerSizeAndColorPage()
//                               : Column(
//                             children: [
//                               ...List.generate(
//                                   logic.listOfOptions.length,
//                                       (index) =>
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           left: pageMarginHorizontal,
//                                           right: pageMarginHorizontal,
//                                           bottom: pageMarginVertical,),
//                                         child: SizedBox(
//                                           width: double.maxFinite,
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               Text("${logic
//                                                   .listOfOptions[index]['name']}",
//                                                   style: context.text
//                                                       .bodyLarge),
//                                               6.heightBox,
//                                               Wrap(
//                                                 children: List.generate(
//                                                     logic
//                                                         .listOfOptions[index]['sub_options']
//                                                         .length,
//                                                         (index2) =>
//                                                         Padding(
//                                                             padding: EdgeInsets
//                                                                 .only(
//                                                                 right: 8.w,
//                                                                 top: 8.w
//                                                             ),
//                                                             child: InkWell(
//                                                               onTap: () {
//                                                                 logic
//                                                                     .updateSelectedVariant(
//                                                                     variantIndex: index,
//                                                                     innerOptionIndex: index2);
//                                                               },
//                                                               child: Container(
//                                                                   padding: EdgeInsets
//                                                                       .only(
//                                                                       right: 9
//                                                                           .w,
//                                                                       left: 9.w,
//                                                                       bottom: 11
//                                                                           .h,
//                                                                       top: 14
//                                                                           .h),
//                                                                   decoration: BoxDecoration(
//                                                                       color: const Color(
//                                                                           0xffF7F7F7),
//                                                                       border: Border
//                                                                           .all(
//                                                                           color: logic
//                                                                               .listOfOptions[index]
//                                                                           ['sub_options'][index2]
//                                                                           ['is_selected']
//                                                                               ? AppConfig
//                                                                               .to
//                                                                               .primaryColor
//                                                                               .value
//                                                                               : Colors
//                                                                               .transparent,
//                                                                           width: 1),
//                                                                       borderRadius: BorderRadius
//                                                                           .circular(
//                                                                           3.r)
//                                                                   ),
//                                                                   child:
//                                                                   Text(
//                                                                       logic
//                                                                           .listOfOptions[index]
//                                                                       ['sub_options'][index2]
//                                                                       ['name']
//                                                                           .toString()
//                                                                           .capitalize!,
//                                                                       style: context
//                                                                           .text
//                                                                           .bodyMedium
//                                                                           ?.copyWith(
//                                                                         height: 0.5,
//
//                                                                         color: logic
//                                                                             .listOfOptions[index]
//                                                                         ['sub_options'][index2]
//                                                                         ['is_selected']
//                                                                             ? AppConfig
//                                                                             .to
//                                                                             .primaryColor
//                                                                             .value
//                                                                             : AppColors
//                                                                             .appTextColor,
//                                                                       ))),
//                                                             ))),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )),
//                             ],
//                           ) : const SizedBox();
//                         }),
//
//                         5.heightBox,
//
//                         GlobalElevatedButton(
//                           text:
//
//                           logic.product?.productVariants[logic.selectedVariantIndex
//                               .value].availableForSale == true
//                               ?
//
//
//                           buttonText ? "buy now" : "add to cart"
//
//                           : "Out of Stock"
//                           ,
//                           onPressed: () async {
//
//                             ///---------- New
//                             if(logic.product!.productVariants[logic.selectedVariantIndex.value].availableForSale == true) {
//                               // if(logic.product!.productVariants[logic.selectedVariantIndex.value].quantityAvailable > 0) {
//                               //   if(logic.productQuantity.value < logic.product!.productVariants[logic.selectedVariantIndex.value].quantityAvailable) {
//                               //     HapticFeedback.lightImpact();
//                               //     logic.quickBottomSheet.value = 'quick';
//                               //     logic.isProcessing.value = true;
//                               //     await CartLogic.to.addToCart(
//                               //         context: context, lineItem:
//                               //     LineItem(
//                               //         title: logic.product!
//                               //             .productVariants[logic
//                               //             .selectedVariantIndex.value].title ?? "",
//                               //         quantity: 1,
//                               //         variantId: logic.product!
//                               //             .productVariants[logic
//                               //             .selectedVariantIndex.value].id ?? "",
//                               //         discountAllocations: []
//                               //     )
//                               //     );
//                               //     logic.isProcessing.value = false;
//                               //   } else {
//                               //     showToastMessage(message:
//                               //     "Whoa there! Maximum quantity reached. Try fewer items or save some for others! 😊"
//                               //     );
//                               //   }
//                               // } else {
//                                 HapticFeedback.lightImpact();
//                                 logic.quickBottomSheet.value = 'quick';
//                                 logic.isProcessing.value = true;
//                                 await CartLogic.to.addToCart(
//                                     context: context, lineItem:
//                                 LineItem(
//                                     title: logic.product!
//                                         .productVariants[logic
//                                         .selectedVariantIndex.value].title ?? "",
//                                     quantity: 1,
//                                     variantId: logic.product!
//                                         .productVariants[logic
//                                         .selectedVariantIndex.value].id ?? "",
//                                     discountAllocations: []
//                                 )
//                                 );
//                                 logic.isProcessing.value = false;
//                               // }
//                             }
//
//
//
//                             ///---------- Old
//                             // HapticFeedback.lightImpact();
//                             // logic.quickBottomSheet.value = 'quick';
//                             // logic.isProcessing.value = true;
//                             // await CartLogic.to.addToCart(
//                             //     context: context, lineItem:
//                             // LineItem(
//                             //     title: logic.product!
//                             //         .productVariants[logic
//                             //         .selectedVariantIndex.value].title ?? "",
//                             //     quantity: 1,
//                             //     variantId: logic.product!
//                             //         .productVariants[logic
//                             //         .selectedVariantIndex.value].id ?? "",
//                             //     discountAllocations: []
//                             // )
//                             // );
//                             // logic.isProcessing.value = false;
//                           },
//                           isLoading: logic.isProcessing.value,
//                           applyHorizontalPadding: true,
//                             isDisable:
//                             logic.product?.productVariants[logic.selectedVariantIndex
//                                 .value].availableForSale == true ? false : true
//                         ),
//
//                         20.heightBox,
//
//                         // Padding(
//                         //   padding: EdgeInsets.symmetric(
//                         //       horizontal: pageMarginHorizontal),
//                         //   child: AuthBlackButton(
//                         //     buttonTitle: "Add to cart",
//                         //     onPressed: () {
//                         //       Navigator.of(context).pop();
//                         //       CartLogic.to.addToCart(context: context, lineItem:
//                         //       LineItem(
//                         //           title: logic.product!.title ?? "",
//                         //           quantity: 1,
//                         //           // id: product?.id ?? "",
//                         //           variantId: logic.product!
//                         //               .productVariants[logic
//                         //               .selectedVariantIndex.value].id ?? "",
//                         //           discountAllocations: []
//                         //       )
//                         //       );
//                         //       // Navigator.push(
//                         //       //     context,
//                         //       //     MaterialPageRoute(
//                         //       //         builder: (context) => HomePage()));
//                         //
//                         //     },
//                         //   ),
//                         // ),
//                       ],
//                     )
//                 ),
//               ),
//             ],
//           );
//         });
//       });
// }
//
// void settingModalBottomSheet1(context, String productID) {
//   final logic = Get.put(ProductDetailLogic());
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     logic.getProductDetailAPICall(
//         context: context, productId: productID, isCartProductId: false);
//   });
//
//   final bool buttonText = AppConfig.to.appSettingsCartAndCheckout["navigationCustomers"];
//
//   showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       elevation: 0.0,
//       isScrollControlled: true,
//       context: context,
//
//       builder: (BuildContext context) {
//         print("value of bottom sheet ID: ${productID}====");
//         return Obx(() {
//           return Wrap(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(
//                         5), topRight: Radius.circular(5))),
//                 child: SafeArea(
//                     child: Column(
//                       children: [
//
//                         5.heightBox,
//
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: pageMarginHorizontal,
//                               vertical: pageMarginVertical / 2),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 82.h,
//                                 height: 82.h,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.r),
//                                   child: CachedNetworkImage(
//                                     imageUrl: logic.product?.images.isNotEmpty ?? false
//                                         ? '${logic.product!.images[0]
//                                         .originalSrc
//                                         .split('?')[0]}?width=400'
//                                         : '',
//                                     fit: BoxFit.cover,
//                                     height: double.infinity,
//                                     width: double.infinity,
//                                     progressIndicatorBuilder:
//                                         (context, url, downloadProgress) =>
//                                         productShimmer(),
//                                     errorWidget: (context, url, error) =>
//                                     const Icon(Icons.error),
//                                   ),
//                                 ),
//                               ),
//                               10.widthBox,
//                               Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   Text(logic.product?.vendor.capitalize ?? "",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: context.text.bodySmall?.copyWith(
//                                         color: AppColors.appHintColor,
//                                         fontSize: 10.sp
//                                     ),
//                                   ),
//                                   4.heightBox,
//
//                                   SizedBox(
//                                     width: 200,
//                                     child: Text(logic.product?.title ?? "",
//                                       maxLines: 1,
//                                       // overflow: TextOverflow.ellipsis,
//                                       style: context.text.bodySmall?.copyWith(
//                                           color: AppColors.appTextColor,
//                                           // color: AppColors.appProductCardTitleColor,
//                                           fontSize: 13.sp
//                                       ),
//                                     ),
//                                   ),
//                                   2.heightBox,
//
//                                   Row(
//                                     children: [
//                                       Text(
//           logic.product?.price == 0?"FREE":  CurrencyController.to
//                                             .getConvertedPrice(
//                                             priceAmount: logic.product?.price ?? 0
//                                         ),
//                                         style: context.text.bodyMedium
//                                             ?.copyWith(
//                                             color: logic.product?.compareAtPrice != 0 ? AppColors.appPriceRedColor:AppColors.appTextColor
//                                         ),
//                                       ),
//                                       3.widthBox,
//                                       logic.product?.compareAtPrice != 0 ? Text(
//                                         CurrencyController.to
//                                             .getConvertedPrice(
//                                             priceAmount: logic.product?.compareAtPrice ?? 0
//                                         ),
//                                         style: context.text.bodySmall
//                                             ?.copyWith(
//                                             color: AppColors.appHintColor,
//                                             fontSize: 10.sp,
//                                             decoration: TextDecoration
//                                                 .lineThrough
//                                         ),
//                                       ):SizedBox(),
//                                     ],
//                                   ),
//
//                                   // Row(
//                                   //   children: [
//                                   //     Text(
//                                   //       CurrencyController.to.getConvertedPrice(
//                                   //           priceAmount: product.price ??
//                                   //               0
//                                   //       ),
//                                   //       style: context.text.titleMedium
//                                   //           ?.copyWith(color: AppColors
//                                   //           .customBlackTextColor,
//                                   //           fontSize: 12.sp,
//                                   //           fontWeight: FontWeight.w500),),
//                                   //     6.widthBox,
//                                   //     Text(
//                                   //       CurrencyController.to.getConvertedPrice(
//                                   //           priceAmount: product
//                                   //               .compareAtPrice ?? 0
//                                   //       ),
//                                   //       style: context.text.titleMedium
//                                   //           ?.copyWith(
//                                   //         color: AppColors.customBlackTextColor,
//                                   //         fontSize: 12.sp,
//                                   //         fontWeight: FontWeight.w500,
//                                   //         decoration: TextDecoration
//                                   //             .lineThrough,),),
//                                   //
//                                   //   ],
//                                   // ),
//
//
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.of(context).pop();
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ProductDetailPage(
//                                                     productId: productID,
//                                                   )));
//                                     },
//                                     child: DecoratedBox(
//                                       decoration: BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             color: AppConfig.to.primaryColor
//                                                 .value,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Text("View Details",
//                                         style: context.text.bodyMedium
//                                             ?.copyWith(
//                                             color: AppConfig.to.primaryColor
//                                                 .value
//                                         ),),
//                                     ),
//                                   ),
//                                   // Text("View Details",
//                                   //   style: context.text.titleMedium?.copyWith(color: AppColors.customGreyTextColor, fontSize: 14.sp, decoration: TextDecoration.underline,decorationThickness: 2.0,),),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Divider(
//                           color: AppColors.appBordersColor,
//                           thickness: .5,
//                         ),
//                         GetBuilder<ProductDetailLogic>(builder: (logic) {
//                           return logic.listOfOptions.length != 0 ? logic
//                               .productDetailLoader.value == true
//                               ? ShimerSizeAndColorPage()
//                               :  Column(
//                             children: [
//                               ...List.generate(
//                                   logic.listOfOptions.length,
//                                       (index) =>
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           left: pageMarginHorizontal,
//                                           right: pageMarginHorizontal,
//                                           bottom: pageMarginVertical,),
//                                         child: SizedBox(
//                                           width: double.maxFinite,
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               Text("${logic
//                                                   .listOfOptions[index]['name']}",
//                                                   style: context.text
//                                                       .bodyLarge),
//                                               6.heightBox,
//                                               Wrap(
//                                                 children: List.generate(
//                                                     logic
//                                                         .listOfOptions[index]['sub_options']
//                                                         .length,
//                                                         (index2) =>
//                                                         Padding(
//                                                             padding: EdgeInsets
//                                                                 .only(
//                                                                 right: 8.w,
//                                                                 top: 8.w
//                                                             ),
//                                                             child: InkWell(
//                                                               onTap: () {
//                                                                 logic
//                                                                     .updateSelectedVariant(
//                                                                     variantIndex: index,
//                                                                     innerOptionIndex: index2);
//                                                               },
//                                                               child: Container(
//                                                                   padding: EdgeInsets
//                                                                       .only(
//                                                                       right: 9
//                                                                           .w,
//                                                                       left: 9
//                                                                           .w,
//                                                                       bottom: 11
//                                                                           .h,
//                                                                       top: 14
//                                                                           .h),
//                                                                   decoration: BoxDecoration(
//                                                                       color: Color(
//                                                                           0xffF7F7F7),
//                                                                       border: Border
//                                                                           .all(
//                                                                           color: logic
//                                                                               .listOfOptions[index]
//                                                                           ['sub_options'][index2]
//                                                                           ['is_selected']
//                                                                               ? AppConfig
//                                                                               .to
//                                                                               .primaryColor
//                                                                               .value
//                                                                               : Colors
//                                                                               .transparent,
//                                                                           width: 1),
//                                                                       borderRadius: BorderRadius
//                                                                           .circular(
//                                                                           3.r)
//                                                                   ),
//                                                                   child:
//                                                                   Text(
//                                                                       logic
//                                                                           .listOfOptions[index]
//                                                                       ['sub_options'][index2]
//                                                                       ['name']
//                                                                           .toString()
//                                                                           .capitalize!,
//                                                                       style: context
//                                                                           .text
//                                                                           .bodyMedium
//                                                                           ?.copyWith(
//                                                                         height: 0.5,
//
//                                                                         color: logic
//                                                                             .listOfOptions[index]
//                                                                         ['sub_options'][index2]
//                                                                         ['is_selected']
//                                                                             ? AppConfig
//                                                                             .to
//                                                                             .primaryColor
//                                                                             .value
//                                                                             : AppColors
//                                                                             .appTextColor,
//                                                                       ))),
//                                                             ))),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )),
//                             ],
//                           ) : SizedBox();
//                         }),
//
//                         5.heightBox,
//
//                         GlobalElevatedButton(
//                           text: buttonText ? "buy now" : "add to cart",
//                           onPressed: () async {
//                             // Navigator.of(context).pop();
//
//                             logic.isProcessing.value = true;
//                             await CartLogic.to.addToCart(
//                                 context: context, lineItem:
//                             LineItem(
//                                 title: logic.product!.title ?? "",
//                                 quantity: 1,
//                                 variantId: logic.product!
//                                     .productVariants[logic
//                                     .selectedVariantIndex.value].id ?? "",
//                                 discountAllocations: []
//                             )
//                             );
//                             logic.isProcessing.value = false;
//                             Navigator.of(context).pop();
//
//                             // Show the second bottom sheet
//                             // productAddedToCart(context);
//                           },
//                           isLoading: logic.isProcessing.value,
//                           applyHorizontalPadding: true,
//                         ),
//
//                         20.heightBox,
//
//                         // Padding(
//                         //   padding: EdgeInsets.symmetric(
//                         //       horizontal: pageMarginHorizontal),
//                         //   child: AuthBlackButton(
//                         //     buttonTitle: "Add to cart",
//                         //     onPressed: () {
//                         //       Navigator.of(context).pop();
//                         //       CartLogic.to.addToCart(context: context, lineItem:
//                         //       LineItem(
//                         //           title: logic.product!.title ?? "",
//                         //           quantity: 1,
//                         //           // id: product?.id ?? "",
//                         //           variantId: logic.product!
//                         //               .productVariants[logic
//                         //               .selectedVariantIndex.value].id ?? "",
//                         //           discountAllocations: []
//                         //       )
//                         //       );
//                         //       // Navigator.push(
//                         //       //     context,
//                         //       //     MaterialPageRoute(
//                         //       //         builder: (context) => HomePage()));
//                         //
//                         //     },
//                         //   ),
//                         // ),
//                       ],
//                     )
//                 ),
//               ),
//             ],
//           );
//         });
//       });
// }
//
// void settingModalBottomSheet2(context, Product product, double checkoutPrice, int index) {
//   final logic = Get.put(ProductDetailLogic());
//
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     logic.getProductDetailAPICall(
//         context: context, productId: product.id, isCartProductId: false);
//   });
//
//
//   // RxInt selectedVariantIndex = 0.obs;
//
//   // int getVariantIndex() {
//   //   return product.productVariants.indexWhere((variant) => variant.title == variantVal);
//   // }
//   //
//   // RxInt selectedVariantIndex = getVariantIndex().obs;
//
//
//
//   showModalBottomSheet(
//       backgroundColor: Colors.transparent,
//       elevation: 0.0,
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return Obx(() {
//           return Wrap(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(topLeft: Radius.circular(5),
//                         topRight: Radius.circular(5))),
//                 child: SafeArea(
//                     child: Column(
//                       children: [
//
//                         5.heightBox,
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: pageMarginHorizontal,
//                               vertical: pageMarginVertical / 2),
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                 width: 82.h,
//                                 height: 82.h,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.r),
//                                   child: CachedNetworkImage(
//                                     imageUrl: product.images.isNotEmpty
//                                         ? '${product.images[0].originalSrc
//                                         .split('?')[0]}?width=400'
//                                         : '',
//                                     fit: BoxFit.cover,
//                                     height: double.infinity,
//                                     width: double.infinity,
//                                     progressIndicatorBuilder:
//                                         (context, url, downloadProgress) =>
//                                         productShimmer(),
//                                     errorWidget: (context, url, error) =>
//                                     const Icon(Icons.error),
//                                   ),
//                                 ),
//                               ),
//                               10.widthBox,
//                               Column(
//                                 crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.start,
//                                 children: [
//                                   Text(product.vendor.capitalize ?? "",
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: context.text.bodySmall?.copyWith(
//                                         color: AppColors.appHintColor,
//                                         fontSize: 10.sp
//                                     ),
//                                   ),
//                                   4.heightBox,
//
//                                   SizedBox(
//                                     width: 200,
//                                     child: Text(product.title ?? "",
//                                       maxLines: 1,
//                                       // overflow: TextOverflow.ellipsis,
//                                       style: context.text.bodySmall?.copyWith(
//                                           color: AppColors.appTextColor,
//                                           // color: AppColors.appProductCardTitleColor,
//                                           fontSize: 13.sp
//                                       ),
//                                     ),
//                                   ),
//                                   2.heightBox,
//
//                                   Row(
//                                     children: [
//                                       Text(
//                                     checkoutPrice == 0? "FREE":  CurrencyController.to.getConvertedPrice(
//                                             priceAmount: checkoutPrice
//                                         ),
//                                         style: context.text.bodyMedium
//                                             ?.copyWith(
//                                             color: product.compareAtPrice != 0? AppColors.appPriceRedColor:AppColors.appTextColor
//                                         ),
//                                       ),
//                                       3.widthBox,
//                                       product.compareAtPrice != 0? Text(
//                                         CurrencyController.to.getConvertedPrice(
//                                             priceAmount: product.compareAtPrice
//                                         ),
//                                         style: context.text.bodySmall?.copyWith(
//                                             color: AppColors.appHintColor,
//                                             fontSize: 10.sp,
//                                             decoration: TextDecoration
//                                                 .lineThrough
//                                         ),
//                                       ):SizedBox(),
//                                     ],
//                                   ),
//
//                                   // Row(
//                                   //   children: [
//                                   //     Text(
//                                   //       CurrencyController.to.getConvertedPrice(
//                                   //           priceAmount: product.price ??
//                                   //               0
//                                   //       ),
//                                   //       style: context.text.titleMedium
//                                   //           ?.copyWith(color: AppColors
//                                   //           .customBlackTextColor,
//                                   //           fontSize: 12.sp,
//                                   //           fontWeight: FontWeight.w500),),
//                                   //     6.widthBox,
//                                   //     Text(
//                                   //       CurrencyController.to.getConvertedPrice(
//                                   //           priceAmount: product
//                                   //               .compareAtPrice ?? 0
//                                   //       ),
//                                   //       style: context.text.titleMedium
//                                   //           ?.copyWith(
//                                   //         color: AppColors.customBlackTextColor,
//                                   //         fontSize: 12.sp,
//                                   //         fontWeight: FontWeight.w500,
//                                   //         decoration: TextDecoration
//                                   //             .lineThrough,),),
//                                   //
//                                   //   ],
//                                   // ),
//
//
//                                   GestureDetector(
//                                     onTap: () {
//                                       Navigator.of(context).pop();
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ProductDetailPage(
//                                                     productId: product.id,
//                                                   )));
//                                     },
//                                     child: DecoratedBox(
//                                       decoration: BoxDecoration(
//                                         border: Border(
//                                           bottom: BorderSide(
//                                             color: AppConfig.to.primaryColor
//                                                 .value,
//                                             width: 1.0,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Text("View Details",
//                                         style: context.text.bodyMedium
//                                             ?.copyWith(
//                                             color: AppConfig.to.primaryColor
//                                                 .value
//                                         ),),
//                                     ),
//                                   ),
//                                   // Text("View Details",
//                                   //   style: context.text.titleMedium?.copyWith(color: AppColors.customGreyTextColor, fontSize: 14.sp, decoration: TextDecoration.underline,decorationThickness: 2.0,),),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const Divider(
//                           color: AppColors.appBordersColor,
//                           thickness: .5,
//                         ),
//                         GetBuilder<ProductDetailLogic>(builder: (logic) {
//
//
//
//
//
//
//                           return logic.listOfOptions.length != 0 ? logic
//                               .productDetailLoader.value == true
//                               ? ShimerSizeAndColorPage()
//                               : Column(
//                             children: [
//                               ...List.generate(
//                                   logic.listOfOptions.length,
//                                       (index) =>
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           left: pageMarginHorizontal,
//                                           right: pageMarginHorizontal,
//                                           bottom: pageMarginVertical,),
//                                         child: SizedBox(
//                                           width: double.maxFinite,
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .start,
//                                             children: [
//                                               Text("${logic
//                                                   .listOfOptions[index]['name']}",
//                                                   style: context.text
//                                                       .bodyLarge),
//                                               6.heightBox,
//                                               Wrap(
//                                                 children: List.generate(
//                                                     logic
//                                                         .listOfOptions[index]['sub_options']
//                                                         .length,
//                                                         (index2) =>
//                                                         Padding(
//                                                             padding: EdgeInsets
//                                                                 .only(
//                                                                 right: 8.w,
//                                                                 top: 8.w
//                                                             ),
//                                                             child: InkWell(
//                                                               onTap: () {
//                                                                 logic
//                                                                     .updateSelectedVariant(
//                                                                     variantIndex: index,
//                                                                     innerOptionIndex: index2);
//                                                               },
//                                                               child: Container(
//                                                                   padding: EdgeInsets
//                                                                       .only(
//                                                                       right: 9
//                                                                           .w,
//                                                                       left: 9.w,
//                                                                       bottom: 11
//                                                                           .h,
//                                                                       top: 14
//                                                                           .h),
//                                                                   decoration: BoxDecoration(
//                                                                       color: const Color(
//                                                                           0xffF7F7F7),
//                                                                       border: Border
//                                                                           .all(
//                                                                           color: logic
//                                                                               .listOfOptions[index]
//                                                                           ['sub_options'][index2]
//                                                                           ['is_selected']
//                                                                               ? AppConfig
//                                                                               .to
//                                                                               .primaryColor
//                                                                               .value
//                                                                               : Colors
//                                                                               .transparent,
//                                                                           width: 1),
//                                                                       borderRadius: BorderRadius
//                                                                           .circular(
//                                                                           3.r)
//                                                                   ),
//                                                                   child:
//                                                                   Text(
//                                                                       logic
//                                                                           .listOfOptions[index]
//                                                                       ['sub_options'][index2]
//                                                                       ['name']
//                                                                           .toString()
//                                                                           .capitalize!,
//                                                                       style: context
//                                                                           .text
//                                                                           .bodyMedium
//                                                                           ?.copyWith(
//                                                                         height: 0.5,
//
//                                                                         color: logic
//                                                                             .listOfOptions[index]
//                                                                         ['sub_options'][index2]
//                                                                         ['is_selected']
//                                                                             ? AppConfig
//                                                                             .to
//                                                                             .primaryColor
//                                                                             .value
//                                                                             : AppColors
//                                                                             .appTextColor,
//                                                                       ))),
//                                                             ))),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       )),
//                             ],
//                           ) : const SizedBox();
//                         }),
//
//                         5.heightBox,
//
//                         GlobalElevatedButton(
//                           text: "add to cart",
//                           onPressed: () async {
//                             HapticFeedback.lightImpact();
//                             logic.quickBottomSheet.value = 'cart';
//                             logic.isProcessing.value = true;
//                             await CartLogic.to.addToCart1(
//                                 context: context, lineItem:
//                             LineItem(
//                                 title: logic.product!
//                                     .productVariants[logic
//                                     .selectedVariantIndex.value].title ?? "",
//                                 quantity: 1,
//                                 variantId: logic.product!
//                                     .productVariants[logic
//                                     .selectedVariantIndex.value].id ?? "",
//                                 discountAllocations: []
//                              )
//                             );
//                             logic.isProcessing.value = false;
//                           },
//                           isLoading: logic.isProcessing.value,
//                           applyHorizontalPadding: true,
//                         ),
//
//                         20.heightBox,
//                       ],
//                     )
//                 ),
//               ),
//             ],
//           );
//         });
//       });
// }