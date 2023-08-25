import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../api_services/shopify_flutter/enums/enums.dart';
import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';

void sortingBottomSheet(context) {
  // final searchLogic = SearchLogic.to;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5)),
                color: Colors.white),
            child: SafeArea(
              child: Wrap(
                children: <Widget>[
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //     padding: const EdgeInsets.all(2),
                  //     margin: const EdgeInsets.all(10),
                  //     width: 80,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         color: Theme.of(context).hintColor),
                  //   ),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      15.heightBox,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.appTextColor, size: 30,),
                              ),
                            ),
                          ),
                          Expanded(
                              child:
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Sort by".toUpperCase(),
                                  style: context.text.titleMedium?.copyWith(
                                    color: AppColors.appTextColor,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              )),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                      10.heightBox,
                      SortOptionWidget(
                        title: "Title",
                        sortKey: SortKeyProduct.TITLE,
                        isLastItem: false,
                      ),
                      SortOptionWidget(
                        title: "Best Selling",
                        sortKey: SortKeyProduct.BEST_SELLING,
                        isLastItem: false,
                      ),
                      SortOptionWidget(
                        title: "Price",
                        sortKey: SortKeyProduct.PRICE,
                        isLastItem: false,
                      ),
                      SortOptionWidget(
                        title: "Relevance",
                        sortKey: SortKeyProduct.RELEVANCE,
                        isLastItem: false,
                      ),
                      SortOptionWidget(
                        title: "Recently Created",
                        sortKey: SortKeyProduct.CREATED_AT,
                        isLastItem: false,
                      ),
                      SortOptionWidget(
                        title: "Recently Updated",
                        sortKey: SortKeyProduct.UPDATED_AT,
                        isLastItem: false,
                      ),
                      SortOptionWidget(
                        title: "By Vendor",
                        sortKey: SortKeyProduct.VENDOR,
                        isLastItem: false,
                      ),
                      SortOptionWidget(
                        title: "By ID",
                        sortKey: SortKeyProduct.ID,
                        isLastItem: true,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
                        child: GlobalElevatedButton(
                          text: "Apply", onPressed: () {

                          //---- Call the Products
                          SearchLogic.to.getPaginatedSearchProducts(isNewSearch: true, sortKey: SearchLogic.to.sortKeyProduct);
                          Navigator.pop(context);
                        },
                          isLoading: false,
                        ),
                      )
                      // Obx(() {
                      //   return GestureDetector(
                      //     onTap: () {
                      //       // searchLogic.isSorting.value = 1;
                      //     },
                      //     child: Container(
                      //       padding:const EdgeInsets.all(8),
                      //       decoration: const BoxDecoration(
                      //         color: AppColors.customWhiteTextColor,
                      //         border: Border(top: BorderSide(
                      //             color: AppColors.customGreyTextColor,
                      //             width: 1)),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           Expanded(
                      //               flex: 2,
                      //               child: Text("Featured",
                      //                 style: context.text.titleMedium
                      //                     ?.copyWith(
                      //                     color: AppColors
                      //                         .customBlackTextColor,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.bold),)
                      //           ),
                      //           const Spacer(),
                      //           Expanded(
                      //             child: Align(
                      //                 alignment: Alignment.bottomRight,
                      //                 child:
                      //                 // searchLogic.isSorting.value == 1
                      //                 //     ?
                      //                 const Icon(
                      //                   Icons.check, color: Colors.black,
                      //                   size: 16,)
                      //                     // :const SizedBox()
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   );
                      // }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      }).then((value) {
    // if (groupRadio == 2) {
    //   setState(() {});
    // } else if (groupRadio == 3) {
    //   setState(() {});
    // }
  });
}

class SortOptionWidget extends StatelessWidget {
  final String title;
  final SortKeyProduct sortKey;
  final bool isLastItem;

  SortOptionWidget({
    super.key,
    required this.title,
    required this.sortKey,
    required this.isLastItem,
  });

  // final searchLogic = SearchLogic.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchLogic>(builder: (searchLogic) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              print("UPDATED");
              searchLogic.sortKeyProduct = sortKey;
              searchLogic.update();


            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,
                  vertical: pageMarginVertical - 5.h),
              decoration: BoxDecoration(
                color: searchLogic.sortKeyProduct == sortKey ? AppColors.textFieldBGColor: AppColors.customWhiteTextColor,
                border: const Border(
                    top:
                    BorderSide(color: AppColors.textFieldBGColor, width: 1),
                    bottom: BorderSide(color: AppColors.textFieldBGColor, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: searchLogic.sortKeyProduct == sortKey
                          ? Icon(
                        Icons.check,
                        color: AppConfig.to.primaryColor.value,
                        size: 20,
                      )
                          : const SizedBox(width: 20,)),
                  18.widthBox,
                  Expanded(
                      flex: 2,
                      child: Text(
                        title,
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.appTextColor, fontSize: 14.sp),
                      )),
                ],
              ),
            ),
          ),
          // (isLastItem)? Padding(
          //   padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
          //   child: GlobalElevatedButton(
          //     text: "Apply", onPressed: () {
          //
          //
          //
          //     //---- Call the Products
          //     searchLogic.getPaginatedSearchProducts(isNewSearch: true, sortKey: sortKey);
          //     Navigator.pop(context);
          //   },
          //     isLoading: false,
          //   ),
          // ):const SizedBox(),
        ],
      );
    });
  }
}