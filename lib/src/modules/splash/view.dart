import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import 'components/no_internet.dart';
import 'components/splashLogo.dart';
import 'components/warning.dart';
import 'logic.dart';

class SplashPage extends StatefulWidget {
  final String imageUrl;
  SplashPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final logic = Get.put(SplashLogic());

  final state = Get
      .find<SplashLogic>()
      .state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          systemStatusBarContrastEnforced: false,
          systemNavigationBarContrastEnforced: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            systemStatusBarContrastEnforced: false,
            systemNavigationBarContrastEnforced: false),
      );
    });
    return Obx(() {

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.transparent,
            statusBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            systemStatusBarContrastEnforced: false,
            systemNavigationBarContrastEnforced: false),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          // ),
          body: logic.currentState.value == "no-internet"
              ? const NoInternetScreen()
              : logic.currentState.value == "error"
              ? const WarningScreen()
              : SplashLogo(imageUrl: widget.imageUrl,),
          bottomNavigationBar: logic.currentState.value == "continue" ? SafeArea(
            child: Wrap(
              children: const [
                SpinKitThreeBounce(
                  color: AppColors.appTextColor,
                  // color: Colors.black,
                  size: 23.0,
                ),
              ],
            ),
          ) : const SizedBox.shrink(),
        ),
      );
    });
  }
}