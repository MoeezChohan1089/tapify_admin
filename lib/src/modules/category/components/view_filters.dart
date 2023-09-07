import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/category/components/view_filter_options.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../custom_widgets/custom_app_bar.dart';
import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../auth/components/custom_button.dart';
import '../api_service/model_filters.dart';
import '../logic.dart';

class CollectionFiltersView extends StatelessWidget {
  const CollectionFiltersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "filters",
        backIcon: Icons.keyboard_arrow_down_outlined,
        trailingButton: TextButton(
          onPressed: (){
            CategoryLogic.to.resetFilters();
            CategoryLogic.to.productFetchService(
              context: context,
              id: CategoryLogic.to.currentCategoryId.value,
              isNewId: true
            );
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.red
          ),
          child: Text('Clear',
           style: context.text.bodyMedium?.copyWith(
             color: Colors.red
           ),
          ),
        ),
      ),
      body: GetBuilder<CategoryLogic>(builder: (categoryLogic) {
        return Column(
          children: [


            ///------ Filters Available
            ...List.generate(categoryLogic.filtersAvailable.length, (index) {


              bool isEqual(dynamic a, dynamic b) {
                return const DeepCollectionEquality().equals(a, b);
              }



              int countSelectedFilterOptions(String filterLabel,
                 ) {
                int count = 0;
                for (Filter filter in categoryLogic.filtersAvailable) {
                  if (filter.label == filterLabel) {
                    print('Matching filter found: ${filter.label}');
                    for (FilterValue value in filter.values) {
                      for (Map<String, dynamic> selectedFilter in categoryLogic.selectedFilters) {
                        if (isEqual(selectedFilter, jsonDecode(value.input))) {
                          print('Matching input found: ${selectedFilter['input']}');
                          count++;
                        }
                      }
                    }
                    break; // No need to continue searching if we found the matching filter.
                  }
                }
                return count;
              }




              // int countVariantOption(String name) {
              //   int count = 0;
              //   if(categoryLogic.selectedFilters.isNotEmpty) {
              //     for (var filter in categoryLogic.selectedFilters) {
              //       Map<String, dynamic> variantOption = filter['variantOption'];
              //       if (variantOption['name'] == name) {
              //         count++;
              //       }
              //     }
              //   }
              //   return count;
              // }


              return  InkWell(
                onTap: () {

                  Get.to(() => FilterOptionsView(filter: categoryLogic.filtersAvailable[index]),
                      transition: Transition.rightToLeft,
                      opaque: false,
                      duration: const Duration(milliseconds: 250)
                  );

                  // category.sortKeyProduct = sortKey;
                  // category.update();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: pageMarginHorizontal,
                      vertical: pageMarginVertical - 4.h),
                  decoration: const BoxDecoration(
                    color: AppColors.customWhiteTextColor,
                    border: Border(
                        top:
                        BorderSide(color: Color(0xffF2F2F2), width: 1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        categoryLogic.filtersAvailable[index].label,
                        style: context.text.labelSmall?.copyWith(
                            color: AppColors.customBlackTextColor, fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                          categoryLogic.selectedFilters.isEmpty ? "All" : countSelectedFilterOptions(categoryLogic.filtersAvailable[index].label) == 0 ? "--" : countSelectedFilterOptions(categoryLogic.filtersAvailable[index].label).toString(),
                        style: context.text.labelSmall?.copyWith(
                            color: AppColors.customGreyPriceColor.withOpacity(.6), fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              );

            }
            ),


            const Spacer(),


            SafeArea(
              child: GlobalElevatedButton(
                text: "apply filter",
                onPressed: () {
                        if(CategoryLogic.to.selectedFilters.isEmpty) {
                          CategoryLogic.to.resetFilters();
                          CategoryLogic.to.productFetchService(
                              context: context, id: CategoryLogic.to.currentCategoryId.value, isNewId: true);
                        } else {
                          CategoryLogic.to.fetchProductBasedOnFilters(context: context, isNewId: true);
                        }

                        // CategoryLogic.to.productFetchService(context: context, id: idColl, isNewId: true, sortKey: CategoryLogic.to.sortKeyProduct);
                        Navigator.pop(context);
                },
                isLoading: false,
                applyHorizontalPadding: true,
              ),
            ),

            10.heightBox,

            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: pageMarginHorizontal,
            //       vertical: pageMarginVertical
            //   ),
            //   child: AuthBlackButton(
            //     buttonTitle: "apply filter",
            //     onPressed: () {
            //       Vibration.vibrate(duration: 100);
            //       if(CategoryLogic.to.selectedFilters.isEmpty) {
            //         CategoryLogic.to.resetFilters();
            //         CategoryLogic.to.productFetchService(
            //             context: context, id: CategoryLogic.to.currentCategoryId.value, isNewId: true);
            //       } else {
            //         CategoryLogic.to.fetchProductBasedOnFilters(context: context, isNewId: true);
            //       }
            //
            //       // CategoryLogic.to.productFetchService(context: context, id: idColl, isNewId: true, sortKey: CategoryLogic.to.sortKeyProduct);
            //       Navigator.pop(context);
            //
            //
            //       // ProductDetailLogic.to.addProductToCart(context);
            //     },
            //   ),
            // ),


          ],
        );
      }),
    );
  }
}