import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/modules/cart/logic.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../custom_widgets/custom_snackbar.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/database_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../cart/view.dart';

class DiscountWidget extends StatelessWidget {
  final dynamic settings;
  DiscountWidget({Key? key, required this.settings}) : super(key: key);

  final appConfig = AppConfig.to;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (settings['isTitleHidden'] == false)
            ? Column(
              children: [
                SizedBox(
          width: double.maxFinite,
          child: Padding(
                padding: EdgeInsets.only(
                  left: pageMarginHorizontal / 1.3,
                  right: pageMarginHorizontal / 1.3,
                  bottom: 10.h,
                  top: 7.h,
                ),
                child: Text('${settings['title']}',
                    textAlign: settings["titleAlignment"] == "left"
                        ? TextAlign.left
                        : settings["titleAlignment"] == "right"
                        ? TextAlign.right
                        : TextAlign.center,
                    style: settings['titleSize'] == "small"
                        ? context.text.titleSmall
                        : settings['titleSize'] == "medium"
                        ? context.text.titleMedium
                        : context.text.titleLarge),
          ),
        ),
                (pageMarginVertical / 2).heightBox,
              ],
            )
            : const SizedBox(),
        GestureDetector(
          onTap: () async {
            ///----- Apply Discount Code Here
            if (settings['disableInteraction'] == false &&
                settings['shopifyCodes'] != null) {
              HapticFeedback.lightImpact();

              if (CartLogic.to.currentCart == null) {
                LocalDatabase.to.box.write("tappedOnDiscount", true);
                showToastMessage(message: "Discount added, start shopping now");
              } else if (CartLogic.to.currentCart!.lineItems.isNotEmpty) {
                CartLogic.to.applyDiscount(settings['shopifyCodes']);
                await Future.delayed(const Duration(milliseconds: 250));
                Get.to(() => CartPage(),
                    transition: Transition.downToUp,
                    fullscreenDialog: true,
                    duration: const Duration(milliseconds: 250));
              } else {
                LocalDatabase.to.box.write("tappedOnDiscount", true);
                showToastMessage(message: "Discount added, start shopping now");
              }
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: settings['margin'] == true
                        ? pageMarginHorizontal / 1.7
                        : 0),
                child: Container(
                  width: double.maxFinite,
                  height: settings["displayType"] == "normal"
                      ? 200.h
                      : settings["displayType"] == "vertical"
                      ? 330.h
                      : settings["displayType"] == "auto"
                      ? null
                      : 165.h,
                  decoration: const BoxDecoration(
                    // border: Border.all(color: AppColors.customIconColor),
                  ),
                  child: IntrinsicHeight(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FadeInImage.memoryNetwork(
                          image: settings['image'],
                          fit: BoxFit.cover,
                          height: settings["displayType"] == "auto"
                              ? null
                              : double.infinity,
                          width: double.infinity,
                          // colorBlendMode: BlendMode.darken,
                          imageErrorBuilder: (context, url, error) => Container(
                            color: Colors.grey.shade200,
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.icons.noImageIcon,
                                height: 25.h,
                              ),
                            ),
                          ),
                          placeholder: kTransparentImage,
                          // errorWidget: (context, url, error) =>
                          // const Icon(Icons.error),
                        ),
                        if (settings['titlePosition'] == "center")
                          Container(
                            height: settings["displayType"] == "normal"
                                ? 200.h
                                : settings["displayType"] == "vertical"
                                ? 330.h
                                : settings["displayType"] == "auto"
                                ? null
                                : 165.h,
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            decoration: BoxDecoration(
                              color: settings['titlePosition'] == 'center'
                                  ? Colors.black.withOpacity(0.6)
                                  : null,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Assets.icons.discountIcon,
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                  10.heightBox,
                                  Text(
                                    settings['actionText'] ??
                                        "Apply Discount Code",
                                    textAlign: TextAlign.center,
                                    style: context.text.bodyMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (settings['titlePosition'] == "bottom")
                (pageMarginVertical / 1.5).heightBox,

              ///----- Tile

              if (settings['titlePosition'] == "bottom")
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.discount,
                      //   color: AppColors.customGreyPriceColor,
                      //   size: 22.sp,
                      // ),
                      // 6.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.icons.discountIcon,
                            height: 30,
                            color: Colors.black,
                          ),
                          10.heightBox,
                          Text(
                            settings['actionText'] ?? "Apply Discount Code",
                            textAlign: TextAlign.center,
                            style: context.text.bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              if (settings['margin'] == true)
                (pageMarginVertical / 2).heightBox,
            ],
          ),
        ),
      ],
    );
  }
}