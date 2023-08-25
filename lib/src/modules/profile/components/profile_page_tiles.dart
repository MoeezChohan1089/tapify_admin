import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';

class ProfilePageTiles extends StatelessWidget {
  final String title, iconPath;
  final Function onPress;
  const ProfilePageTiles(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: pageMarginVertical),
        margin: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: AppColors.appBordersColor,
            width: 0.5,
          ),
        )),
        child: Row(
          children: [
            SizedBox(
              width: 45,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(iconPath!)),
            ),
            Expanded(
              child: Text(
                title!,
                style: context.text.bodyLarge
                    ?.copyWith(color: AppColors.appTextColor, fontSize: 16.sp),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 18.sp,
            )
          ],
        ),
      ),
    );
  }
}
