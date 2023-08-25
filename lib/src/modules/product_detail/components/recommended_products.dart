import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tapify/src/modules/cart/components/discountCodeDialogue.dart';
import 'package:tapify/src/modules/product_detail/logic.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../custom_widgets/customPopupDialogue.dart';
import '../../../custom_widgets/custom_product_Card.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/quickViewBottomSheet.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../cart/logic.dart';
import '../../category/logic.dart';
import '../../category/view_category_products.dart';
import '../../wishlist/logic.dart';
import '../view.dart';

class RecommendedProducts extends StatefulWidget {

  RecommendedProducts({Key? key,}) : super(key: key);

  @override
  State<RecommendedProducts> createState() => _RecommendedProductsState();
}

class _RecommendedProductsState extends State<RecommendedProducts> {
  final logic = Get.put(ProductDetailLogic());

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   logic.productFetchService(
    //       context: context, id: widget.collectionID, isNewId: true);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailLogic>(
      assignId: true,
      builder: (logic) {
        return  logic.recommendedProducts.value.isNotEmpty? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended',
                    style: context.text.bodyMedium?.copyWith(color: AppColors.appTextColor, fontSize: 16.sp),
                  ),
                  GestureDetector(
                    onTap: (){
                      HapticFeedback.lightImpact();
                      print("value of ID in recommended====>${logic.product!.collectionList![0].id}");
                      Get.to(() => CategoryProducts(collectionID: logic.product!.collectionList![0].id, categoryName: logic.product!.collectionList![0].title,));
                    },
                    child: Text(
                      'View All',
                      style: context.text.bodyMedium?.copyWith(color: AppColors.appTextColor, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
            12.heightBox,
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                    logic.recommendedProducts.value.length,
                        (index) {
                      return logic.product?.id == logic.recommendedProducts.value[index].id? SizedBox():Container(
                        height: 270.h,
                        width: context.deviceWidth/2.2,
                        // color: Colors.yellow,
                        margin: EdgeInsets.only(
                          right: pageMarginHorizontal,
                        ),
                        child: CustomProductCard(
                          product: logic.recommendedProducts.value[index],
                        ),
                      );

                      //   GestureDetector(
                      //   onTap: (){
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 ProductDetailPage(
                      //                   productId: logic.recommendedProducts.value[index].id,
                      //                 )));
                      //   },
                      //   child: Container(
                      //     height: 300.h,
                      //     width: context.deviceWidth/2,
                      //     // color: Colors.yellow,
                      //     margin: EdgeInsets.only(
                      //       right: pageMarginHorizontal,
                      //     ),
                      //     child: Stack(
                      //       children: [
                      //         Column(
                      //           children: [
                      //             Expanded(
                      //               // height: double.infinity,
                      //               // width: double.infinity,
                      //               child: CachedNetworkImage(
                      //                 imageUrl: logic.recommendedProducts.value[index].images
                      //                     .isNotEmpty
                      //                     ? logic.recommendedProducts.value[index].images[0]
                      //                     .originalSrc
                      //                     : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                      //                 fit: BoxFit.cover,
                      //                 placeholder: (context, url) =>
                      //                     productShimmer(),
                      //                 errorWidget: (context, url,
                      //                     error) => const Icon(Icons.error),
                      //               ),
                      //             ),
                      //             3.heightBox,
                      //             Text(
                      //               '${logic.recommendedProducts.value[index].title}',
                      //               maxLines: 1,
                      //               overflow: TextOverflow.ellipsis,
                      //               style: context.text.bodyLarge,
                      //             ),
                      //             3.heightBox,
                      //             Text(
                      //               CurrencyController.to.getConvertedPrice(
                      //                   priceAmount: logic.recommendedProducts.value[index].price
                      //               ),
                      //               style: context.text.bodyMedium,
                      //             ),
                      //             4.heightBox,
                      //             AppQuickViewButton(
                      //               onPress: (){
                      //                 // Vibration.vibrate(duration: 100);
                      //
                      //                 HapticFeedback.lightImpact();
                      //                 // CartLogic.to.addToCart(context: context, lineItem:
                      //                 // LineItem(
                      //                 //     title: valueLoader.productsFetch[index].title ?? "",
                      //                 //     quantity: 1,
                      //                 //     // id: product?.id ?? "",
                      //                 //     variantId: valueLoader.productsFetch[index].productVariants[0].id ?? "",
                      //                 //     discountAllocations: []
                      //                 // )
                      //                 // );
                      //                 print("call ID of product on recommended: ${logic.recommendedProducts.value[index].id}");
                      //                 settingModalBottomSheet(context, logic.recommendedProducts.value[index]);
                      //               },
                      //             ),
                      //             // GestureDetector(
                      //             //   onTap: (){
                      //             //     Vibration.vibrate(duration: 100);
                      //             //     CartLogic.to.addToCart(context: context, lineItem:
                      //             //     LineItem(
                      //             //         title: logic.productData.value[index].title ?? "",
                      //             //         quantity: 1,
                      //             //         // id: product?.id ?? "",
                      //             //         variantId: logic.productData.value[index].productVariants[0].id ?? "",
                      //             //         discountAllocations: []
                      //             //     )
                      //             //     );
                      //             //
                      //             //   },
                      //             //   child: Container(
                      //             //     width: double.infinity,
                      //             //     padding: EdgeInsets.symmetric(
                      //             //         vertical: pageMarginVertical / 3),
                      //             //     decoration: BoxDecoration(
                      //             //         border: Border.all(
                      //             //           color: Colors.black,
                      //             //         )),
                      //             //     child: Text(
                      //             //       'Add to Cart',
                      //             //       textAlign: TextAlign.center,
                      //             //       style: context.text.bodySmall,
                      //             //     ),
                      //             //   ),
                      //             // ),
                      //           ],
                      //         ),
                      //         Positioned(
                      //           right: 10,
                      //           top: 5,
                      //           child: Obx(() {
                      //             bool isProductInWishlist = WishlistLogic.to
                      //                 .checkIfExistsInBookmark(
                      //                 id: logic.recommendedProducts.value[index].id) != -1;
                      //             return GestureDetector(
                      //               onTap: () {
                      //                 // Vibration.vibrate(duration: 100);
                      //                 HapticFeedback.lightImpact();
                      //                 WishlistLogic.to.addOrRemoveBookmark(
                      //                     context: context,
                      //                     product: logic.recommendedProducts.value[index]);
                      //               },
                      //               child: SvgPicture.asset(
                      //                 isProductInWishlist ? Assets.icons
                      //                     .heartFilled : Assets.icons
                      //                     .heartOutlined,
                      //                 color: isProductInWishlist
                      //                     ? Colors.red
                      //                     : Colors.black,
                      //               ),
                      //             );
                      //           }),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // );
                    }),
              ),
            ),
          ],
        ):const SizedBox();
      },
    );
  }
}