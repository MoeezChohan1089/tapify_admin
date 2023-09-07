import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../logic.dart';

class VariantsSelector extends StatefulWidget {
  const VariantsSelector({Key? key}) : super(key: key);

  @override
  State<VariantsSelector> createState() =>
      _VariantsSelectorState();
}

class _VariantsSelectorState extends State<VariantsSelector> {
  // String selectedDirection = "Large";
  // List<String> specialist = ["Large", "Medium", "Small"];

  // List<DropdownMenuItem> generateItems(List<String> spesialis) {
  //   List<DropdownMenuItem> items = [];
  //   for (var item in spesialis) {
  //     items.add(
  //       DropdownMenuItem(
  //         child: Text("$item"),
  //         value: item,
  //       ),
  //     );
  //   }
  //   return items;
  // }

  // customButton(String title) {
  //   return Container(
  //       padding: EdgeInsets.only(right: 8.w, left: 8.w, bottom: 9.h, top: 9.h),
  //       decoration: BoxDecoration(
  //           border: Border.all(color: AppColors.customGreyTextColor, width: 1)),
  //       child:
  //           Text(title, style: context.text.bodyMedium?.copyWith(height: 0.9)));
  // }


  final logic = ProductDetailLogic.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailLogic>(builder: (logic) {
      return logic.productDetailLoader.value == true? ShimerSizeAndColorPage()  :
      logic.listOfOptions.isEmpty ?
      AppConfig.to.appSettingsProductDetailPages["dispalySizeCart"] == true ?  Padding(
        padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(Assets.images.chartImage, height: 16,),
            6.widthBox,
            Text("Size Chart", style: context.text.bodyMedium,),
          ],
        ),
      ) : const SizedBox.shrink()

      : Column(
        children: [
          ...List.generate(
              logic.listOfOptions.length,
                  (index) =>
                  Padding(
                    padding: EdgeInsets.only(
                        left: pageMarginHorizontal,
                        right: pageMarginHorizontal,
                        bottom: pageMarginVertical),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${logic.listOfOptions[index]['name']}",
                                  style: context.text.bodyLarge),
                              index == 0 ? AppConfig.to.appSettingsProductDetailPages["dispalySizeCart"] == true ?  Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Image.asset(Assets.images.chartImage, height: 16,),
                                  6.widthBox,
                                  Text("Size Chart", style: context.text.bodyMedium,),
                                ],
                              ) : const SizedBox.shrink() : const SizedBox.shrink(),
                            ],
                          ),

                          Wrap(
                            children: List.generate(
                                logic.listOfOptions[index]['sub_options']
                                    .length,
                                    (index2) =>
                                    Padding(
                                        padding: EdgeInsets.only(
                                            right: 8.w,
                                            top: 8.w
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            logic.updateSelectedVariant(
                                                variantIndex: index,
                                                innerOptionIndex: index2);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  right: 9.w,
                                                  left: 9.w,
                                                  bottom: 11.h,
                                                  top: 14.h),
                                              decoration: BoxDecoration(
                                                  color: AppColors.textFieldBGColor,
                                                  border: Border.all(
                                                      color: logic
                                                          .listOfOptions[index]
                                                      ['sub_options'][index2]
                                                      ['is_selected'] ? AppConfig.to.primaryColor.value:Colors.transparent,
                                                      width: 1),
                                                  borderRadius: BorderRadius.circular(3.r)
                                              ),
                                              child:
                                              Text(
                                                  logic.listOfOptions[index]
                                                  ['sub_options'][index2]
                                                  ['name']
                                                      .toString().capitalize!,
                                                  style: context.text.bodyMedium
                                                      ?.copyWith(
                                                    height: 0.5,
                                                    color: logic
                                                        .listOfOptions[index]
                                                    ['sub_options'][index2]
                                                    ['is_selected']
                                                        ? AppConfig.to.primaryColor.value
                                                        : AppColors.appTextColor,
                                                  ))),
                                        ))
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ],
      );
    });
  }
}