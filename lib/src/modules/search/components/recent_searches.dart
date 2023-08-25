import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

class RecentSearches extends StatefulWidget {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {
  final logic = Get.put(SearchLogic());
  List getRecent = [];

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
  void initState() {
    getRecent = LocalDatabase.to.box.read('recentSearch') ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getRecent.isNotEmpty? Column(
      children: [

        8.heightBox,

        SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal
                ),
                child: Text(
                    "Recent Searches", style: context.text.bodyMedium?.copyWith(color: AppColors.appTextColor)),
              ),
              10.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 14,
                  children: List.generate(getRecent.length, (index) {
                    debugPrint("value of recent: ${getRecent[index]}");
                    return GestureDetector(
                      onTap: (){
                        SearchLogic.to.getPaginatedSearchProductsByRecentTitle(isNewSearch: true, recentTitle: getRecent[index]);
                      },
                      child: customButton(
                          "${getRecent[index]}"),
                    );
                  }),
                ),
              )
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
    ):SizedBox();
  }
}