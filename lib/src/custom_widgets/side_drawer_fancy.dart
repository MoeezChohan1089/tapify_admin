import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global_controllers/app_config/config_controller.dart';
import '../modules/auth/logic.dart';
import '../modules/auth/view.dart';
import '../modules/bottom_nav_bar/logic.dart';
import '../modules/category/view.dart';
import '../modules/category/view_category_products.dart';
import '../modules/order/view.dart';
import '../modules/profile/logic.dart';
import '../modules/profile/view.dart';
import '../modules/recently_viewed/view.dart';
import '../modules/search/view.dart';
import '../modules/wishlist/view.dart';
import '../utils/constants/assets.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/margins_spacnings.dart';

class FancyDrawerContent extends StatelessWidget {
  FancyDrawerContent({
    super.key,
  });

  final AppConfig appConfig = AppConfig.to;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,
                  vertical: pageMarginVertical),
              child: Container(
                  margin: const EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      BottomNavBarLogic.to.advancedDrawerController
                          .hideDrawer();
                    },
                    icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable:
                      BottomNavBarLogic.to.advancedDrawerController,
                      builder: (context, value, _) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: value.visible
                              ? Icon(
                            Icons.close,
                            size: 26,
                            key: ValueKey<bool>(value.visible),
                          )
                              : SvgPicture.asset(
                            Assets.icons.menuIcon,
                            height: 15.h,
                          ),

                          // Icon(
                          //   value.visible ? Icons.clear : Icons.menu,
                          //   key: ValueKey<bool>(value.visible),
                          // ),
                        );
                      },
                    ),
                  )),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
            //   child: Container(
            //     width: 128.0.w,
            //     height: 50.0.h,
            //     margin: const EdgeInsets.only(
            //       top: 24.0,
            //       bottom: 30,
            //     ),
            //     child: SvgPicture.asset(
            //       Assets.icons.appLogoIcon,
            //       height: 40.h,
            //       color: AppColors.customBlackTextColor,
            //     ),
            //   ),
            // ),

            Obx(() {
              print("log of app config: ${appConfig.quickActionWidgetList
                  .value[0]['name']}");
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                    List.generate(
                        appConfig.menuWidgetsList.value.length, (index) {
                      final menuItem = appConfig.menuWidgetsList.value[index];
                      final settings = menuItem["settings"];

                      if (menuItem.containsKey("subItems")) {
                        var isExpanded = false.obs;

                        return Obx(() {
                          return Column(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  // setState(() {
                                  HapticFeedback.lightImpact();
                                  isExpanded.value = !isExpanded.value;
                                  // });
                                },
                                child: _buildHeaderRow(
                                    context, settings, isExpanded.value),
                              ),
                              if (isExpanded.isTrue)
                                ..._buildSubMenuItems(menuItem["subItems"]),
                            ],
                          );
                        });
                      } else {
                        return GestureDetector(
                          onTap: () async {
                            HapticFeedback.lightImpact();
                            print("tapping on it");

                            // Handle sub-menu item tap event
                            if (menuItem["type"] == "search") {
                              Get.to(() => SearchPage());
                            }
                            else if (RegExp(r'\d').hasMatch(
                                menuItem["type"].toString())) {
                              Get.to(() =>
                                  CategoryProducts(
                                    collectionID: "gid://shopify/Collection/${menuItem["type"]}",
                                    categoryName: menuItem["title"] ?? "",
                                  ));
                            } else if (menuItem["type"] == "my account") {
                              BottomNavBarLogic.to.currentPageIndex.value = 3;
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              BottomNavBarLogic.to.advancedDrawerController
                                  .hideDrawer();
                            } else if (menuItem["type"] == "recently viewed") {
                              Get.to(() => RecentlyViewedPage());
                            } else {
                              print("else running tapping on it");
                            }
                          },
                          child: _buildMenuItemRow(settings),
                        );
                      }
                    }),
                  ),
                ),
              );
            }),

            ///------ Log Out and Social Media Icons Row
            // LocalDatabase.to.box.read('customerAccessToken') != null ? ListTile(
            //   onTap: () {
            //     HapticFeedback.lightImpact();
            //     final logic = Get.put(ProfileLogic());
            //     logic.signOutUser(context: context);
            //   },
            //   title:
            Column(
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //
                //   ),
                // )
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: pageMarginHorizontal * 3.5),
                    child: Divider(color: AppColors.appTextColor,)),
                Align(
                  alignment: Alignment.center,
                  child: Obx(() {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          appConfig.quickActionWidgetList.value.length, (
                          index) {
                        var currentItem = appConfig.quickActionWidgetList
                            .value[index];

                        if (currentItem['display']) {
                          if (currentItem['type'] != null) {
                            return GestureDetector(
                              onTap: () async {
                                if (currentItem['type'] == 'email' &&
                                    currentItem['value'] != null) {
                                  final Uri params = Uri(
                                    scheme: 'mailto',
                                    path: currentItem['value'],
                                    query: 'subject=Tapday Support Team',
                                  );
                                  launchUrl(params);
                                } else if (currentItem['type'] == 'phone' &&
                                    currentItem['value'] != null) {
                                  final url = 'tel:${currentItem['value']}';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                }
                              },
                              child: (index + 1 < appConfig.quickActionWidgetList.value.length &&
                                  appConfig.quickActionWidgetList.value[index + 1]['display'] != false) ? Text(
                                "${currentItem['type']}  -  ".capitalize!,
                                style: context.text.bodyMedium!.copyWith(
                                    color: AppColors.appTextColor),
                              ): Text(
                                "${currentItem['type']}".capitalize!,
                                style: context.text.bodyMedium!.copyWith(
                                    color: AppColors.appTextColor),
                              ),
                            );

                          }
                          else {
                            return const SizedBox.shrink();
                          }
                        } else {
                          return const SizedBox.shrink();
                        }

                      }),
                      // children: [
                      // appConfig.quickActionWidgetList.value[0]['email'].isNotEmpty?
                      //  appConfig.quickActionWidgetList.value[0]['display'] != false? appConfig.quickActionWidgetList.value[0]['type'] != null? GestureDetector(
                      //    onTap: () async{
                      //      if(appConfig.quickActionWidgetList.value[0]['type'] == 'email'){
                      //        final Uri params = Uri(
                      //          scheme: 'mailto',
                      //          path: appConfig.quickActionWidgetList.value[0]['value'] ?? "",
                      //          query:
                      //          'subject=Tapday Support Team', //add subject and body here
                      //        );
                      //        launchUrl(params);
                      //      }else{
                      //        final url = 'tel:${appConfig.quickActionWidgetList.value[0]['value']}';
                      //        if (await canLaunch(url)) {
                      //      await launch(url);
                      //      } else {
                      //      throw 'Could not launch $url';
                      //      }
                      //      }
                      //    },
                      //    child: Text(
                      //      "${appConfig.quickActionWidgetList.value[0]['type']}",
                      //      style: context.text.bodyMedium!.copyWith(color: Colors.black),
                      //    ),
                      //  ):const SizedBox.shrink():const SizedBox.shrink(),
                      //  // :SizedBox(),
                      //  10.widthBox,
                      //  Text(
                      //    "-",
                      //    style: context.text.bodyMedium!.copyWith(color: Colors.black),
                      //  ),
                      //  10.widthBox,
                      //  appConfig.quickActionWidgetList.value[1]['display'] != false? appConfig.quickActionWidgetList.value[1]['type'] != null? GestureDetector(
                      //    onTap: () async{
                      //      if(appConfig.quickActionWidgetList.value[1]['type'] == 'email'){
                      //        final Uri params = Uri(
                      //          scheme: 'mailto',
                      //          path: appConfig.quickActionWidgetList.value[1]['value'] ?? "",
                      //          query:
                      //          'subject=Tapday Support Team', //add subject and body here
                      //        );
                      //        launchUrl(params);
                      //      }else{
                      //        final url = 'tel:${appConfig.quickActionWidgetList.value[1]['value']}';
                      //        if (await canLaunch(url)) {
                      //          await launch(url);
                      //        } else {
                      //          throw 'Could not launch $url';
                      //        }
                      //      }
                      //    },
                      //    child: Text(
                      //      "${appConfig.quickActionWidgetList.value[1]['type']}",
                      //      style: context.text.bodyMedium!.copyWith(color: Colors.black),
                      //    ),
                      //  ):const SizedBox.shrink(): const SizedBox.shrink(),
                      // ],
                    );
                  }),
                ),
              ],
            ),
            //   horizontalTitleGap: 12.w,
            //   leading: SvgPicture.asset(
            //     Assets.icons.logOutIcon,
            //     height: 26,
            //   ),
            // ):ListTile(
            //   onTap: () {
            //     Get.to(()=> const AuthPage());
            //   },
            //   title: Text(
            //     "Login",
            //     style: context.text.bodyLarge!.copyWith(color: Colors.red),
            //   ),
            //   horizontalTitleGap: 12.w,
            //   leading: SvgPicture.asset(
            //     Assets.icons.logOutIcon,
            //     height: 26,
            //   ),
            // ),
            // 4.heightBox,
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       InkWell(
            //         onTap: () {},
            //         borderRadius: BorderRadius.circular(100),
            //         child: Container(
            //           height: 32,
            //           width: 32,
            //           padding: const EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               border: Border.all(
            //                 color: Colors.black,
            //                 width: 1,
            //               )),
            //           child: SvgPicture.asset(
            //             Assets.icons.facebookIcon,
            //           ),
            //         ),
            //       ),
            //       14.widthBox,
            //       InkWell(
            //         onTap: () {},
            //         borderRadius: BorderRadius.circular(100),
            //         child: Container(
            //           height: 32,
            //           width: 32,
            //           padding: const EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               border: Border.all(
            //                 color: Colors.black,
            //                 width: 1,
            //               )),
            //           child: SvgPicture.asset(Assets.icons.instaIcon),
            //         ),
            //       ),
            //       14.widthBox,
            //       InkWell(
            //         onTap: () {},
            //         borderRadius: BorderRadius.circular(100),
            //         child: Container(
            //             height: 32,
            //             width: 32,
            //             padding: const EdgeInsets.all(8),
            //             decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 border: Border.all(
            //                   color: Colors.black,
            //                   width: 1,
            //                 )),
            //             child: SvgPicture.asset(Assets.icons.linkedinIcon)),
            //       ),
            //       14.widthBox,
            //       InkWell(
            //         onTap: () {},
            //         borderRadius: BorderRadius.circular(100),
            //         child: Container(
            //           height: 32,
            //           width: 32,
            //           padding: const EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               border: Border.all(
            //                 color: Colors.black,
            //                 width: 1,
            //               )),
            //           child: SvgPicture.asset(Assets.icons.twitterIcon),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // 20.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context, Map<String, dynamic> settings,
      bool isExpanded) {
    final titleAlignment = _getTitleAlignment(settings);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: pageMarginVertical, horizontal: pageMarginHorizontal),
      child: Row(
        mainAxisAlignment: titleAlignment,
        children: [
          _buildSvgIcon(settings["icon"] == "show"
              ? settings["path"]
              : settings["custom"], settings["titleSize"] == "small"
              ? 20.sp
              : (settings["titleSize"] == "medium" ? 24.sp : 28.sp)),
          // _buildSvgIcon(settings["path"], isExpanded ? 16.0 : 26.0),
          const SizedBox(width: 12.0),
          Text(
            settings["title"],
            style: _getTitleStyle(settings),
          ),
          const Spacer(),
          Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemRow(Map<String, dynamic> settings) {
    final titleAlignment = _getTitleAlignment(settings);

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: pageMarginVertical, horizontal: pageMarginHorizontal),
      child: Row(
        mainAxisAlignment: titleAlignment,
        children: [
          _buildSvgIcon(settings["icon"] == "show"
              ? settings["path"]
              : settings["custom"], settings["titleSize"] == "small"
              ? 15.sp
              : (settings["titleSize"] == "medium" ? 18.sp : 22.sp)),
          // _buildSvgIcon(settings["path"], settings["titleSize"] == "small" ? 20.sp : (settings["titleSize"] ==  "medium" ? 24.sp : 28.sp)),
          const SizedBox(width: 12.0),
          Text(
            settings["title"],
            style: _getTitleStyle(settings),
          ),
        ],
      ),
    );
  }

  Widget _buildSvgIcon(String path, double size) {
    return SvgPicture.network(
      path,
      height: size,
      width: size,
      color: AppColors.customBlackTextColor,
      fit: BoxFit.contain,
    );
  }

  List<Widget> _buildSubMenuItems(List<dynamic> subItems) {
    return List.generate(subItems.length, (index) {
      final subMenuItem = subItems[index];
      final settings = subMenuItem["settings"];

      return GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
        },
        child: _buildMenuItemRow(settings),
      );
    });
  }

  MainAxisAlignment _getTitleAlignment(Map<String, dynamic> settings) {
    switch (settings["titleAlignment"]) {
      case "left":
        return MainAxisAlignment.start;
      case "center":
        return MainAxisAlignment.center;
      case "right":
        return MainAxisAlignment.end;
      default:
        return MainAxisAlignment.start;
    }
  }

  TextStyle _getTitleStyle(Map<String, dynamic> settings) {
    final titleSize = settings["titleSize"];
    final fontSize =
    titleSize == "small" ? 14.sp : (titleSize == "medium" ? 17.sp : 20.sp);

    return TextStyle(
      fontSize: fontSize,
      // Add other desired styles
    );
  }
}