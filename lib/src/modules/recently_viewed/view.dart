import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_product_Card.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../wishlist/logic.dart';
import 'logic.dart';

class RecentlyViewedPage extends StatelessWidget {
  RecentlyViewedPage({Key? key}) : super(key: key);

  final logic = Get.put(RecentlyViewedLogic());
  final state = Get.find<RecentlyViewedLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'recently viewed',
      ),
      body:  GetBuilder<RecentlyViewedLogic>(
          builder: (logic) {
            return logic.userRecentlyViewed.isNotEmpty ? GridView(
              padding: EdgeInsets.only(
                top: pageMarginVertical,
                bottom: pageMarginVertical,
                right: pageMarginHorizontal,
                left: pageMarginHorizontal,
                // vertical: pageMarginVertical * 1.5,
              ),
              // physics: const NeverScrollableScrollPhysics(),
              // itemCount: logic.userWishlist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: AppConfig.to.customizationProductImage["chooseImage"] == "square" ?  0.80 : 0.55,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 15.h,
              ),
              children: List.generate(logic.userRecentlyViewed.length, (index) {
                return CustomProductCard(
                  product: logic.userRecentlyViewed[index],
                );

              }),
            )
                :



            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.images.emptyWishlistImage,
                    width: 100,
                  ),
                  30.heightBox,
                  Text("Your recent adventures await!",
                    style: context.text.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.appTextColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  8.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 70.w
                    ),
                    child: Text("Discover more, see more, and experience more.",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.appHintColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}