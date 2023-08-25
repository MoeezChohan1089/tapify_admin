import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/auth/logic.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../home/logic.dart';
import '../logic.dart';
import 'order_note_sheet.dart';

class CartBottomPriceSheet extends StatelessWidget {
  CartBottomPriceSheet({Key? key}) : super(key: key);

  final logicAuth = Get.put(AuthLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartLogic>(builder: (cartLogic) {
      return (cartLogic.currentCart != null &&
              cartLogic.currentCart!.lineItems.isNotEmpty)
          ? InkWell(
              onTap: () {},
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            left: pageMarginHorizontal,
                            right: pageMarginHorizontal,
                            bottom: pageMarginVertical / 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.appBordersColor.withOpacity(0.4),
                              offset: const Offset(0,
                                  -3), // Negative offset to position the shadow on top
                              blurRadius: 7,
                              spreadRadius: 0,
                            ),
                            const BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(0, 0),
                              blurRadius: 0,
                              spreadRadius: 0,
                            ),
                            const BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(0, 0),
                              blurRadius: 0,
                              spreadRadius: 0,
                            ),
                            const BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(0, 0),
                              blurRadius: 0,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppConfig.to.appSettingsCartAndCheckout[
                                        "checkoutNotes"] ==
                                    true
                                ? GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      showOrderNoteSheet(context: context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          // horizontal: pageMarginHorizontal,
                                          vertical: pageMarginVertical / 2.5),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: AppColors.appBordersColor,
                                            width: .5,
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Add an order note"),
                                          Icon(
                                            Icons.keyboard_arrow_up_rounded,
                                            color: AppColors.appTextColor,
                                            size: 24.sp,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),

                            ///--- Applied Gift Cards
                            cartLogic.currentCart!.appliedGiftCards.isEmpty
                                ? const SizedBox.shrink()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Gift Cards",
                                              style: context.text.bodyMedium,
                                            ),
                                            10.widthBox,
                                            Expanded(
                                                child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(
                                                    cartLogic
                                                        .currentCart!
                                                        .appliedGiftCards
                                                        .length, (index) {
                                                  return Padding(
                                                      padding: EdgeInsets.only(
                                                        right: 8.w,
                                                      ),
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 7.w,
                                                                  left: 7.w,
                                                                  bottom: 6.h,
                                                                  top: 9.h),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .textFieldBGColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.discount,
                                                                color: AppColors
                                                                    .appTextColor,
                                                                size: 16.sp,
                                                              ),
                                                              4.widthBox,
                                                              Text(
                                                                "....${cartLogic.currentCart!.appliedGiftCards[index].last4Digits.toString().toUpperCase()}",
                                                                style: context
                                                                    .text
                                                                    .bodySmall
                                                                    ?.copyWith(
                                                                        height:
                                                                            0.5,
                                                                        color: AppColors
                                                                            .appTextColor),
                                                              ),
                                                              6.widthBox,
                                                              GestureDetector(
                                                                onTap: () {
                                                                  cartLogic.removeGiftCard(
                                                                      giftCardId: cartLogic
                                                                          .currentCart!
                                                                          .appliedGiftCards[
                                                                              index]
                                                                          .id);
                                                                  log("Remove the discount code");
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(2),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: AppColors
                                                                        .appTextColor,
                                                                    size: 14.sp,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )));
                                                }),
                                              ),
                                            )),
                                            10.widthBox,
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "-\$${cartLogic.totalGiftCardAmountApplied}",
                                        style: context.text.bodyMedium,
                                      ),
                                    ],
                                  ),
                            4.heightBox,

                            ///---- Discount Codes
                            cartLogic.totalDiscountApplied == 0
                                ? const SizedBox.shrink()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text(
                                              "Discount",
                                              style: context.text.bodyMedium,
                                            ),
                                            10.widthBox,
                                            Expanded(
                                                child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(
                                                    cartLogic.discountCodesAdded
                                                        .length, (index) {
                                                  return Padding(
                                                      padding: EdgeInsets.only(
                                                        right: 8.w,
                                                      ),
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 7.w,
                                                                  left: 7.w,
                                                                  bottom: 6.h,
                                                                  top: 9.h),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .textFieldBGColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.r),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.discount,
                                                                color: AppColors
                                                                    .appTextColor,
                                                                size: 16.sp,
                                                              ),
                                                              4.widthBox,
                                                              Text(
                                                                  (cartLogic.discountCodesAdded[
                                                                              index] ==
                                                                          HomeLogic
                                                                              .to
                                                                              .widgetShopifyCode
                                                                              .value)
                                                                      ? HomeLogic
                                                                          .to
                                                                          .widgetCustomerCode
                                                                          .value
                                                                          .toString()
                                                                          .toUpperCase()
                                                                      : cartLogic
                                                                          .discountCodesAdded[
                                                                              index]
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                  style: context
                                                                      .text
                                                                      .bodySmall
                                                                      ?.copyWith(
                                                                          height:
                                                                              0.5,
                                                                          color:
                                                                              AppColors.appTextColor)),
                                                              6.widthBox,
                                                              GestureDetector(
                                                                onTap: () {
                                                                  HapticFeedback
                                                                      .lightImpact();
                                                                  cartLogic
                                                                      .removeDiscountCode(
                                                                          index);
                                                                  log("Remove the discount code");
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(2),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: AppColors
                                                                        .appTextColor,
                                                                    size: 14.sp,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )));
                                                }),
                                              ),
                                            )),
                                            10.widthBox,
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "-\$${cartLogic.totalDiscountApplied}",
                                        style: context.text.bodyMedium,
                                      ),
                                    ],
                                  ),
                            4.heightBox,

                            ///------ Sub Total Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: context.text.bodyMedium,
                                ),
                                Row(
                                  children: [
                                    (cartLogic.totalDiscountApplied != 0 ||
                                            cartLogic
                                                    .totalGiftCardAmountApplied !=
                                                0)
                                        ? Text(
                                            CurrencyController.to.getConvertedPrice(
                                                priceAmount: ((cartLogic
                                                                .currentCart!
                                                                .totalPriceV2
                                                                .amount -
                                                            cartLogic
                                                                .getOutOfStockItemsAmount()) -
                                                        cartLogic
                                                            .totalGiftCardAmountApplied) +
                                                    cartLogic
                                                        .totalDiscountApplied +
                                                    cartLogic
                                                        .totalGiftCardAmountApplied),
                                            style: context.text.bodyMedium
                                                ?.copyWith(
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                          )
                                        : const SizedBox.shrink(),
                                    10.widthBox,
                                    Text(
                                      cartLogic.returnCartSubTotal(),
                                      style: context.text.bodyMedium,
                                    ),
                                  ],
                                )
                              ],
                            ),

                            10.heightBox,

                            Obx(() {
                              return GlobalElevatedButton(
                                text: "Checkout",
                                onPressed: () {
                                  cartLogic.checkoutToWeb();
                                },
                                isLoading: cartLogic.isProcessing.value,
                              );
                            }),
                          ],
                        )),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
