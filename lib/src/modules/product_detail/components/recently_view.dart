import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/recently_viewed/logic.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/custom_product_Card.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../recently_viewed/view.dart';
import '../logic.dart';

class RecentlyViewProduct extends StatefulWidget {

  RecentlyViewProduct({Key? key,}) : super(key: key);

  @override
  State<RecentlyViewProduct> createState() => _RecentlyViewProductState();
}

class _RecentlyViewProductState extends State<RecentlyViewProduct> {
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
    return GetBuilder<RecentlyViewedLogic>(
      assignId: true,
      builder: (logic) {
        return  logic.userRecentlyViewed.isNotEmpty && logic.userRecentlyViewed.length != 1? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recently Viewed',
                    style: context.text.bodyMedium?.copyWith(color: AppColors.appTextColor, fontSize: 16.sp),
                  ),
                  GestureDetector(
                    onTap: (){
                      HapticFeedback.lightImpact();
                      // print("value of ID in recommended====>${logic.userRecentlyViewed!.collectionList![0].id}");
                      // Get.to(() => CategoryProducts(collectionID: logic.product!.collectionList![0].id, categoryName: logic.product!.collectionList![0].title,));
                      Get.to(()=> RecentlyViewedPage(), opaque: false, transition: Transition.native);
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
                    logic.userRecentlyViewed.length > 8?8:logic.userRecentlyViewed.length,
                        (index) {
                      return ProductDetailLogic.to.product?.id == logic.userRecentlyViewed[index].id ? SizedBox(): Container(
                        height: 270.h,
                        width: context.deviceWidth/2.2,
                        // color: Colors.yellow,
                        margin: EdgeInsets.only(
                          right: pageMarginHorizontal,
                        ),
                        child: CustomProductCard(
                          product: logic.userRecentlyViewed[index],
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