import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

class ReviewList extends StatelessWidget {
  ReviewList({Key? key}) : super(key: key);

  final logic = ProductDetailLogic.to;

  customReviewSection(
      context, String title, double reviewPoint, String Description) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        width: 300.w,
        height: 121.h,
        margin: EdgeInsets.only(right: pageMarginHorizontal / 1.5),
        padding: EdgeInsets.only(
            left: pageMarginHorizontal,
            right: pageMarginHorizontal,
            top: pageMarginVertical / 1.5),
        // padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            border: Border.all(color: AppColors.appHintColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.text.bodyMedium,
            ),
            // 2.heightBox,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$reviewPoint',
                  style: context.text.labelSmall
                      ?.copyWith(fontSize: 13.sp, height: 2.1),
                ),
                4.widthBox,
                RatingBar.builder(
                  ignoreGestures: true,
                  itemSize: 18.sp,
                  initialRating: reviewPoint,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                  ),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // setState(() {
                    //   // _rating = rating;
                    // });
                  },
                ),
              ],
            ),
            5.heightBox,
            Text(
              Description,
              maxLines: 3,
              style: context.text.bodySmall!.copyWith(
                  // fontSize: 13.sp,
                  overflow: TextOverflow.ellipsis,
                  height: 1.1),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return (logic.productReviews.value['reviews_list'] == null ||
          logic.productReviews.value['reviews_list'].isEmpty)
          ? const SizedBox.shrink()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: pageMarginHorizontal,
                vertical: pageMarginVertical),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviews',
                  style: context.text.bodyMedium?.copyWith(
                      color: AppColors.appTextColor, fontSize: 16.sp),
                ),
                // if (logic.productReviews.value.isNotEmpty)
                //   GestureDetector(
                //     onTap: () {
                //       HapticFeedback.lightImpact();
                //     },
                //     child: Text(
                //       'View All',
                //       style: context.text.bodyMedium?.copyWith(
                //           color: AppColors.appTextColor, fontSize: 12.sp),
                //     ),
                //   ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: pageMarginHorizontal),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                    logic.productReviews.value["reviews_list"].length,
                        (index) {
                      return customReviewSection(
                        context,
                        logic.productReviews.value["reviews_list"][index]
                        ["reviewer"]["name"],
                        double.parse(logic.productReviews.value['avg_rating']
                            .toStringAsFixed(1)),
                        // 5.0,
                        logic.productReviews.value["reviews_list"][index]["body"],
                        // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                      );
                    })),
          ),
        ],
      );
    });
  }
}