import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';

class WarningScreen extends StatelessWidget {
  const WarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhiteTextColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: pageMarginHorizontal * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.warningImage,
              width: 100,
            ),
            14.heightBox,
            Text('Whoops! Found Error', textAlign: TextAlign.center, style: context.text.labelMedium?.copyWith(fontSize: 16.sp, color: AppColors.appTextColor),),
            10.heightBox,
            Text('An unknown error has occurred, Please try again', textAlign: TextAlign.center, style: context.text.labelSmall?.copyWith(fontSize: 14.sp, color: AppColors.customGreyPriceColor),),
            30.heightBox,
            GlobalElevatedButton(
              text: "Try Again",
              onPressed: () {
                SplashLogic.to.myNewNavigator();
              },
              isLoading: false,
              applyHorizontalPadding: true,
            ),
          ],
        ),
      ),
    );
  }
}