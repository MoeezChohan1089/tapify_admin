import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../custom_widgets/custom_snackbar.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../logic.dart';

class QuantityControl extends StatelessWidget {
  QuantityControl({Key? key}) : super(key: key);


  final productLogic = ProductDetailLogic.to;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return
        productLogic.productDetailLoader.value == true
            ? ShimertitlePage()
            :
        productLogic.product?.productVariants[productLogic.selectedVariantIndex.value].availableForSale == false ?
        const SizedBox.shrink()

            :

        Column(
          children: [
            Divider(
              color: AppColors.appHintColor,
              thickness: .2,
              indent: pageMarginHorizontal,
              endIndent: pageMarginHorizontal,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: pageMarginVertical / 3,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantity',
                      style: context.text.bodyLarge,
                    ),
                    Row(
                      children: [
                        (productLogic.productDetailLoader.isTrue && productLogic
                            .product!.productVariants[productLogic
                            .selectedVariantIndex.value].availableForSale ==
                            true && (productLogic.product!
                            .productVariants[productLogic.selectedVariantIndex
                            .value].quantityAvailable > 0 && productLogic.product!
                            .productVariants[productLogic.selectedVariantIndex
                            .value].quantityAvailable < 10)) ?
                        Text("Only ${productLogic.product!
                            .productVariants[productLogic.selectedVariantIndex
                            .value].quantityAvailable} left",
                          style: context.text.bodyMedium?.copyWith(
                              color: AppColors.appHintColor
                          ),
                        ) : const SizedBox.shrink(),
                        20.widthBox,
                        Obx(() {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (productLogic.productQuantity.value > 1) {
                                    productLogic.productQuantity.value -= 1;
                                    HapticFeedback.lightImpact();
                                  }
                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.remove,
                                    color: AppColors.appHintColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: pageMarginHorizontal * 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: AppColors.textFieldBGColor
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      productLogic.productQuantity.value
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: context.text.bodyLarge,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  try {
                                    if (productLogic.product!
                                        .productVariants[productLogic
                                        .selectedVariantIndex.value]
                                        .availableForSale == true) {
                                      if (productLogic.product!
                                          .productVariants[productLogic
                                          .selectedVariantIndex.value]
                                          .quantityAvailable > 0) {
                                        if (productLogic.productQuantity.value <
                                            productLogic.product!
                                                .productVariants[productLogic
                                                .selectedVariantIndex.value]
                                                .quantityAvailable) {
                                          productLogic.productQuantity.value += 1;
                                          HapticFeedback.lightImpact();
                                        } else {
                                          showToastMessage(
                                              message: "Whoa! Currently ${productLogic
                                                  .product!
                                                  .productVariants[productLogic
                                                  .selectedVariantIndex.value]
                                                  .quantityAvailable} available.");
                                        }
                                      } else {
                                        productLogic.productQuantity.value += 1;
                                        HapticFeedback.lightImpact();
                                      }
                                    }
                                  } catch (e) {
                                    print("error in incrementing");
                                  }


                                  // else {
                                  //   print("available for sale is false");
                                  // }
                                  // productLogic.update();

                                },
                                borderRadius: BorderRadius.circular(100.r),
                                child: const SizedBox (
                                  height: 30,
                                  width: 30,
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.appHintColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: AppColors.appHintColor,
              thickness: .2,
              indent: pageMarginHorizontal,
              endIndent: pageMarginHorizontal,
            ),
          ],
        );
    });
  }
}