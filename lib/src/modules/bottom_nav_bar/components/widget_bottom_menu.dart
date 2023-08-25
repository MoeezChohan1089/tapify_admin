import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify/src/modules/auth/view.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../global_controllers/database_controller.dart';
import '../logic.dart';

class BottomNavItem extends StatelessWidget {
  final int indexValue;
  final String title, inActiveIcon, activeIcon;

  final logic = BottomNavBarLogic.to;

  BottomNavItem(
      {super.key,
      required this.indexValue,
      required this.title,
      required this.activeIcon,
      required this.inActiveIcon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          HapticFeedback.lightImpact();
          logic.currentPageIndex.value = indexValue;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logic.currentPageIndex.value == indexValue
                ? Obx(() {
                    return SvgPicture.asset(inActiveIcon,
                        color: AppConfig.to.primaryColor.value, height: 22.h);
                  })
                : SvgPicture.asset(inActiveIcon,
                    color: Colors.black, height: 22.h),

            2.heightBox,
            logic.currentPageIndex.value == indexValue
                ?
            Obx(() {
                    return Text(
                      title,
                      style: context.text.bodySmall?.copyWith(
                          color: AppConfig.to.primaryColor.value),
                    );
                  })
                : Text(
                    title,
                    style: context.text.bodySmall,
                  )
          ],
        ),
      ),
    );
  }
}