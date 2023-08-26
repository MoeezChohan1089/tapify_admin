import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/admin_modules/home/logic.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../modules/splash/view.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/global_instances.dart';

class CustomHeadingImage extends StatefulWidget {
  CustomHeadingImage({Key? key}) : super(key: key);

  @override
  State<CustomHeadingImage> createState() => _CustomHeadingImageState();
}

class _CustomHeadingImageState extends State<CustomHeadingImage> {
  bool showImage = false;

  final logic = Get.put(AdminHomeLogic());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showImage == true
            ? InkWell(
                onTap: () {
                  setState(() {
                    showImage = false;
                  });
                },
                child: Image.asset(
                  'assets/images/fillinx.png',
                  width: 108.w,
                  height: 108.h,
                ))
            : InkWell(
                onTap: () {
                  setState(() {
                    showImage = true;
                  });
                },
                child: Image.asset(
                  'assets/images/NoPath.png',
                  width: 108.w,
                  height: 108.h,
                )),
        20.heightBox,
        Container(
          width: double.maxFinite,
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
          child: ElevatedButton(
            onPressed: () async {
              logic.browsingShopId.value = 1;
              final imageUrl = await fetchRandomImage();
              Get.to(() => SplashPage(imageUrl: imageUrl));
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: logic.isProcessing.value
                ? const SpinKitThreeBounce(
                    color: AppColors.customWhiteTextColor,
                    size: 23.0,
                  )
                : Text(
                    "Tap To Explore",
                    style: context.text.bodyLarge
                        ?.copyWith(color: AppColors.customWhiteTextColor),
                  ),
          ),
        ),
      ],
    );
  }
}
