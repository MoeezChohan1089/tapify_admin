import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/wishlist/logic.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../product_detail/view.dart';
import '../../product_detail/view_product_detail.dart';
import '../logic.dart';

class SuggestedProductsList extends StatefulWidget {
  const SuggestedProductsList({Key? key}) : super(key: key);
  @override
  State<SuggestedProductsList> createState() => _SuggestedProductsListState();
}

class _SuggestedProductsListState extends State<SuggestedProductsList> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishlistLogic>(
        builder: (suggestedProducts) {
          return suggestedProducts.suggestedProducts.value.isNotEmpty ?  Padding(
            padding: EdgeInsets.symmetric(
                horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Suggested Products", style: context.text.bodyMedium),
                8.heightBox,
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: List.generate(
                        suggestedProducts.suggestedProducts.value.length > 10 ? 10 : suggestedProducts.suggestedProducts.value.length, (index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Get.to(() =>
                              NewProductDetails(
                                  productId: suggestedProducts
                                      .suggestedProducts.value[index].id
                              ), opaque: false, transition: Transition.native);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: pageMarginVertical / 2),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3.r),
                                child: SizedBox(
                                    width: 52, height: 52,
                                    child:
                                    ExtendedImage.network(
                                      "${suggestedProducts.suggestedProducts.value[index]
                                          .images[0].originalSrc}?width=300",
                                      fit: BoxFit.cover,
                                      cache: true,
                                      loadStateChanged: (ExtendedImageState state) {
                                        switch (state.extendedImageLoadState) {
                                          case LoadState.loading:
                                            return Container(
                                              height: double.maxFinite,
                                              width: double.maxFinite,
                                              color: Colors.white,
                                            );
                                          case LoadState.completed:
                                            return null; //return null, so it continues to display the loaded image
                                          case LoadState.failed:
                                            return Container(
                                                color: Colors.grey.shade200,
                                                child: Center(
                                                  child: SvgPicture.asset(
                                                    Assets.icons.noImageIcon,
                                                    height: 15.h,
                                                  ),
                                                ));
                                          default:
                                            return null;
                                        }
                                      },
                                    )



                                  // CachedNetworkImage(
                                  //   imageUrl: suggestedProducts.suggestedProducts.value[index].images
                                  //           .isNotEmpty
                                  //       ?
                                  //   // suggestedProducts.suggestedProducts.value[index]
                                  //   //     .images[0].originalSrc
                                  //
                                  //   "${suggestedProducts.suggestedProducts.value[index]
                                  //       .images[0].originalSrc}?width=300"
                                  //
                                  //       : "",
                                  //   fit: BoxFit.cover,
                                  //   progressIndicatorBuilder:
                                  //       (context, url, downloadProgress) =>
                                  //       productShimmer(),
                                  //   errorWidget: (context, url, error) =>
                                  //   const Icon(Icons.error),
                                  // ),
                                ),
                              ),
                              14.widthBox,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: double.maxFinite,
                                        child: Text(
                                          suggestedProducts.suggestedProducts.value[index]
                                              .title,
                                          style: context.text.bodySmall!
                                              .copyWith(
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.appTextColor),)),
                                    2.heightBox,
                                    Row(
                                      children: [
                                        Text(CurrencyController.to
                                            .getConvertedPrice(
                                            priceAmount: suggestedProducts
                                                .suggestedProducts.value[index]
                                                .price ?? 0
                                        ), style: context.text.bodyMedium!
                                            .copyWith(fontSize: 14.sp,
                                            color: suggestedProducts.suggestedProducts.value[index]
                                                .compareAtPrice != 0 ? AppColors
                                                .appPriceRedColor : AppColors
                                                .appTextColor),),
                                        6.widthBox,
                                        suggestedProducts.suggestedProducts.value[index]
                                            .compareAtPrice != 0 ? Text(
                                            CurrencyController.to
                                                .getConvertedPrice(
                                                priceAmount: suggestedProducts
                                                    .suggestedProducts.value[index]
                                                    .compareAtPrice ?? 0,
                                                includeSign: false
                                            ), style: context.text.bodyMedium
                                            ?.copyWith(
                                            color: AppColors.appHintColor,
                                            decoration: TextDecoration
                                                .lineThrough,
                                            fontSize: 10.sp
                                        )) : const SizedBox(),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ) : const SizedBox();
        }) ;
  }
}