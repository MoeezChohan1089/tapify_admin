import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../logic.dart';

void showDiscountAndGiftCardSheet(
    {required BuildContext context, required bool isDiscountSheet}) {
  // TextEditingController _controller = new TextEditingController();

  final cartLogic = CartLogic.to;

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
              color: Colors.white,
              // decoration: BoxDecoration(
              //     color: Colors.grey.shade100),
              child: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      18.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.appTextColor,
                              size: 25.sp,
                            ),
                          ),
                          Text(
                            isDiscountSheet
                                ? "APPLY DISCOUNT"
                                : "APPLY GIFT CARD",
                            style: context.text.bodyLarge,
                          ),
                          30.widthBox
                        ],
                      ),

                      20.heightBox,

                      ///------ Image from Settings
                      isDiscountSheet
                          ? AppConfig.to.customizationDiscountCodePopUp[
                                      "image"] !=
                                  null
                              ? Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.r),
                                      child: SizedBox(
                                        height: 100.h,
                                        width: 200.w,
                                        child: CachedNetworkImage(
                                          imageUrl: AppConfig.to
                                                  .customizationDiscountCodePopUp[
                                              "image"],
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                          width: double.infinity,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CachedBackgroundImagePage(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    20.heightBox,
                                  ],
                                )
                              : const SizedBox.shrink()
                          : AppConfig.to.customizationCardGiftPopUp["image"] !=
                                  null
                              ? Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.r),
                                      child: SizedBox(
                                        height: 100.h,
                                        width: 200.w,
                                        child: CachedNetworkImage(
                                          imageUrl: AppConfig.to
                                                  .customizationCardGiftPopUp[
                                              "image"],
                                          fit: BoxFit.cover,
                                          height: double.infinity,
                                          width: double.infinity,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CachedBackgroundImagePage(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    20.heightBox,
                                  ],
                                )
                              : const SizedBox.shrink(),

                      ///------ Text Message from Settings
                      isDiscountSheet
                          ? AppConfig.to.customizationDiscountCodePopUp[
                                      "cardGiftMessage"] !=
                                  null
                              ? Column(
                                  children: [
                                    Text(
                                        "${AppConfig.to.customizationDiscountCodePopUp["cardGiftMessage"]}"),
                                    20.heightBox,
                                  ],
                                )
                              : const SizedBox.shrink()
                          : AppConfig.to.customizationCardGiftPopUp[
                                      "cardGiftMessage"] !=
                                  null
                              ? Column(
                                  children: [
                                    Text(
                                        "${AppConfig.to.customizationCardGiftPopUp["cardGiftMessage"]}"),
                                    20.heightBox,
                                  ],
                                )
                              : const SizedBox.shrink(),

                      CustomTextField(
                        controller: isDiscountSheet
                            ? cartLogic.discountCodeTextController
                            : cartLogic.giftCardTextController,
                        hint: isDiscountSheet
                            ? "Enter Discount Code"
                            : "Enter Gift Card",
                        fieldVerticalPadding: 8,
                        autoFocus: true,
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(
                              right: 15.w, top: 12.h, bottom: 12.h),
                          child: Image.asset(Assets.icons.discountTagIcon),
                        ),
                      ),

                      15.heightBox,

                      Obx(() {
                        return GlobalElevatedButton(
                          text: "apply",
                          onPressed: () {
                            // Navigator.of(context).pop();
                            HapticFeedback.lightImpact();

                            if (isDiscountSheet) {
                              if (cartLogic.discountCodeTextController.text
                                  .toString()
                                  .replaceAll(" ", "")
                                  .isNotEmpty) {
                                cartLogic.isProcessing.value = true;
                                cartLogic.applyDiscountCode();
                                Navigator.pop(context);
                              } else {
                                showToastMessage(
                                    message:
                                        "Please enter valid discount code");
                              }
                            } else {
                              if (cartLogic.giftCardTextController.text
                                  .toString()
                                  .replaceAll(" ", "")
                                  .isNotEmpty) {
                                cartLogic.isProcessing.value = true;
                                cartLogic.applyGiftCard();
                                Navigator.pop(context);
                              } else {
                                showToastMessage(
                                    message: "Please enter valid Gift Card");
                              }
                            }
                          },
                          isLoading: cartLogic.isProcessing.value,
                        );
                      }),

                      20.heightBox,
                    ],
                  ),
                ),
              )),
            ),
          ),
        );
      });
}
