import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';

import '../../custom_widgets/side_drawer_fancy.dart';
import '../../custom_widgets/side_drawer_simple.dart';
import '../../global_controllers/database_controller.dart';
// import '../../order/view.dart';
import '../../utils/constants/colors.dart';
import '../category/view.dart';
import '../home/view_home.dart';
import '../profile/view.dart';
import '../profile/view_guest.dart';
import '../wishlist/view.dart';
import 'components/widget_bottom_menu.dart';
import 'logic.dart';

class BottomNavBarPage extends StatelessWidget {
  BottomNavBarPage({Key? key}) : super(key: key);

  final logic = Get.put(BottomNavBarLogic());
  final state = Get.find<BottomNavBarLogic>().state;

  @override
  Widget build(BuildContext context) {
    myNavBuildFunction();
    return WillPopScope(
      onWillPop: logic.onWillPop,
      child: Obx(() {
        return logic.isFancyDrawer.isTrue
            ? AdvancedDrawer(
          key: logic.navScaffoldKey,
          backdrop: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey.shade300],
              ),
            ),
          ),
          controller: logic.advancedDrawerController,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          animateChildDecoration: true,
          rtlOpening: false,
          disabledGestures: false,
          childDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          drawer: FancyDrawerContent(),
          child: Scaffold(
            body: IndexedStack(
              index: logic.currentPageIndex.value,
              children: [
                HomePage(),
                CategoryPage(),
                WishlistPage(),
                LocalDatabase.to.box.read("customerAccessToken") != null
                    ? ProfilePage()
                    : const ProfileWithoutLoginPage(),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 53,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  // color: Colors.yellow,
                    border: Border(
                      top: BorderSide(
                        color: AppColors.appHintColor,
                        width: 0.5,
                      ),
                    )),
                child: Row(
                  children: [
                    BottomNavItem(
                      title: "Home",
                      indexValue: 0,
                      activeIcon: Assets.icons.homeFilled,
                      inActiveIcon: Assets.icons.homeIcon,
                      // onPress: () => ,
                    ),
                    BottomNavItem(
                      title: "Category",
                      indexValue: 1,
                      activeIcon: Assets.icons.categoryFilled,
                      inActiveIcon: Assets.icons.categoriesIcon,
                      // onPress: () => ,
                    ),
                    BottomNavItem(
                      title: "Wishlist",
                      indexValue: 2,
                      activeIcon: Assets.icons.heartFilled,
                      inActiveIcon: Assets.icons.heartOutlined,
                      // onPress: () => ,
                    ),
                    BottomNavItem(
                      title: "Account",
                      indexValue: 3,
                      activeIcon: Assets.icons.userProfileFilled,
                      inActiveIcon: Assets.icons.userProfileIcon,
                      // onPress: () => ,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
            : Scaffold(
          drawer: SideDrawerSimple(
            scaffoldKey: logic.navScaffoldKey,
           ),
          key: logic.navScaffoldKey,
          body: logic.bottomPages(context),
          bottomNavigationBar: Container(
            height: 53,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              // color: Colors.yellow,
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 0.5,
                  ),
                )),
            child: Row(
              children: [
                BottomNavItem(
                  title: "Home",
                  indexValue: 0,
                  activeIcon: Assets.icons.homeFilled,
                  inActiveIcon: Assets.icons.homeIcon,
                  // onPress: () => ,
                ),
                BottomNavItem(
                  title: "Category",
                  indexValue: 1,
                  activeIcon: Assets.icons.categoryFilled,
                  inActiveIcon: Assets.icons.categoriesIcon,
                  // onPress: () => ,
                ),
                BottomNavItem(
                  title: "Wishlist",
                  indexValue: 2,
                  activeIcon: Assets.icons.heartFilled,
                  inActiveIcon: Assets.icons.heartOutlined,
                  // onPress: () => ,
                ),
                BottomNavItem(
                  title: "Account",
                  indexValue: 3,
                  activeIcon: Assets.icons.userProfileFilled,
                  inActiveIcon: Assets.icons.userProfileIcon,
                  // onPress: () => ,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  myNavBuildFunction() async {
    await Future.delayed(const Duration(milliseconds: 500));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.transparent, // Make status bar transparent
      statusBarIconBrightness: Brightness.dark, // Make status bar icons dark
      systemNavigationBarColor: Colors.white, // Set navigation bar color
      systemNavigationBarIconBrightness:
      Brightness.dark, // Navigation bar icons
    ));
  }
}