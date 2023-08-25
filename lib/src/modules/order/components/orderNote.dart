import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../utils/constants/colors.dart';

class orderNoteScreen extends StatelessWidget {
  final Order? orderDetailsNote;
  const orderNoteScreen({Key? key, this.orderDetailsNote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: pageMarginVertical),
      child: Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Note:",
              style: context.text.labelSmall
                  ?.copyWith(color: Colors.black, fontSize: 15.sp),
            ),
            8.heightBox,
            Text(
              "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.",
              style: context.text.bodyMedium
                  ?.copyWith(height: 1.2, color: AppColors.appHintColor),
            )
          ],
        ),
      ),
    );
  }
}
