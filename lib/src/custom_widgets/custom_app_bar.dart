import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify_admin/src/modules/product_detail/logic.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../modules/bottom_nav_bar/logic.dart';
import '../modules/bottom_nav_bar/view.dart';
import '../modules/cart/components/product_added_to_cart_sheet.dart';
import '../modules/cart/components/un_completed_cart_dialog.dart';
import '../modules/cart/logic.dart';
import '../modules/cart/view.dart';
import '../modules/product_detail/api_services.dart';
import '../modules/splash/components/warning.dart';
import '../utils/constants/colors.dart';
import '../utils/skeleton_loaders/shimmerLoader.dart';
import 'local_notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome, showCart, showBack, showMenuIcon;
  final String title;
  final Function? onBackPress;
  final IconData? backIcon;
  final Widget? trailingButton;

  CustomAppBar({super.key,
    this.isHome = false,
    required this.title,
    this.onBackPress,
    this.showCart = true,
    this.showMenuIcon = false,
    this.trailingButton,
    this.backIcon,
    this.showBack = true});

  final bottomNav = BottomNavBarLogic.to;
  final logic = Get.put(ProductDetailLogic());


  void initializeTimezone() {
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.appBordersColor,
              width: .5,
            ),
          ),
        ),
        child: AppBar(
          backgroundColor: AppConfig.to.appbarBGColor.value,
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: true,

          title: isHome
              ? Obx(() {
            return AppConfig.to.homeAppBarLogo.value == ''
                ? Text(
              title.toUpperCase(),
              style:
              context.text.titleSmall?.copyWith(fontSize: 16.sp, color: AppConfig.to.iconCollectionColor.value),
            )
                : SizedBox(
              height: 35.h,
              // color: Colors.red,
              child: ExtendedImage.network(
                AppConfig.to.homeAppBarLogo.value,
                fit: BoxFit.cover,  // ensures that the image scales down if necessary, but not up
                // width: double.infinity,
                cache: true,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 100,
                          height: 70,
                          color: Colors.grey[300],
                        ),
                      );
                    case LoadState.completed:
                      return null; //return null, so it continues to display the loaded image
                    case LoadState.failed:
                      return SvgPicture.asset(
                        Assets.icons.noImageIcon,
                        height: 20,
                        width: 50,
                      );
                    default:
                      return null;
                  }
                },
              ),
            );
          })
              : Text(
            title.toUpperCase(),
            style: context.text.titleSmall?.copyWith(fontSize: 16.sp, color: AppConfig.to.iconCollectionColor.value),
          ),

          ///----- Leading Icon (Drawer Opener / Back Navigator)
          leading: showMenuIcon
              ? IconButton(
            onPressed: () {
              if (bottomNav.isFancyDrawer.isTrue) {
                HapticFeedback.lightImpact();
                bottomNav.advancedDrawerController.showDrawer();
              } else {
                HapticFeedback.lightImpact();
                bottomNav.navScaffoldKey.currentState?.openDrawer();
              }
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: bottomNav.advancedDrawerController,
              builder: (context, value, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: value.visible
                      ? Icon(
                    Icons.arrow_back_ios,
                    color: AppConfig.to.iconCollectionColor.value,
                    key: ValueKey<bool>(value.visible),
                  )
                      : Obx(() {
                    return SvgPicture.asset(
                      Assets.icons.menuIcons[
                      AppConfig.to.menuIconIndex.value],
                      height: 21.h,
                      color: AppConfig.to.iconCollectionColor.value,
                    );
                  }),
                );
              },
            ),
          )
              : showBack
              ? IconButton(
              onPressed: onBackPress != null
                  ? onBackPress!()
                  : () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
              icon: Icon(
                backIcon ?? Icons.arrow_back_ios,
                color: AppConfig.to.iconCollectionColor.value,
                size: backIcon != null ? 28.sp : 22.sp,
              ))
              : const SizedBox.shrink(),

          ///----- Trailing Action Buttons
          actions: [

            ///-------- Chat Message Indicator Icon
            // isHome ? GetBuilder<CartLogic>(builder: (cartLogic) {
            //   return Stack(
            //     children: [
            //       IconButton(
            //         onPressed: () async {
            //
            //         },
            //         icon: Obx(() {
            //           return SvgPicture.asset(
            //             Assets.icons.chatIcons[AppConfig.to.chatIconIndex.value],
            //             color: Colors.black,
            //             // height: 25,
            //           );
            //         }),
            //       ),
            //       // cartLogic.currentCart != null
            //       //     ? Positioned(
            //       //         bottom: 0,
            //       //         left: 5,
            //       //         child: Container(
            //       //           padding: const EdgeInsets.all(6),
            //       //           decoration:  BoxDecoration(
            //       //             shape: BoxShape.circle,
            //       //             color: AppConfig.to.chatColor
            //       //           ),
            //       //           child: Text(
            //       //             "${cartLogic.currentCart?.lineItems.length}",
            //       //             style: context.text.bodyMedium?.copyWith(
            //       //                 color: Colors.white, fontSize: 13.sp),
            //       //           ),
            //       //         ),
            //       //       )
            //       //     : const SizedBox.shrink(),
            //     ],
            //   );
            // }) : const SizedBox.shrink(),

            ///-------- Cart Items Indicator Icon
            trailingButton != null
                ? trailingButton!
                : showCart
                ? GetBuilder<CartLogic>(builder: (cartLogic) {
              initializeTimezone();

              return IconButton(
                onPressed: () {
                  // getProductDetails();
                  // productAddedToCart(context);
                  // unCompletedCartItemDialog();

                  HapticFeedback.lightImpact();
                  Get.to(() => CartPage(),
                      transition: Transition.downToUp,
                      // fullscreenDialog: true,
                      opaque: false,
                      duration:
                      const Duration(milliseconds: 250)
                  );
                  // Get.to(()=>WarningScreen());
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Obx(() {
                      return SvgPicture.asset(
                        Assets.icons.cartIcons[
                        AppConfig.to.cartIconIndex.value],
                        color: AppConfig.to.iconCollectionColor.value,
                        height: 23.h,
                      );
                    }),


                    cartLogic.currentCart != null
                        ? cartLogic.currentCart!.lineItems.isNotEmpty
                        ? Positioned(
                      top: 5,
                      right: 8,
                      child: Obx(() {
                        return Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppConfig.to.cartColor.value,
                          ),
                          child: Text(
                            "${cartLogic.currentCart?.lineItems.length}",
                            style: context.text.bodyMedium
                                ?.copyWith(
                                color: Colors.white,
                                fontSize: 13.sp),
                          ),
                        );
                      }),
                    )
                        : const SizedBox.shrink()
                        : const SizedBox.shrink(),

                  ],
                ),
              );
            })
                : const SizedBox.shrink(),
            // GetBuilder<CartLogic>(builder: (cartLogic) {
            //   return Stack(
            //     children: [
            //       IconButton(
            //         onPressed: () {
            //           Get.to(() => CartPage());
            //         },
            //         icon: SvgPicture.asset(
            //           Assets.icons.cartIcons[AppConfig.to.cartIconIndex],
            //           color: Colors.black,
            //           height: 20,
            //         ),
            //       ),
            //       (cartLogic.currentCart != null ||
            //               cartLogic.currentCart!.lineItems.isNotEmpty)
            //           ? Positioned(
            //               bottom: 0,
            //               left: 5,
            //               child: Container(
            //                 padding: const EdgeInsets.all(5),
            //                 decoration: const BoxDecoration(
            //                   shape: BoxShape.circle,
            //                   color: Colors.red,
            //                 ),
            //                 child: Text(
            //                   "${cartLogic.currentCart?.lineItems.length}",
            //                   style: context.text.bodySmall
            //                       ?.copyWith(color: Colors.white),
            //                 ),
            //               ),
            //             )
            //           : const SizedBox.shrink(),
            //     ],
            //   );
            // }),
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}