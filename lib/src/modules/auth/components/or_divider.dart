import 'package:flutter/material.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(
        vertical: pageMarginVertical * 2.3,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 80,
            child: Divider(
              thickness: 1,
              color: AppColors.appBordersColor,
            ),
          ),
          Text(
            'OR',
            style: context.text.bodyLarge?.copyWith(
              color: AppColors.appHintColor
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 80,
            child: Divider(
              thickness: 1,
              color: AppColors.appBordersColor,
            ),
          ),
        ],
      ),
    );
  }
}