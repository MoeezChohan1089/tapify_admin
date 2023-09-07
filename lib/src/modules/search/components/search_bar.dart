import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/custom_text_field.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../search/view.dart';
import '../logic.dart';

class SearchFieldBar extends StatefulWidget {
  const SearchFieldBar({Key? key}) : super(key: key);

  @override
  State<SearchFieldBar> createState() => _SearchFieldBarState();
}

class _SearchFieldBarState extends State<SearchFieldBar> {
  // final searchLogic = SearchLogic.to;
  final logic = Get.put(SearchLogic());

  @override
  void initState() {
    super.initState();
    logic.searchTextController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    logic.searchTextController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: pageMarginVertical / 2,
        horizontal: pageMarginHorizontal,
      ),
      child: Column(
        children: [
          5.heightBox,


          CustomTextField(
              controller: logic.searchTextController,
              hint: "Search Products",
              autoFocus: true,
              fieldVerticalPadding: logic.searchedProducts.isNotEmpty
                  ? 0
                  : 8,
              inputFormat: [
                FilteringTextInputFormatter.deny(
                    RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
              ],
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  10.widthBox,
                  Align(
                    widthFactor: 1.8,
                    heightFactor: 1,
                    child: SvgPicture.asset(
                      Assets.icons.searchIcon,
                      color: AppColors.appHintColor,
                      height: 16,
                    ),
                  ),
                  Container(
                    // color: Colors.yellow,
                      margin:const EdgeInsets.only(top: 2),
                      child: Text("|", style: context.text.bodyMedium?.copyWith(color: AppColors.appHintColor),)),

                  8.widthBox,
                ],
              ),
              // onChanged: (word){
              //   word = word;
              //   SearchLogic.to.searchTextController.text = word;
              // },
              onSubmitted: (query) {
                logic.getPaginatedSearchProducts(isNewSearch: true);
              },
              suffixIcon: logic.searchTextController.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  logic.resetValues();
                  logic.searchTextController.clear();
                },
                padding: EdgeInsets.zero,
                icon: Text(
                  'Clear',
                  style: context.text.bodySmall,
                ),
              )
                  : IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {
                  // logic.resetValues();
                  // logic.searchTextController.clear();
                },
                padding: EdgeInsets.zero,
                icon: Text(
                  '',
                  style: context.text.bodySmall,
                ),
              )

          ),


          // TextField(
          //   controller: SearchLogic.to.searchTextController,
          //   style: context.text.bodyLarge,
          //   autofocus: true,
          //   cursorColor: Colors.black,
          //   inputFormatters: [
          //     FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
          //   ],
          //   decoration: InputDecoration(
          //     isDense: true,
          //     fillColor: AppColors.textFieldBGColor, // Set the background color of the input area
          //     filled: true, // Ensure
          //     contentPadding: const EdgeInsets.symmetric(
          //         // vertical: 4,
          //         horizontal: 10
          //     ),
          //
          //     hintText: 'Search product',
          //     hintStyle: context.text.bodyMedium?.copyWith(
          //         color: AppColors.customGreyPriceColor
          //     ),
          //
          //     prefixIcon: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Align(
          //           widthFactor: 2.5,
          //           heightFactor: 1,
          //           child: SvgPicture.asset(
          //             Assets.icons.searchIcon,
          //             color: AppColors.appHintColor,
          //             height: 17,
          //           ),
          //         ),
          //         Container(
          //             margin: EdgeInsets.only(top: 4),
          //             child: Text("|", style: context.text.bodyMedium?.copyWith(color: AppColors.appHintColor),)),
          //       13.widthBox,
          //       ],
          //     ),
          //     prefixIconConstraints: const BoxConstraints(
          //        // Set the minimum width of the prefix icon
          //       minHeight: 40, // Set the minimum height of the prefix icon
          //     ),
          //     // enabledBorder:  OutlineInputBorder(
          //     //   borderSide: const BorderSide(color: Colors.black38),
          //     //   borderRadius: BorderRadius.circular(0.0),
          //     // ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //         color: Colors.grey.shade400,
          //         width: 0.5,
          //       ),
          //       borderRadius: BorderRadius.circular(5.r),
          //     ),
          //   ),
          //   onChanged: (value) {},
          //   onSubmitted: (query){
          //     SearchLogic.to.getPaginatedSearchProducts(isNewSearch: true);
          //   },
          // ),


          // Container(
          //   // margin: EdgeInsets.symmetric(
          //   //   vertical: pageMarginHorizontal,
          //   //   horizontal: pageMarginHorizontal,
          //   // ),
          //   padding: EdgeInsets.symmetric(
          //     vertical: 7.h,
          //   ),
          //   decoration: BoxDecoration(
          //     // color: Colors.grey.shade100,
          //     border: Border.all(
          //       color: Colors.grey.shade400,
          //     ),
          //     // borderRadius: BorderRadius.circular(10.r),
          //     // borderRadius: BorderRadius.circular(10.r),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SvgPicture.asset(
          //           Assets.icons.searchIcon
          //       ),
          //       11.widthBox,
          //       Text('Search Products',
          //         style: context.text.bodyMedium?.copyWith(
          //             height: 0.1
          //         ),
          //       )
          //     ],
          //   ),
          // ),

          5.heightBox,

          ///---- Divider
          // Container(
          //   decoration: BoxDecoration(
          //       border: Border(
          //         top: BorderSide(
          //           color: Colors.grey.shade200,
          //           width: 1.0,
          //         ),
          //       )
          //   ),
          // ),
        ],
      ),
    );
  }
}