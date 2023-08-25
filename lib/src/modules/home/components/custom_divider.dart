import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';

class CustomDivider extends StatelessWidget {
  final dynamic divider;

  const CustomDivider({Key? key, required this.divider}) : super(key: key);

  final String layerIcon = 'line';

  // final Map<String, dynamic> divider = { "type": 2, "custom": {} };

  @override
  Widget build(BuildContext context) {
    return divider["image"] != null
        ? buildCustomDivider(path: divider["image"], isAsset: false)
        : divider["type"] == 0
            ? SizedBox(
                height: 20.h,
              )
            : divider["type"] == 1
                ? buildCustomDivider(
                    path: Assets.icons.lineIcon, isAsset: true, applyPadding: true)
                : divider["type"] == 2
                    ? buildCustomDivider(
                        path: Assets.icons.dottedLineIcon, isAsset: true, applyPadding: true)
                    : divider["type"] == 3
                        ? buildCustomDivider(
                            path: Assets.icons.smallLayerIcon, isAsset: true)
                        : buildCustomDivider(
                            path: Assets.icons.mediumLayerIcon,
                            isAsset: true);
  }

  buildCustomDivider(
      {required String path, required bool isAsset, double height = 20, bool applyPadding = false}) {
    return isAsset
        ? Padding(
      padding: EdgeInsets.only(
        top: pageMarginVertical/3,
        bottom: pageMarginVertical/3,
        left: applyPadding ? pageMarginHorizontal/1.3 : 0,
        right:  applyPadding ? pageMarginHorizontal/1.3 : 0,
      ),
          child: SvgPicture.asset(
              path,
              height: height.h,
              width: divider["type"] == 3 || divider["type"] == 4? 40: double.maxFinite,
              fit: divider["type"] == 3 || divider["type"] == 4? BoxFit.none: BoxFit.fitWidth,
            ),
        )
        : path.startsWith("blob")
            ? Image.network(
                "https://hips.hearstapps.com/hmg-prod/images/2022-toyota-tundra-hybrid-trd-pro-104-64aef90708dab.jpg?crop=0.699xw:0.589xh;0.272xw,0.340xh&resize=1200:*",
                height: 25.h,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : path.endsWith('.svg')
                ? SvgPicture.network(
                    path,
                    height: 2.h,
      width: divider["type"] == 3 || divider["type"] == 4? 40: double.maxFinite,
      fit: divider["type"] == 3 || divider["type"] == 4? BoxFit.none: BoxFit.fitWidth,
                  )
                : Padding(
                  padding:  EdgeInsets.only(bottom: 12.h),
                  child: Image.network(
                      path,
                      height: 25.h,
      width: divider["type"] == 3 || divider["type"] == 4? 40: double.maxFinite,
      fit: divider["type"] == 3 || divider["type"] == 4? BoxFit.none: BoxFit.fitWidth,
                    ),
                );
  }
}