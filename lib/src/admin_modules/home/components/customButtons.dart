import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/admin_modules/home/components/enums.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../global_controllers/database_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../auth/view.dart';
import 'admin_web_view.dart';

class CustomButtons extends StatefulWidget {
  const CustomButtons({Key? key}) : super(key: key);

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {
  CustomButtonBox(Function onPress, BuildContext context, String title,
      String subTitle, String assetName, color) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: pageMarginHorizontal, vertical: pageMarginVertical / 2),
      child: GestureDetector(
        onTap: () => onPress(),
        child: Container(
          height: 93.h,
          decoration: BoxDecoration(
              color: AppColors.textFieldBGColor,
              borderRadius: BorderRadius.circular(5.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: pageMarginVertical),
            child: Row(
              children: [
                SvgPicture.asset(assetName),
                24.widthBox,
                Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$title",
                          style: context.text.labelLarge!.copyWith(
                              fontSize: 16.sp, color: AppColors.appTextColor),
                        ),
                        Text(
                          "$subTitle",
                          style: context.text.bodyMedium!.copyWith(
                              fontSize: 12.sp, color: AppColors.appHintColor),
                        ),
                      ],
                    )),
                Spacer(),
                SvgPicture.asset(Assets.icons.arrowIcon),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtonBox(() {
          if (LocalDatabase.to.box.read("isViewingWithQR")) {
            Get.to(() => AdminSignInPage(
                isRedirectToWeb: true, urlToRedirect: PageURLs.notification));
          } else {
            Get.to(() =>
                AdminWebView(pageURL: getEnumTypeURL(PageURLs.notification)));
          }
        },
            context,
            "Push Notifications",
            "Enable push notifications and get the latest right at your fingertips.",
            Assets.icons.notificationIcon,
            AppColors.appTextColor),
        CustomButtonBox(() {
          if (LocalDatabase.to.box.read("isViewingWithQR")) {
            Get.to(() => AdminSignInPage(
                isRedirectToWeb: true, urlToRedirect: PageURLs.messages));
          } else {
            Get.to(
                () => AdminWebView(pageURL: getEnumTypeURL(PageURLs.messages)));
          }
        },
            context,
            "Messages",
            "Chat with your customers about orders or something else",
            Assets.icons.messageIcon,
            AppColors.appTextColor),
        CustomButtonBox(() {
          if (LocalDatabase.to.box.read("isViewingWithQR")) {
            Get.to(() => AdminSignInPage(
                isRedirectToWeb: true, urlToRedirect: PageURLs.profile));
          } else {
            Get.to(
                () => AdminWebView(pageURL: getEnumTypeURL(PageURLs.profile)));
          }
        },
            context,
            "Profile",
            "Set up your profile and make the app truly yours.",
            Assets.icons.profileIcon,
            AppColors.appTextColor),
        CustomButtonBox(() {
          if (LocalDatabase.to.box.read("isViewingWithQR")) {
            Get.to(() => AdminSignInPage(
                isRedirectToWeb: true, urlToRedirect: PageURLs.support));
          } else {
            Get.to(
                () => AdminWebView(pageURL: getEnumTypeURL(PageURLs.support)));
          }
        },
            context,
            "Contact Support",
            "Tap into our customer support – we're just a click away, anytime you need.",
            Assets.icons.supportIcon,
            AppColors.appTextColor),
      ],
    );
  }
}
