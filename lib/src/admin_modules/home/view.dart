import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import 'components/customButtons.dart';
import 'components/customHeadingImage.dart';
import 'components/sure_logout_dialog.dart';
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
        scrolledUnderElevation: 0,
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
      bottomNavigationBar: LocalDatabase.to.box.read("isViewingWithQR") == true
          ? const SizedBox.shrink()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: double.maxFinite,
                  height: 50.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  child: ElevatedButton(
                    onPressed: () {
                      sureLoggingOffDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.red,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: context.text.bodyLarge
                          ?.copyWith(color: AppColors.appPriceRedColor),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
