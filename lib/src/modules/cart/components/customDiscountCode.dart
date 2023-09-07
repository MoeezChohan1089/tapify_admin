import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/customTextField.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';
import 'apply_discount_gift_Card_Sheets.dart';
import 'discountCodeDialogue.dart';

class DiscountCodeAndGiftCardFields extends StatelessWidget {
  DiscountCodeAndGiftCardFields({Key? key}) : super(key: key);

  final cartLogic = CartLogic.to;
  bool showDiscountField = AppConfig.to.appSettingsStoreSettings["allowsDiscountCodes"];
  bool showGiftCardField = AppConfig.to.appSettingsStoreSettings["allowGiftCards"];

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showDiscountField || showGiftCardField, // Show if either is true
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
        child: Row(
          children: [
            if (showDiscountField)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDiscountAndGiftCardSheet(
                      context: context,
                      isDiscountSheet: true,
                    );
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: CustomTextField(
                      controller: cartLogic.discountCodeTextController,
                      hint: "Use Discount Code",
                      textAlign: TextAlign.center,
                      fieldVerticalPadding: 8,
                      // isEditable: false,
                    ),
                  ),
                ),
              ),
            if (showGiftCardField) 10.widthBox,
            if (showGiftCardField)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    showDiscountAndGiftCardSheet(
                      context: context,
                      isDiscountSheet: false,
                    );
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: CustomTextField(
                      controller: cartLogic.giftCardTextController,
                      hint: "Use Gift Card",
                      textAlign: TextAlign.center,
                      fieldVerticalPadding: 8,
                      // isEditable: false,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}