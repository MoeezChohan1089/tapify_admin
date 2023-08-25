import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../../global_controllers/database_controller.dart';
import '../../../../utils/constants/assets.dart';
import '../../../../utils/constants/margins_spacnings.dart';
import '../../../auth/logic.dart';
import '../logic.dart';

class EditProfileImageSection extends StatelessWidget {
  final Edit_profileLogic logic = Get.put(Edit_profileLogic());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: pageMarginVertical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 70.h,
                width: 70.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.textFieldBGColor
                ),
                child: SvgPicture.asset(Assets.icons.userProfileIcon,
                  color: AppColors.appBordersColor,

                )
            ),
            16.heightBox,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  final firstName = logic.infor.isNotEmpty ? logic.infor[0]['firstname'] : '';
                  final lastName = logic.infor.isNotEmpty ? logic.infor[0]['lastname'] : '';
                  return Text(
                    '$firstName $lastName',
                    style: context.text.labelMedium?.copyWith(fontSize: 20.sp, color: AppColors.appTextColor, fontWeight: FontWeight.bold),
                  );
                }),
                Obx(() {
                  final email = logic.infor.isNotEmpty ? logic.infor[0]['email'] : '';
                  return Text(
                    email,
                    style: context.text.bodyMedium?.copyWith(fontSize: 14.sp, color: AppColors.appHintColor),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}