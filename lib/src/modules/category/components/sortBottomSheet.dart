import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../api_services/shopify_flutter/enums/enums.dart';
import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../auth/components/custom_button.dart';
import '../../product_detail/logic.dart';
import '../logic.dart';

void sortingBottomSheetCollection({required BuildContext context, required String idColl}) {
  // final searchLogic = SearchLogic.to;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    topLeft: Radius.circular(5)),
                color: Colors.white),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  20.heightBox,

                  Row(
                    children: [
                      Expanded(child: SizedBox()),
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

                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.keyboard_arrow_down_outlined, color: AppColors.appTextColor, size: 30,),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     20.heightBox,
                  //
                  //   ],
                  // ),



                  20.heightBox,

                  SortOptionWidget(
                    title: "Title",
                    sortKey: SortKeyProductCollection.TITLE,
                    collectionID: idColl,
                  ),
                  SortOptionWidget(
                    title: "Best Selling",
                    sortKey: SortKeyProductCollection.BEST_SELLING,
                    collectionID: idColl,
                  ),
                  SortOptionWidget(
                    title: "Price",
                    sortKey: SortKeyProductCollection.PRICE,
                    collectionID: idColl,
                  ),
                  SortOptionWidget(
                    title: "Relevance",
                    sortKey: SortKeyProductCollection.RELEVANCE,
                    collectionID: idColl,
                  ),
                  SortOptionWidget(
                    title: "Recently Created",
                    sortKey: SortKeyProductCollection.CREATED,
                    collectionID: idColl,
                  ),
                  SortOptionWidget(
                    title: "Manual",
                    sortKey: SortKeyProductCollection.MANUAL,
                    collectionID: idColl,
                  ),
                  SortOptionWidget(
                    title: "By ID",
                    sortKey: SortKeyProductCollection.ID,
                    collectionID: idColl,
                  ),

                  // const Spacer(),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
                    child: GlobalElevatedButton(
                      text: "Apply", onPressed: () {



                      //---- Call the Products
                      if(CategoryLogic.to.showFilteredProducts.isTrue){
                        CategoryLogic.to.fetchProductBasedOnFilters(
                            context: context,
                            isNewId: true,
                            sortKey: CategoryLogic.to.sortKeyProduct
                        );
                      } else {
                        CategoryLogic.to.productFetchService(context: context, id: idColl, isNewId: true, sortKey: CategoryLogic.to.sortKeyProduct);
                      }
                      Navigator.pop(context);
                    },
                      isLoading: false,
                    ),
                  )
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: pageMarginHorizontal,
                  //       vertical: pageMarginVertical
                  //   ),
                  //   child: AuthBlackButton(
                  //     buttonTitle: "apply sorting",
                  //     onPressed: () {
                  //       Vibration.vibrate(duration: 100);
                  //
                  //     },
                  //   ),
                  // ),

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
  final SortKeyProductCollection sortKey;
  final String collectionID;

  SortOptionWidget({
    super.key,
    required this.title,
    required this.sortKey,
    required this.collectionID
  });

  // final searchLogic = SearchLogic.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryLogic>(builder: (category) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {

              category.sortKeyProduct = sortKey;

              category.update();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,
                  vertical: pageMarginVertical - 5.h),
              decoration: BoxDecoration(
                color: category.sortKeyProduct == sortKey ? AppColors.textFieldBGColor: AppColors.customWhiteTextColor,
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
                      child: category.sortKeyProduct == sortKey
                          ?  Icon(
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
        ],
      );
    });
  }
}