import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import 'components/customButtons.dart';
import 'components/customHeadingImage.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhiteTextColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: SizedBox(
          height: 35.h,
          // color: Colors.red,
          child: SvgPicture.asset(Assets.icons.layerIconLogo),
        ),
        centerTitle: true,
        backgroundColor: AppColors.customWhiteTextColor,
        elevation: 0,
        leading: SizedBox(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: double.maxFinite,
            height: 50.h,
            padding: EdgeInsets.symmetric(
                horizontal: pageMarginHorizontal
            ),
            child: ElevatedButton(

              onPressed: () {
                // if(logic.formKeyValue.currentState!.validate()){
                //   // AuthLogic.to.isProcessing.value = true;
                //   // AuthLogic.to.signInUser(context: context);
                //   AuthLogic.to.signInUser(context: context);
                // }
              },


              // onPressed: isDisable || isLoading
              //     ? null // If the button is disabled or in loading state, onPressed should be null
              //     : () {
              //   HapticFeedback.lightImpact();
              //   onPressed();
              // },
              style: ElevatedButton.styleFrom(
                // backgroundColor: const Color(0xff3B8C6E),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              20.heightBox,
              CustomHeadingImage(),
              20.heightBox,
              CustomButtons(),

            ],
          ),
        ),
      ),
    );
  }
}
