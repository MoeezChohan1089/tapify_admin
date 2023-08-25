import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/global_instances.dart';
import 'package:tapify/src/utils/tapday_api_srvices/api_services.dart';

import '../../api_services/shopify_flutter/shopify_flutter.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../global_controllers/database_controller.dart';
import '../../global_controllers/dependency_injection.dart';
import '../../global_controllers/notification_service.dart';
import '../auth/api_services/auth_api_service.dart';
import '../auth/view.dart';
import '../auth/view_forgot_password.dart';
import '../auth/view_sign_up.dart';
import '../bottom_nav_bar/view.dart';
import '../cart/logic.dart';
import '../home/view.dart';
import '../home/view_home.dart';
import 'state.dart';

class SplashLogic extends GetxController {
  static SplashLogic get to => Get.find();
  final SplashState state = SplashState();

  final bool homeWithBottomNav = true;


  RxString currentState = "continue".obs;
  //--- no-internet
  //--- error


  // final cartLogic = Get.put(CartLogic());

  @override
  void onInit() {
    super.onInit();
    myNewNavigator();
  }


  myNewNavigator() async {
    currentState.value = "continue";

    //--- check internet
    if(await checkInternetAccess()) {
      if(await signInStaticUser()) {
        if(await AppConfig.to.jsonApiCall()) {
          await resetShopify();
          await DependencyInjection.initializeAppControllers();
          await AppConfig.to.setupConfigData();
          await Future.delayed(Duration(milliseconds: 500));
          homeWithBottomNav ?  Get.off(() => BottomNavBarPage()) : Get.off(() => const HomePage());
        } else {
          currentState.value = "error";
        }
      } else {
        currentState.value = "error";
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


  ///------ Sign in the default user
  Future<bool>  signInStaticUser() async {
    if(LocalDatabase.to.box.read("staticUserAuthToken") == null) {
      return await staticUserAPI(email: TapDay.adminEmail, password: TapDay.adminPassword);
    } else {
      return true;
    }
  }








}