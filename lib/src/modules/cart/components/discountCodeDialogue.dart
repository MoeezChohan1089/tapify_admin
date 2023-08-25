import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/custom_snackbar.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/global_instances.dart';
import '../logic.dart';

final cartLogic = CartLogic.to;

alertShowDiscountDialogue({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: AppColors.customWhiteTextColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Set your desired border radius here
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.customWhiteTextColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.heightBox,
              Image.asset(
                'assets/images/discount.png',
                width: 100,
              ),
              8.heightBox,
              TextField(
                controller: cartLogic.discountCodeTextController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Enter discount code',
                  hintStyle: context.text.titleMedium?.copyWith(
                      fontSize: 14, color: AppColors.customGreyTextColor),
                  contentPadding: const EdgeInsets.only(top: 8.0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          Color(0xffF2F2F2), // Replace with your desired color
                      width: 1.0, // Set the width of the line
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors
                          .black, // Replace with your desired color for the active state
                      width: 1.0, // Set the width of the line
                    ),
                  ),
                ),
              ),
              24.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Vibration.vibrate(duration: 100);
                            HapticFeedback.lightImpact();
                            Navigator.pop(dialogContext);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                              elevation: 0, // Set the text color of the button
                              padding: const EdgeInsets.all(
                                  8), // Set the padding around the button content
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              side: const BorderSide(
                                width: 1.0,
                                color: Colors.black,
                              )),
                          child: Text(
                            "Cancel",
                            style: context.text.bodyMedium!
                                .copyWith(color: Colors.black, height: 1.1),
                          )),
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Vibration.vibrate(duration: 100);
                            HapticFeedback.lightImpact();

                            if (cartLogic.discountCodeTextController.text
                                .toString()
                                .replaceAll(" ", "")
                                .isNotEmpty) {
                              customLoaderWidget.showLoader(context);
                              cartLogic.applyDiscountCode();
                              Navigator.pop(context);
                            } else {
                              showToastMessage(
                                  message: "Please enter valid discount code");
                            }

                            // ProductDetailLogic.to.addProductToCart();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 0, // Set the text color of the button
                            padding: const EdgeInsets.all(
                                8), // Set the padding around the button content
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            "Apply",
                            style: context.text.bodyMedium!
                                .copyWith(color: Colors.white, height: 1.1),
                          )),
                    ),
                  ),
                ],
              ),
              10.heightBox,
            ],
          ),
        ),
      );
    },
  );
}

alertShowGiftDialogue({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: AppColors.customWhiteTextColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Set your desired border radius here
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.customWhiteTextColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.heightBox,
              Image.asset(
                'assets/images/gift.png',
                width: 100,
              ),
              8.heightBox,
              TextField(
                controller: cartLogic.giftCardTextController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Enter Gift Code',
                  hintStyle: context.text.titleMedium?.copyWith(
                      fontSize: 14, color: AppColors.customGreyTextColor),
                  contentPadding: const EdgeInsets.only(top: 8.0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          Color(0xffF2F2F2), // Replace with your desired color
                      width: 1.0, // Set the width of the line
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors
                          .black, // Replace with your desired color for the active state
                      width: 1.0, // Set the width of the line
                    ),
                  ),
                ),
              ),
              24.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Vibration.vibrate(duration: 100);
                            HapticFeedback.lightImpact();
                            Navigator.pop(dialogContext);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                              elevation: 0, // Set the text color of the button
                              padding: const EdgeInsets.all(
                                  8), // Set the padding around the button content
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              side: const BorderSide(
                                width: 1.0,
                                color: Colors.black,
                              )),
                          child: Text(
                            "Cancel",
                            style: context.text.bodyMedium!
                                .copyWith(color: Colors.black, height: 1.1),
                          )),
                    ),
                  ),
                  10.widthBox,
                  Expanded(
                    child: SizedBox(
                      height: 32,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Vibration.vibrate(duration: 100);
                            HapticFeedback.lightImpact();

                            if (cartLogic.giftCardTextController.text
                                .toString()
                                .replaceAll(" ", "")
                                .isNotEmpty) {
                              customLoaderWidget.showLoader(context);
                              cartLogic.applyGiftCard();
                              Navigator.pop(context);
                            } else {
                              showToastMessage(
                                  message: "Please enter valid Gift Card");
                            }

                            // ProductDetailLogic.to.addProductToCart();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            elevation: 0, // Set the text color of the button
                            padding: const EdgeInsets.all(
                                8), // Set the padding around the button content
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: Text(
                            "Apply",
                            style: context.text.bodyMedium!
                                .copyWith(color: Colors.white, height: 1.1),
                          )),
                    ),
                  ),
                ],
              ),
              10.heightBox,
            ],
          ),
        ),
      );
    },
  );
}
