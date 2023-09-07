// import 'dart:developer';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:tapify_admin/src/global_controllers/app_config/config_controller.dart';
// import 'package:tapify_admin/src/modules/product_detail/components/product_photo_gallery.dart';
// import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
// import 'package:tapify_admin/src/utils/extensions.dart';
//
// import '../../../custom_widgets/custom_snackbar.dart';
// import '../../../utils/constants/assets.dart';
// import '../../../utils/constants/colors.dart';
// import '../../../utils/skeleton_loaders/shimmerLoader.dart';
// import '../logic.dart';
//
// class ProductImagesCarousel extends StatelessWidget {
//   ProductImagesCarousel({Key? key}) : super(key: key);
//
//   final logic = Get.find<ProductDetailLogic>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return logic.productDetailLoader.value == true
//           ? ShimerCarosalSliderPage()
//           : SizedBox(
//               height: context.deviceHeight / 1.8,
//               child: Wrap(
//                 children: [
//                   Stack(
//                     children: [
//                       (logic.product == null || logic.product!.images.isNotEmpty)
//                           ? GestureDetector(
//                         onTap: () => Get.to(() => ProductPhotoGallery(product: ,)),
//                         child: CarouselSlider(
//                                 items: List.generate(
//                                     logic.product?.images.length ?? 0, (index) {
//                                   return CachedNetworkImage(
//                                     imageUrl: logic.product!.images.isNotEmpty
//                                         ? '${logic.product?.images[index].originalSrc.split('?')[0]}?width=800'
//                                         : '',
//                                     fit: BoxFit.cover,
//                                     height: double.infinity,
//                                     width: double.infinity,
//                                     progressIndicatorBuilder:
//                                         (context, url, downloadProgress) =>
//                                             ShimerCarosalSliderPage(),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.error),
//                                   );
//                                 }),
//                                 carouselController: logic.carouselController,
//                                 options: CarouselOptions(
//                                     height: context.deviceHeight / 1.8,
//                                     viewportFraction: 1.0,
//                                     enlargeCenterPage: false,
//                                     enableInfiniteScroll: false,
//                                     reverse: false,
//                                     scrollDirection: Axis.horizontal,
//
//                                     onPageChanged: (index, _) {
//                                       logic.currentImageIndex.value = index;
//                                     }),
//                               ),
//                           )
//                           : Container(
//                         height: context.deviceHeight / 1.8,
//
//                         color: Colors.grey.shade200,
//                               child: Center(
//                                 child: SvgPicture.asset(
//                                   Assets.icons.noImageIcon,
//                                   height: 35.h,
//                                 ),
//                               ),
//                             ),
//                           Positioned(
//                           left: pageMarginHorizontal,
//                           top: pageMarginVertical * 1.5,
//                           child: Container(
//                             padding: EdgeInsets.only(
//                                 right: 10.w, left: 10.w, top: 4.h
//                                 // vertical: 4.h
//                                 ),
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                             ),
//                             child: Center(
//                               child: Text(
//                                   logic
//                                               .product
//                                               ?.productVariants[logic
//                                                   .selectedVariantIndex.value]
//                                               .availableForSale ==
//                                           true
//                                       ? "In Stock"
//                                       : "Out of Stock",
//                                   style: context.text.bodyMedium
//                                       ?.copyWith(color: Colors.black)),
//                             ),
//                           )),
//                       Positioned(
//                           right: pageMarginHorizontal * 1.2,
//                           bottom: pageMarginVertical * 1.2,
//                           child: GestureDetector(
//                             onTap: () async {
//
//                               log("link is ${logic.product!.onlineStoreUrl}");
//
//                               ///----- Share Functionality Will be Here
//                               await Share.share(
//                                   "${logic.product!.title}   \n\nPrice: ${logic.product!.formattedPrice}   \n\n${logic.product!.onlineStoreUrl}");
//                             },
//                             child: SvgPicture.asset(
//                               Assets.icons.shareIcon,
//                               // height: 20.h,
//                               // color: Colors.black,
//                               // size: 20.sp,
//                             ),
//                           )),
//                     ],
//                   ),
//                   logic.product?.images.length == 1
//                       ? 0.heightBox
//                       : 10.heightBox,
//                   logic.product?.images.length != 1
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                               logic.product?.images.length ?? 0,
//                               (index) => Obx(() {
//                                     return Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 10),
//                                           child: AnimatedContainer(
//                                             duration: const Duration(
//                                                 milliseconds: 250),
//                                             height: 7.h,
//                                             width:
//                                                 logic.currentImageIndex.value ==
//                                                         index
//                                                     ? 25.h
//                                                     : 7.h,
//                                             decoration: logic.currentImageIndex
//                                                         .value ==
//                                                     index
//                                                 ? BoxDecoration(
//                                                     color: AppConfig
//                                                         .to.primaryColor.value,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             50.r))
//                                                 : BoxDecoration(
//                                                     color: AppColors
//                                                         .appBordersColor,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             50.r)),
//                                           ),
//                                         ),
//                                         4.widthBox
//                                       ],
//                                     );
//                                   })),
//                         )
//                       : const SizedBox.shrink(),
//                 ],
//               ),
//             );
//     });
//   }
// }