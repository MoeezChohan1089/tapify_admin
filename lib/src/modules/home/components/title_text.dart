import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';
import '../../product_detail/view.dart';

class TitleText extends StatelessWidget {
  final dynamic settings;
  const TitleText({Key? key, required this.settings}) : super(key: key);

  final String variant = "Small";

  //----- Small, Medium, Large

  // final Map settings = {
  //   "title": 'Title will be here',
  //   "titleAlignment":  'left',   //-- left - right - center
  //   "titleSize": 'small'         //-- small - medium - large
  // };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: pageMarginVertical / 1.3,
        horizontal: pageMarginHorizontal/1.3
      ),
      width: context.deviceWidth,
      // color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          settings["title"] ?? "",
          textAlign: settings["titleAlignment"] == "left" ? TextAlign.left : settings["titleAlignment"] == "right" ? TextAlign.right : TextAlign.center,
         style: settings["titleSize"] == "small" ? context.text.titleSmall : settings["titleSize"] == "medium" ? context.text.titleMedium : context.text.titleLarge
        ),
      ),
    );
  }
}