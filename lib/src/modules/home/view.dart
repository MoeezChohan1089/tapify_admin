// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:shopify_flutter/enums/src/sort_key_product.dart';
// import 'package:shopify_flutter/models/src/product/product.dart';
// import 'package:shopify_flutter/shopify/src/shopify_store.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:tapify_admin/src/global_controllers/app_config/config_controller.dart';
// import 'package:tapify_admin/src/modules/home/components/search_bar.dart';
// import 'package:tapify_admin/src/utils/constants/assets.dart';
// import 'package:tapify_admin/src/utils/extensions.dart';
//
// import '../../global_controllers/database_controller.dart';
// import '../../order/view.dart';
// import '../../utils/constants/colors.dart';
// import '../../utils/constants/margins_spacnings.dart';
// import '../auth/view.dart';
// import '../auth/view_sign_up.dart';
// import '../bottom_nav_bar/view.dart';
// import '../cart/logic.dart';
// import '../cart/view.dart';
// import '../category/view.dart';
// import '../product_detail/components/addtocartButton.dart';
// import '../product_detail/components/containerDivider.dart';
// import '../product_detail/components/free_shipping_box.dart';
// import '../product_detail/components/products_images_carousel.dart';
// import '../product_detail/components/quantity_control.dart';
// import '../product_detail/components/recommended_products.dart';
// import '../product_detail/components/reviews.dart';
// import '../product_detail/components/selectColor.dart';
// import '../product_detail/components/variants_selector.dart';
// import '../product_detail/components/size_and_color_dropdown.dart';
// import '../product_detail/components/title_and_price.dart';
// import '../product_detail/logic.dart';
// import '../profile/logic.dart';
// import '../profile/view.dart';
// import '../wishlist/view.dart';
// import 'components/category_list.dart';
// import 'components/circle_product_list.dart';
// import 'components/count_down_timer.dart';
// import 'components/custom_divider.dart';
// import 'components/discount_banner.dart';
// import 'components/grid_view_by_category.dart';
// import 'components/grid_view_simple.dart';
// import 'components/products_slide_show.dart';
// import 'components/marquee_text.dart';
// import 'components/product_slider.dart';
// import 'components/products_carousel.dart';
// import 'components/products_gallery.dart';
// import 'components/single_image.dart';
// import 'components/single_video.dart';
// import 'components/title_text.dart';
// import 'logic.dart';
// import 'models/model_home_ui_settings.dart';
//
// // class HomePage extends StatefulWidget {
// //   HomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //
// //
// //   PanelController controller = PanelController();
// //   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// //   final logic = Get.put(HomeLogic());
// //
// //   final state = Get.find<HomeLogic>().state;
// //   final _advancedDrawerController = AdvancedDrawerController();
// //   final logic1 = Get.put(ProductDetailLogic());
// //
// //   final state1 = Get.find<ProductDetailLogic>().state;
// //   final logic2 = Get.put(ProfileLogic());
// //
// //   void _handleMenuButtonPressed() {
// //     _advancedDrawerController.showDrawer();
// //   }
// //
// //   late ScrollController scrollController;
// //   double scrollStartPosition = 0.0;
// //   int sideDrawerType = 1;
// //   //---- 1 for fancy 2 for simple
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     logic.getHomePageProductsInfo();
// //     scrollController = ScrollController();
// //     scrollController.addListener(_scrollListener);
// //   }
// //
// //   @override
// //   void dispose() {
// //     scrollController.removeListener(_scrollListener);
// //     scrollController.dispose();
// //     super.dispose();
// //   }
// //   _scrollListener() {
// //     // If the scroll starts at the top of the scroll view
// //     if (scrollController.position.atEdge &&
// //         scrollController.position.pixels == 0) {
// //       scrollStartPosition = scrollController.position.userScrollDirection ==
// //               ScrollDirection.forward
// //           ? scrollController.offset
// //           : 0.0;
// //       print("Trying");
// //     }
// //
// //     // If a scroll upward is detected while at the top
// //     if (scrollController.position.userScrollDirection ==
// //             ScrollDirection.forward &&
// //         scrollController.offset <= scrollStartPosition) {
// //       print("Trying to scroll upwards while at the top");
// //       // controller.close();
// //       // Call your function here
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SlidingUpPanel(
// //       borderRadius: const BorderRadius.only(
// //           topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
// //       controller: controller,
// //       minHeight: 0,
// //       maxHeight: MediaQuery.of(context).size.height - 50,
// //       backdropEnabled: true,
// //       panel: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: SafeArea(
// //           child: Scaffold(
// //             body: Column(
// //               children: [
// //                 Align(
// //                   alignment: Alignment.center,
// //                   child: Container(
// //                     padding: const EdgeInsets.all(2),
// //                     margin: const EdgeInsets.only(bottom: 10),
// //                     width: 50,
// //                     decoration: BoxDecoration(
// //                         borderRadius: BorderRadius.circular(12),
// //                         color: Theme.of(context).hintColor),
// //                   ),
// //                 ),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: Align(
// //                         alignment: Alignment.bottomLeft,
// //                         child: IconButton(
// //                           onPressed: () {
// //                             controller.close();
// //                           },
// //                           icon: const Icon(Icons.keyboard_arrow_down_outlined),
// //                         ),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Center(
// //                         child: Text("product detail".toUpperCase(),
// //                             style: context.text.bodyLarge),
// //                       ),
// //                     ),
// //                     Expanded(
// //                       child: Align(
// //                         alignment: Alignment.bottomRight,
// //                         child: Stack(
// //                           children: [
// //                             IconButton(
// //                               onPressed: () {},
// //                               icon: SvgPicture.asset(
// //                                 Assets.icons.cartIcon,
// //                                 height: 25,
// //                               ),
// //                             ),
// //                             Positioned(
// //                               bottom: 0,
// //                               left: 5,
// //                               child: Container(
// //                                 padding: const EdgeInsets.all(6),
// //                                 decoration: const BoxDecoration(
// //                                   shape: BoxShape.circle,
// //                                   color: Colors.red,
// //                                 ),
// //                                 child: Text(
// //                                   '1',
// //                                   style: context.text.bodyLarge
// //                                       ?.copyWith(color: Colors.white),
// //                                 ),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 Expanded(
// //                   child: SingleChildScrollView(
// //                     controller: scrollController,
// //                     child: Column(
// //                       children: const [
// //                         // ProductImagesCarousel(),
// //                         // // TitleAndPrice(),
// //                         // SizeDropDown(),
// //                         // SelectColor(),
// //                         // SizeAndColor(),
// //                         // CartButton(title: "ADD TO CART",),
// //                         // QuantityControl(),
// //                         // ContainerDivider(),
// //                         // ReviewList(),
// //                         // 22.heightBox,
// //                         // EnjoyShipping(),
// //                         // RecommendedProducts(),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       body: AdvancedDrawer(
// //         backdrop: Container(
// //           width: double.infinity,
// //           height: double.infinity,
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [Colors.white, Colors.grey.shade300],
// //             ),
// //           ),
// //         ),
// //         controller: _advancedDrawerController,
// //         animationCurve: Curves.easeInOut,
// //         animationDuration: const Duration(milliseconds: 300),
// //         animateChildDecoration: true,
// //         rtlOpening: false,
// //         disabledGestures: false,
// //         childDecoration: const BoxDecoration(
// //           borderRadius: BorderRadius.all(Radius.circular(16)),
// //         ),
// //         drawer: SafeArea(
// //           child: ListTileTheme(
// //             textColor: Colors.white,
// //             iconColor: Colors.white,
// //             child: Column(
// //               mainAxisSize: MainAxisSize.max,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: EdgeInsets.symmetric(
// //                       horizontal: pageMarginHorizontal,
// //                       vertical: pageMarginVertical),
// //                   child: Container(
// //                       margin: const EdgeInsets.only(
// //                         top: 24.0,
// //                       ),
// //                       child: IconButton(
// //                         onPressed: () {
// //                           _advancedDrawerController.hideDrawer();
// //                         },
// //                         icon: ValueListenableBuilder<AdvancedDrawerValue>(
// //                           valueListenable: _advancedDrawerController,
// //                           builder: (_, value, __) {
// //                             return AnimatedSwitcher(
// //                               duration: const Duration(milliseconds: 250),
// //                               child: value.visible
// //                                   ? Icon(
// //                                       Icons.close,
// //                                       size: 26,
// //                                       key: ValueKey<bool>(value.visible),
// //                                     )
// //                                   : SvgPicture.asset(
// //                                       Assets.icons.menuIcon,
// //                                       height: 15,
// //                                     ),
// //
// //                               // Icon(
// //                               //   value.visible ? Icons.clear : Icons.menu,
// //                               //   key: ValueKey<bool>(value.visible),
// //                               // ),
// //                             );
// //                           },
// //                         ),
// //                       )),
// //                 ),
// //                 Padding(
// //                   padding:
// //                       EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
// //                   child: Container(
// //                     width: 128.0,
// //                     height: 50.0,
// //                     margin: const EdgeInsets.only(
// //                       top: 24.0,
// //                       bottom: 30,
// //                     ),
// //                     child: SvgPicture.asset(
// //                       Assets.icons.appLogoIcon,
// //                       height: 40,
// //                       color: AppColors.customBlackTextColor,
// //                     ),
// //                   ),
// //                 ),
// //                 ListTile(
// //                   onTap: () {},
// //                   leading: Padding(
// //                     padding: const EdgeInsets.only(bottom: 8),
// //                     child: SvgPicture.asset(
// //                       Assets.icons.homeIcon,
// //                       height: 26,
// //                       color: AppColors.customBlackTextColor,
// //                     ),
// //                   ),
// //                   horizontalTitleGap: 12.w,
// //                   title: Text(
// //                     'Home',
// //                     style: context.text.bodyLarge,
// //                   ),
// //                 ),
// //                 ListTile(
// //                   onTap: () {
// //                     Get.to(() => CategoryPage());
// //                   },
// //                   leading: Padding(
// //                     padding: const EdgeInsets.only(bottom: 8),
// //                     child: SvgPicture.asset(
// //                       Assets.icons.categoriesIcon,
// //                       height: 26,
// //                       color: AppColors.customBlackTextColor,
// //                     ),
// //                   ),
// //                   horizontalTitleGap: 12.w,
// //                   title: Text(
// //                     'Category',
// //                     style: context.text.bodyLarge,
// //                   ),
// //                 ),
// //                 ListTile(
// //                   onTap: () {
// //                     Get.to(() => WishlistPage());
// //                   },
// //                   leading: Padding(
// //                     padding: const EdgeInsets.only(bottom: 8),
// //                     child: SvgPicture.asset(
// //                       Assets.icons.wishlistIcon,
// //                       height: 26,
// //                       color: AppColors.customBlackTextColor,
// //                     ),
// //                   ),
// //                   horizontalTitleGap: 12.w,
// //                   title: Text(
// //                     'Wishlist',
// //                     style: context.text.bodyLarge,
// //                   ),
// //                 ),
// //                 ListTile(
// //                   onTap: () {
// //                     Navigator.push(context,
// //                         MaterialPageRoute(builder: (context) => AuthPage()));
// //                   },
// //                   leading: Padding(
// //                     padding: const EdgeInsets.only(bottom: 8),
// //                     child: SvgPicture.asset(
// //                       Assets.icons.userProfileIcon,
// //                       height: 26,
// //                       color: AppColors.customBlackTextColor,
// //                     ),
// //                   ),
// //                   horizontalTitleGap: 12.w,
// //                   title: Text(
// //                     'Account',
// //                     style: context.text.bodyLarge,
// //                   ),
// //                 ),
// //                 ListTile(
// //                   title: Text(
// //                     "My Orders",
// //                     style: context.text.bodyLarge,
// //                   ),
// //                   horizontalTitleGap: 12.w,
// //                   leading: Padding(
// //                     padding: const EdgeInsets.only(bottom: 8),
// //                     child: SvgPicture.asset(
// //                       Assets.icons.orderBagIcon,
// //                       height: 26,
// //                     ),
// //                   ),
// //                   onTap: () {
// //                     Get.to(() => OrderPage());
// //                   },
// //                 ),
// //                 const Spacer(),
// //                 ListTile(
// //                   onTap: () {
// //                     logic2.signOutUser(context: context);
// //                   },
// //                   title: Text(
// //                     "Logout",
// //                     style:
// //                         context.text.bodyLarge!.copyWith(color: Colors.red),
// //                   ),
// //                   horizontalTitleGap: 12.w,
// //                   leading: SvgPicture.asset(
// //                     Assets.icons.logOutIcon,
// //                     height: 26,
// //                   ),
// //                 ),
// //                 4.heightBox,
// //
// //                 ///------ Social Media Icons Row
// //                 Padding(
// //                   padding:
// //                       EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     children: [
// //                       InkWell(
// //                         onTap: () {},
// //                         borderRadius: BorderRadius.circular(100),
// //                         child: Container(
// //                           height: 32,
// //                           width: 32,
// //                           padding: const EdgeInsets.all(8),
// //                           decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               border: Border.all(
// //                                 color: Colors.black,
// //                                 width: 1,
// //                               )),
// //                           child: SvgPicture.asset(
// //                             Assets.icons.facebookIcon,
// //                           ),
// //                         ),
// //                       ),
// //                       14.widthBox,
// //                       InkWell(
// //                         onTap: () {},
// //                         borderRadius: BorderRadius.circular(100),
// //                         child: Container(
// //                           height: 32,
// //                           width: 32,
// //                           padding: const EdgeInsets.all(8),
// //                           decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               border: Border.all(
// //                                 color: Colors.black,
// //                                 width: 1,
// //                               )),
// //                           child: SvgPicture.asset(Assets.icons.instaIcon),
// //                         ),
// //                       ),
// //                       14.widthBox,
// //                       InkWell(
// //                         onTap: () {},
// //                         borderRadius: BorderRadius.circular(100),
// //                         child: Container(
// //                             height: 32,
// //                             width: 32,
// //                             padding: const EdgeInsets.all(8),
// //                             decoration: BoxDecoration(
// //                                 shape: BoxShape.circle,
// //                                 border: Border.all(
// //                                   color: Colors.black,
// //                                   width: 1,
// //                                 )),
// //                             child:
// //                                 SvgPicture.asset(Assets.icons.linkedinIcon)),
// //                       ),
// //                       14.widthBox,
// //                       InkWell(
// //                         onTap: () {},
// //                         borderRadius: BorderRadius.circular(100),
// //                         child: Container(
// //                           height: 32,
// //                           width: 32,
// //                           padding: const EdgeInsets.all(8),
// //                           decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               border: Border.all(
// //                                 color: Colors.black,
// //                                 width: 1,
// //                               )),
// //                           child: SvgPicture.asset(Assets.icons.twitterIcon),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 20.heightBox,
// //               ],
// //             ),
// //           ),
// //         ),
// //         child: HomePageView(
// //             controller: controller,
// //           leadingIcon: IconButton(
// //             onPressed: _handleMenuButtonPressed,
// //             icon: ValueListenableBuilder<AdvancedDrawerValue>(
// //               valueListenable: _advancedDrawerController,
// //               builder: (_, value, __) {
// //                 return AnimatedSwitcher(
// //                   duration: const Duration(milliseconds: 250),
// //                   child: value.visible
// //                       ? Icon(
// //                     Icons.arrow_back_ios,
// //                     key: ValueKey<bool>(value.visible),
// //                   )
// //                       : SvgPicture.asset(
// //                     Assets.icons.menuIcon,
// //                     height: 15,
// //                   ),
// //
// //                   // Icon(
// //                   //   value.visible ? Icons.clear : Icons.menu,
// //                   //   key: ValueKey<bool>(value.visible),
// //                   // ),
// //                 );
// //               },
// //             ),
// //           )
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// class HomePageViewBuilder extends StatelessWidget {
//   final Widget leadingIcon;
//   final PanelController controller;
//
//   const HomePageViewBuilder({
//     super.key,
//     required this.leadingIcon,
//     required this.controller,
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           scrolledUnderElevation: 0,
//           centerTitle: true,
//           title: Text(
//             "Tapify".toUpperCase(),
//             style:
//                 TextStyle(fontFamily: 'Sofia Pro Regular', fontSize: 18.sp),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               if(bottomNav.isFancyDrawer.isTrue){
//                 bottomNav.advancedDrawerController.showDrawer();
//               } else {
//                 bottomNav.navScaffoldKey.currentState?.openDrawer();
//               }
//             },
//             icon: ValueListenableBuilder<AdvancedDrawerValue>(
//               valueListenable: bottomNav.advancedDrawerController,
//               builder: (_, value, __) {
//                 return AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 250),
//                   child: value.visible
//                       ? Icon(
//                     Icons.arrow_back_ios,
//                     key: ValueKey<bool>(value.visible),
//                   )
//                       : SvgPicture.asset(
//                     Assets.icons.menuIcon,
//                     height: 15,
//                   ),
//                 );
//               },
//             ),
//           ),
//           actions: [
//             GetBuilder<CartLogic>(builder: (cartLogic) {
//               return Stack(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       Get.to(() => CartPage());
//                     },
//                     icon: SvgPicture.asset(
//                       Assets.icons.cartIcon,
//                       height: 25,
//                     ),
//                   ),
//                   cartLogic.currentCart != null
//                       ? Positioned(
//                           bottom: 0,
//                           left: 5,
//                           child: Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.red,
//                             ),
//                             child: Text(
//                               "${cartLogic.currentCart?.lineItems.length}",
//                               style: context.text.bodyMedium?.copyWith(
//                                   color: Colors.white, fontSize: 13.sp),
//                             ),
//                           ),
//                         )
//                       : const SizedBox.shrink(),
//                 ],
//               );
//             }),
//           ],
//         ),
//
//         ///----- Implement Home UI dynamic here
//         body: ListView.builder(
//           padding: EdgeInsets.only(bottom: 50.h),
//           itemCount: dummyHomeData.length,
//           // itemCount: AppConfig.to.homeWidgetsList.length,
//           itemBuilder: (BuildContext context, int index) {
//             // final widgetData = AppConfig.to.homeWidgetsList[index];
//             // final settings = widgetData["settings"];
//
//             final widgetData = dummyHomeData[index];
//             final settings = widgetData.listOfWidgetsSettings["settings"];
//
//
//             final widgetMap = {
//               'search': () => SearchBarContainer(settings: settings),
//               'divider': () => CustomDivider(divider: settings),
//               'marquee': () => AnimatedMarqueeText(settings: settings),
//               'product': () => CircularProductList(
//                   control: controller, settings: settings),
//               'title': () => TitleText(settings: settings),
//               'timer': () => CountDownTimer(settings: settings),
//               'gallery': () => ProductsGallery(settings: settings),
//               'category': () => CategoryList(settings: settings),
//               'carousel': () => ProductsCarousel(settings: settings),
//               'image': () => SingleImageWidget(settings: settings),
//               'slideShow': () => ProductsSlideShow(settings: settings),
//               'video': () => SingleVideoView(settings: settings),
//               'slider': () => ProductSlider(settings: settings),
//               'grid': () => ProductGridViewSimple(settings: settings),
//             };
//
//             final widgetType = widgetData.listOfWidgetsSettings["type"];
//             // final widgetType = widgetData["type"];
//             final widgetBuilder =
//                 widgetMap[widgetType] ?? () => const SizedBox.shrink();
//             return widgetBuilder();
//           },
//         ),
//     );
//   }
// }