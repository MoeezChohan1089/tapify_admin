import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../custom_widgets/custom_snackbar.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';

class CurrencySelector extends StatelessWidget {
  const CurrencySelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: CurrencyController.to.multiCurrencyEnabled.value,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: pageMarginVertical / 2
        ),
        margin: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal
        ),
        decoration:  const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.appBordersColor,
                width: 0.5,
              ),
            )
        ),
        child: Row(
          children: [

            SizedBox(
              width: 45,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(Assets.icons.currencyIcon)),
            ),


            Expanded(
              child: Text("Selected Currency",
                style: context.text.bodyLarge,
              ),
            ),


            Expanded(
              child: Obx(() {
                return DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    // buttonPadding: const EdgeInsets.only(right: 6),
                    // isExpanded: true,
                    // hint: Text('Currency',
                    //     style: context.text.bodyLarge
                    // ),

                    style: context.text.labelSmall?.copyWith(
                        fontSize: 15.sp
                    ),

                    items: CurrencyController.to.exchangeRateOptions
                        .map(
                          (option) =>
                          DropdownMenuItem(
                            value: option,
                            alignment: Alignment.center,
                            child: Text(
                              option,
                              textAlign: TextAlign.center,
                              style: context.text.labelSmall?.copyWith(
                                  fontSize: 15.sp
                              ),
                            ),
                          ),
                    ).toList(),
                    value: CurrencyController.to.selectedCurrency.value,
                    onChanged: (value) {

                      CurrencyController.to.selectedCurrency.value = value as String;





                      showToastMessage(
                          message: "Currency has been updated to $value"
                      );

                      // setState(() {
                      //   selectedColor = value as String;
                      // });
                    },

                    customButton: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.h
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(CurrencyController.to.selectedCurrency.value),
                          4.widthBox,

                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.black,
                            size: 28.sp,
                          ),
                        ],
                      ),
                    ),

                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                      size: 28.sp,
                    ),
                    // iconSize: 28.sp,
                    iconEnabledColor: Colors.white,
                    // buttonWidth: 110.w,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      // color: Colors.grey.shade200,
                    ),
                    itemHeight: 40.h,
                    // itemPadding: const EdgeInsets.only(
                    //     left: 14, right: 14
                    // ),

                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      // color: Colors.,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(10),
                    scrollbarThickness: 4,
                    scrollbarAlwaysShow: true,
                    alignment: Alignment.centerRight,
                    dropdownMaxHeight: 200.h,
                    itemSplashColor: Colors.white.withOpacity(.3),
                  ),
                );
              }),
            ),


          ],
        ),
      ),
    );
  }
}