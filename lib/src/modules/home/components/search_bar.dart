import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../search/view.dart';

class SearchBarContainer extends StatelessWidget {
  final dynamic settings;
  const SearchBarContainer({Key? key, required this.settings})
      : super(key: key);

  // final int searchBarType = 0;
  // final Map settings = {
  //   "border": 1
  // };
  // final String searchBarType = "Rounded";
  //---- 0 = Sharp Rectangle
  //---- 1 = Rounded
  //---- 2 = Circular
  //---- 3 = Underlined

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: pageMarginVertical / 1.5,
        bottom: pageMarginVertical / 1.5,
        left: pageMarginHorizontal / 1.5,
        right: pageMarginHorizontal / 1.5,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 11.h,
          ),
          decoration: BoxDecoration(
            color: settings["border"] != 3
                ? AppColors.textFieldBGColor
                : Colors.transparent,
            border: settings["border"] == 3
                ? const Border(
                    // border: searchBarType == "Underlined" ?  Border(
                    bottom: BorderSide(
                    color: AppColors.appBordersColor,
                  ))
                : Border.all(
                    color: Colors.transparent,
                  ),
            borderRadius: (settings["border"] == 0 || settings["border"] == 3)
                ? null
                : settings["border"] == 1
                    ? BorderRadius.circular(5.r)
                    : BorderRadius.circular(50.r),
            // borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.widthBox,
              Align(
                widthFactor: 1.8,
                heightFactor: 1,
                child: SvgPicture.asset(
                  Assets.icons.searchIcon,
                  height: 16.h,
                  color: AppColors.appHintColor,
                ),
              ),
              Container(
                  // color: Colors.yellow,
                  margin: const EdgeInsets.only(top: 2),
                  child: Text(
                    "|",
                    style: context.text.bodyMedium
                        ?.copyWith(color: AppColors.appHintColor),
                  )),
              8.widthBox,
              Container(
                // color: Colors.blue,
                margin: const EdgeInsets.only(top: 2),
                child: Text(
                  'Search Products',
                  style: context.text.bodyMedium?.copyWith(
                      color: AppColors.appHintColor, fontSize: 14.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
