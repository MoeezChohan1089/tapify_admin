import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../global_controllers/currency_controller.dart';
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
  final logic = Get.find<SearchLogic>();

  @override
  Widget build(BuildContext context) {
    return logic.searchedProducts.isNotEmpty? Padding(
      padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Suggested Products", style: context.text.bodyMedium),
          8.heightBox,
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: List.generate(logic.searchedProducts.length, (index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewProductDetails(
                                    productId: logic
                                        .searchedProducts[index].id
                                )));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: pageMarginVertical/2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 52, height: 52,
                          child:
                          CachedNetworkImage(
                            imageUrl: logic.searchedProducts[index].images != null &&
                                logic.searchedProducts[index].images.isNotEmpty
                                ? "${logic.searchedProducts[index].images[0].originalSrc}"
                                : "",
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                productShimmer(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),


                          // Image.network("https://www.cottonheritage.com/catImg/WAMHIRES/MC10863Full.jpg", fit: BoxFit.cover),
                        ),
                        14.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: double.maxFinite,
                                  child: Text("${logic.searchedProducts[index].title}", style: context.text.bodySmall!.copyWith(overflow: TextOverflow.ellipsis, color: AppColors.appTextColor),)),
                              2.heightBox,
                              Row(
                                children: [
                                  Text(CurrencyController.to.getConvertedPrice(
                                      priceAmount: logic.searchedProducts[index].price ?? 0
                                  ), style: context.text.bodyMedium!.copyWith(fontSize: 14.sp, color: logic.searchedProducts[index].compareAtPrice != 0? AppColors.appPriceRedColor: AppColors.appTextColor),),
                                  6.widthBox,
                                  logic.searchedProducts[index].compareAtPrice != 0? Text(CurrencyController.to.getConvertedPrice(
                                      priceAmount: logic.searchedProducts[index].compareAtPrice ?? 0,
                                    includeSign: false
                                  ), style: context.text.bodyMedium?.copyWith(
                                      color: AppColors.appHintColor,
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10.sp
                                  )):const SizedBox(),
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
    ):SizedBox();
  }
}