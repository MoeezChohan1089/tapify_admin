import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';

import '../auth/view.dart';
import '../home/view.dart';
import 'state.dart';

class AdminSplashLogic extends GetxController {
  static AdminSplashLogic get to => Get.find();

  final AdminSplashState state = AdminSplashState();

  RxString currentState = "continue".obs;

  @override
  void onInit() {
    super.onInit();
    myNewNavigator();
  }

  myNewNavigator() async {
    currentState.value = "continue";

    //--- check internet
    if (await checkInternetAccess()) {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (LocalDatabase.to.box.read("adminSignedInToken") != null &&
          LocalDatabase.to.box.read("isViewingWithQR") == false) {
        Get.off(() => AdminHomePage());
      } else {
        Get.off(() => AdminSignInPage(isRedirectToWeb: false));
      }
    } else {
      currentState.value = "no-internet";
    }
  }

  ///----- Check internet connection
  Future<bool> checkInternetAccess() async {
    try {
      final response = await Dio().head('https://www.google.com');
      return response.statusCode == 200; // Internet access is available
    } catch (e) {
      return false; // Unable to access the internet
    }
  }
}
