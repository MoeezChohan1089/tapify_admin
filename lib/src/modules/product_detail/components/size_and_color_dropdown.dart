import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../logic.dart';

class SizeAndColorDropdowns extends StatefulWidget {
  const SizeAndColorDropdowns({Key? key}) : super(key: key);

  @override
  State<SizeAndColorDropdowns> createState() => _SizeAndColorDropdownsState();
}

class _SizeAndColorDropdownsState extends State<SizeAndColorDropdowns> {


  String? selectedColor, selectedSize;
  dynamic sizeList = ["Small", "Medium", "Large"];
  dynamic colorList = ["Red", "Green", "Blue"];

  final logic = Get.find<ProductDetailLogic>();

  @override
  Widget build(BuildContext context) {
    return logic.productDetailLoader.value == true? ShimerSizeAndColorPage(): Padding(
      padding:  EdgeInsets.symmetric(
          horizontal: pageMarginHorizontal,
          vertical: pageMarginVertical
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide( //                   <--- left side
                    color: Colors.black,
                    width: 0.3,
                  ),
                  right: BorderSide( //                   <--- left side
                    color: Colors.black,
                    width: 0.15,
                  ),
                  top: BorderSide( //                    <--- top side
                    color: Colors.black,
                    width: 0.3,
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  itemPadding: EdgeInsets.zero,
                  buttonPadding: const EdgeInsets.only(right: 6),
                  // isExpanded: true,
                  hint: Text('Size',
                      style: context.text.bodyLarge
                  ),
                  items: List.generate(
                    sizeList.length,
                        (index) =>
                        DropdownMenuItem(
                          value: sizeList[index],
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Text('${sizeList[index]}',
                                style: context.text.bodyMedium
                            ),
                          ),
                        ),
                  ),
                  value: selectedSize,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                  iconSize: 28.sp,
                  iconEnabledColor: Colors.white,
                  // buttonWidth: 110.w,
                  // buttonPadding: EdgeInsets.symmetric(
                  //     horizontal: 0.w),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.transparent,
                  ),
                  itemHeight: 43,
                  // itemPadding: const EdgeInsets.only(
                  //     left: 14, right: 14),
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    // color: Colors.,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(10),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  itemSplashColor: Colors.white.withOpacity(.3),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(

                  bottom: BorderSide( //                   <--- left side
                    color: Colors.black,
                    width: 0.3,
                  ),
                  left: BorderSide( //                   <--- left side
                    color: Colors.black,
                    width: 0.15,
                  ),
                  top: BorderSide( //                    <--- top side
                    color: Colors.black,
                    width: 0.3,
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  buttonPadding: const EdgeInsets.only(right: 6),
                  isExpanded: true,
                  hint: Text('Color',
                      style: context.text.bodyLarge
                  ),
                  items: List.generate(
                    colorList.length,
                        (index) =>
                        DropdownMenuItem(
                          value: colorList[index],
                          child: Text('${colorList[index]}',

                              style: context.text.bodyMedium
                          ),
                        ),
                  ),
                  value: selectedColor,
                  onChanged: (value) {
                    setState(() {
                      selectedColor = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                  iconSize: 28.sp,
                  iconEnabledColor: Colors.white,
                  // buttonWidth: 110.w,

                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.transparent,
                  ),
                  itemHeight: 43,
                  itemPadding: const EdgeInsets.only(
                      left: 14, right: 14),
                  dropdownPadding: null,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    // color: Colors.,
                  ),
                  dropdownElevation: 8,
                  scrollbarRadius: const Radius.circular(10),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  itemSplashColor: Colors.white.withOpacity(.3),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}