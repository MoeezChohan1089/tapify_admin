import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import '../../global_controllers/database_controller.dart';
import '../category/view.dart';
import '../category/view_2.dart';
import '../home/view_home.dart';
import '../profile/view.dart';
import '../profile/view_guest.dart';
import '../wishlist/view.dart';
import 'components/exit_ensuring_dialogue.dart';
import 'state.dart';

class BottomNavBarLogic extends GetxController {
  static BottomNavBarLogic get to => Get.find();
  final BottomNavBarState state = BottomNavBarState();

  final advancedDrawerController = AdvancedDrawerController();
  final GlobalKey<ScaffoldState> navScaffoldKey = GlobalKey();


  RxInt currentPageIndex = 0.obs;
  RxBool isFancyDrawer = true.obs;    //---- 1 for fancy 2 for Simple


  Widget bottomPages(
      BuildContext context,
      ) {
    switch (currentPageIndex.value) {
      case 0:
        {
          return const HomePage();
        }
      case 1:
        {
          return CategoryPage();
        }
      case 2:
        {
          return WishlistPage();
        }
      case 3:
        {

          return LocalDatabase.to.box.read("customerAccessToken") != null? ProfilePage() : const ProfileWithoutLoginPage();
        }
      default:
        {
          return const HomePage();
        }
    }
  }

  Future<bool> onWillPop() async {
    if (currentPageIndex.value != 0) {
      currentPageIndex.value = 0;
      return false;
    } else {
      final value = await showExitEnsureDialog();
      if (value != null) {
        return Future.value(value);
      } else {
        return Future.value(false);
      }
    }
  }

  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

}