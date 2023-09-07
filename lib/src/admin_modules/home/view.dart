import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../auth/api_services/api_services.dart';
import 'components/customButtons.dart';
import 'components/customHeadingImage.dart';
import 'components/sure_logout_dialog.dart';
import 'logic.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({Key? key}) : super(key: key);

  final logic = Get.put(AdminHomeLogic());
  RxBool isLoading = true.obs;

  @override
  Widget build(BuildContext context) {
    fetchData() async {
      isLoading.value = !(await getShopByQRCode(
          qrToken: LocalDatabase.to.box.read("adminSignedInToken")));
    }

    fetchData();

    return Obx(() {
      return Scaffold(
          backgroundColor: AppColors.customWhiteTextColor,
          appBar: AppBar(
            title: SizedBox(
              height: 35.h,
              child: SvgPicture.asset(Assets.icons.layerIconLogo),
            ),
            centerTitle: true,
            backgroundColor: AppColors.customWhiteTextColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: const SizedBox(),
          ),
          body: isLoading.isFalse
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      20.heightBox,
                      CustomHeadingImage(),
                      20.heightBox,
                      const CustomButtons(),
                    ],
                  ),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.heightBox,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 80,
                          width: 80,
                        ),
                        20.heightBox,
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: pageMarginHorizontal),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 60,
                          width: double.infinity,
                        ),
                        30.heightBox,
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: pageMarginHorizontal),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 100,
                          width: double.infinity,
                        ),
                        20.heightBox,
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: pageMarginHorizontal),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 100,
                          width: double.infinity,
                        ),
                        20.heightBox,
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: pageMarginHorizontal),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 100,
                          width: double.infinity,
                        ),
                        20.heightBox,
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: pageMarginHorizontal),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 100,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: isLoading.isFalse
              ? GetBuilder<AdminHomeLogic>(builder: (logic) {
                  return LocalDatabase.to.box.read("isViewingWithQR") == true
                      ? const SizedBox.shrink()
                      : SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: double.maxFinite,
                              height: 50.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: pageMarginHorizontal),
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
                                  style: context.text.bodyLarge?.copyWith(
                                      color: AppColors.appPriceRedColor),
                                ),
                              ),
                            ),
                          ),
                        );
                })
              : const SizedBox.shrink());
    });
  }
}
