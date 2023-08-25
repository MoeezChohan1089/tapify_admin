import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/modules/cart/logic.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../api_services/shopify_flutter/models/models.dart';
import '../../custom_widgets/customPopupDialogue.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_product_card.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../global_controllers/currency_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../../utils/home_widgets_stylings.dart';
import '../../utils/quickViewBottomSheet.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import '../cart/components/discountCodeDialogue.dart';
import '../cart/view.dart';
import '../product_detail/view.dart';
import 'logic.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({Key? key}) : super(key: key);

  final logic = Get.put(WishlistLogic());
  final state = Get
      .find<WishlistLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'wishlist',
        showBack: false,
        showMenuIcon: true,
      ),
      body:  GetBuilder<WishlistLogic>(
          builder: (logic) {
            return logic.userWishlist.isNotEmpty ? GridView(
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

                children: List.generate(logic.userWishlist.length, (index) {

                  return CustomProductCard(
                    product: logic.userWishlist[index],
                  );

                }),

                // itemBuilder: (context, index) {
                //   return CustomProductCard(
                //     product: logic.userWishlist[index],
                //   );
                // }
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
                  Text(
                    "Your wishlist is empty!",
                    style: context.text.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.appTextColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  8.heightBox,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 60.w
                    ),
                    child: Text("Discover, curate, and bring your desires to life.",
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