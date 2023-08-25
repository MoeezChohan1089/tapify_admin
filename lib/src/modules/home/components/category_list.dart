import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';

class CategoryList extends StatefulWidget {
  final dynamic settings;

  const CategoryList({Key? key, required this.settings}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // final Map<String, dynamic> settings = {
  // "isTitleHidden": true,
  // "title": 'Your Title ',
  // "titleAlignment": 'left',
  // "titleSize": 'small',
  // "displayType": 'normal',
  // "viewType": 'small',
  // "margin": false,
  // "contentMargin": false,
  // "hideContentTitle": true,
  // "disableInteraction": false,
  // "metadata": []
  // };

  customBoxCategory(String src) {
    return Container(
      height: 118.h,
      width: 101.w,
      padding: EdgeInsets.symmetric(
          vertical: pageMarginHorizontal, horizontal: pageMarginHorizontal),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.customIconColor),
          borderRadius: BorderRadius.circular(6)),
      child: Image.network(
        src,
        width: 47,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: pageMarginVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.settings['isTitleHidden'] == true
              ? Container(
                  width: double.maxFinite,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: pageMarginHorizontal,
                    ),
                    child: Text("${widget.settings['title']}",
                        textAlign: widget.settings['titleAlignment'] == "left"
                            ? TextAlign.left
                            : widget.settings['titleAlignment'] == "center"
                                ? TextAlign.center
                                : TextAlign.right,
                        style: widget.settings['titleSize'] == "small"
                            ? context.text.titleSmall
                            : widget.settings['titleSize'] == "medium"
                                ? context.text.titleMedium
                                : context.text.titleLarge),
                  ),
                )
              : const SizedBox(),
          // pageMarginVertical.heightBox,

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(
              left: widget.settings['margin'] == true
                  ? pageMarginHorizontal * 2
                  : pageMarginHorizontal,
              top: widget.settings['margin'] == true
                  ? pageMarginVertical * 2
                  : pageMarginVertical,
            ),
            child: Row(
              children: List.generate(
                  5,
                  (index) => GestureDetector(
                        onTap: () {
                          if (widget.settings['disableInteraction'] == false) {
                            //wrtie something for route
                          } else {}
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: widget.settings['contentMargin'] == true
                                  ? pageMarginHorizontal + 18.w
                                  : pageMarginHorizontal + 8.w),
                          // width: 90,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customBoxCategory(
                                  'https://pngimg.com/uploads/dress/dress_PNG75.png'),
                              widget.settings['hideContentTitle'] == true
                                  ? 10.heightBox
                                  : SizedBox(),
                              widget.settings['hideContentTitle'] == true
                                  ? SizedBox(
                                      width: 80,
                                      // color: Colors.red,
                                      child: Text(
                                        'Women',
                                        textAlign: TextAlign.center,
                                        style: context.text.bodyLarge?.copyWith(
                                          height: 1.1,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      )),
            ),
          )

          // Container(
          //   height: 160,
          //   child: ListView.builder(
          //       itemCount: 5,
          //       shrinkWrap: true,
          //       scrollDirection: Axis.horizontal,
          //       itemBuilder: (context, index){
          //         return Padding(
          //           padding: EdgeInsets.symmetric(
          //             horizontal: pageMarginHorizontal,
          //           ),
          //           child: ,
          //         );
          //       }),
          // ),
        ],
      ),
    );
  }
}
