import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';

class CustomButtons extends StatefulWidget {
  const CustomButtons({Key? key}) : super(key: key);

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {

  CustomButtonBox(BuildContext context, String title, String assetName, color){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical/1.4),
      child: Container(
        height: 136,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 3), // Offset in the x and y direction
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginVertical),
          child: Row(
            children: [
              SvgPicture.asset(assetName),
              24.widthBox,
              Expanded(flex:2, child: Text("$title", style: context.text.bodyMedium!.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),)),
              Spacer(),
              Icon(Icons.arrow_forward, color: color, size: 28,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtonBox(context, "Push Notifications", Assets.icons.pushNotificationIcon, Color(0xffff9999)),
        CustomButtonBox(context, "Messages", Assets.icons.messagesIcon, Color(0xffc4bfd9)),
        CustomButtonBox(context, "Profile", Assets.icons.profileIcon, Color(0xff99ccbf)),
      ],
    );
  }
}
