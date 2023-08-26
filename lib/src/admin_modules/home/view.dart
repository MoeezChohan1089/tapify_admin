import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import 'components/customButtons.dart';
import 'components/customHeadingImage.dart';
import 'logic.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({Key? key}) : super(key: key);

  final logic = Get.put(AdminHomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhiteTextColor,
      appBar: AppBar(
        title: SizedBox(
          height: 35.h,
          // color: Colors.red,
          child: Image.asset(Assets.images.sanaSafinazLogo),
        ),
        centerTitle: true,
        backgroundColor: AppColors.customWhiteTextColor,
        elevation: 0,
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.heightBox,
            CustomHeadingImage(),
            20.heightBox,
            const CustomButtons(),
          ],
        ),
      ),
    );
  }
}
