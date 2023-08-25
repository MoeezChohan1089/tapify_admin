import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/modules/product_detail/components/bottom_sheet_notify_me.dart';
import 'package:tapify/src/utils/constants/assets.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../logic.dart';

class NotifyMeSection extends StatelessWidget {
  NotifyMeSection({super.key});


  final logic = Get.find<ProductDetailLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: logic.product == null ? false : logic.listOfOptions.isEmpty ? logic.product!
            .availableForSale == true ? false : true :
        logic.product?.productVariants[logic.selectedVariantIndex.value]
            .availableForSale == true ? false : true
        ,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,
              vertical: pageMarginVertical + 6),
          child: GestureDetector(
            onTap: (){
              notifyMeBottomSheet(context: context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              width: double.maxFinite,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.appPriceRedColor, width: 1),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.icons.notifyMeIcon,
                    height: 18,
                    color: AppColors.appPriceRedColor,
                  ),
                  10.widthBox,
                  Text("Notify me when available", textAlign: TextAlign.center,
                    style: context.text.bodyMedium?.copyWith(
                        color: AppColors.appPriceRedColor, fontSize: 16.sp),),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}