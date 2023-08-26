import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../utils/constants/colors.dart';
import 'components/no_internet.dart';
import 'components/splashLogo.dart';
import 'components/warning.dart';
import 'logic.dart';

class AdminSplashPage extends StatelessWidget {
  AdminSplashPage({Key? key}) : super(key: key);

  final logic = Get.put(AdminSplashLogic());
  final state = Get.find<AdminSplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: logic.currentState.value == "no-internet"
            ? const NoInternetScreen()
            : logic.currentState.value == "error"
                ? const WarningScreen()
                : const SplashLogo(),
        bottomNavigationBar: logic.currentState.value == "continue"
            ? SafeArea(
                child: Wrap(
                  children: const [
                    SpinKitThreeBounce(
                      color: AppColors.appTextColor,
                      size: 23.0,
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      );
    });
  }
}
