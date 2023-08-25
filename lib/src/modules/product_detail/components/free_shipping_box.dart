
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';

class EnjoyFreeShipping extends StatelessWidget {
  const EnjoyFreeShipping({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical * 2),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,vertical: pageMarginVertical),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: Colors.grey.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enjoy Free Shipping",
            style: context.text.labelSmall?.copyWith(fontSize: 15.sp),),
            8.heightBox,
            Text("Spend \$150 or more on full-price and sale items to get free shipping",
              style: context.text.bodyMedium?.copyWith(height: 1.2),)
          ],
        ),
      ),
    );
  }
}