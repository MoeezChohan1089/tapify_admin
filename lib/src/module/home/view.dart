import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
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
        toolbarHeight: 100,
        title: SvgPicture.asset(Assets.icons.appLogoIcon),
            centerTitle: true,
        elevation: 0,
        leading: SizedBox(),
        backgroundColor: AppColors.customWhiteTextColor,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeadingImage(),
            10.heightBox,
            CustomButtons(),
          ],
        ),
      ),
    );
  }
}
