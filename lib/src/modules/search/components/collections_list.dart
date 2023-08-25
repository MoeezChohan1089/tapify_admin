import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../category/logic.dart';
import '../../category/view_category_products.dart';

class CollectionsList extends StatefulWidget {
  const CollectionsList({Key? key}) : super(key: key);

  @override
  State<CollectionsList> createState() => _CollectionsListState();
}

class _CollectionsListState extends State<CollectionsList> {
  int selection = 0;

  customButton(String title) {
    return Container(
        padding: EdgeInsets.only(
            right: 14.w,
            left: 14.w,
            bottom: 9.h,
            top: 9.h
        ),
        decoration: BoxDecoration(
            color: AppColors.textFieldBGColor,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Text(title, style: context.text.bodySmall?.copyWith(
            color: AppColors.appTextColor
        ))
      // DropdownButton(
      //   menuMaxHeight: 300,
      //   isExpanded: true,
      //   underline: SizedBox(),
      //   icon: Icon(Icons.keyboard_arrow_down_outlined),
      //   value: selectedDirection,
      //   items: generateItems(specialist),
      //   onChanged: (dynamic item) {
      //     setState(() {
      //       selectedDirection = item;
      //     });
      //   },
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        14.heightBox,


        SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal
                ),
                child: Text("Collections", style: context.text.bodyMedium?.copyWith(color: AppColors.appTextColor)),
              ),
              10.heightBox,
              GetBuilder<CategoryLogic>(
                  assignId: true,
                  init: CategoryLogic(),
                  builder: (logic) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: pageMarginHorizontal
                      ),
                      child: Wrap(
                        spacing: 8,// Adjust the horizontal spacing between items
                        runSpacing: 14,
                        children: List.generate(logic.categoryCollection.length, (index) {
                          return GestureDetector(
                            onTap: (){
                              selection = index;
                              Get.to(() => CategoryProducts(
                                collectionID: logic.categoryCollection[index].id,
                                categoryName: logic.categoryCollection[index].title,));
                            },
                            child: customButton(logic.categoryCollection[index].title),
                          );
                        }),
                      ),
                    );
                  })
            ],
          ),
        ),


        12.heightBox,

        ///---- Divider
        Container(
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1.0,
                ),
              )
          ),
        ),

      ],
    );
  }
}