// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:tapify/src/modules/cart/view.dart';
// import 'package:tapify/src/utils/constants/assets.dart';
//
// import '../side_drawer_simple.dart';
// import 'logic.dart';
//
// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   final logic = Get.put(HomeLogic());
//   final state = Get.find<HomeLogic>().state;
//
//   final GlobalKey<ScaffoldState> _homeScaffoldKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: SideDrawerSimple(
//         scaffoldKey: _homeScaffoldKey,
//       ),
//       key: _homeScaffoldKey,
//       appBar: AppBar(
//         scrolledUnderElevation: 0,
//         centerTitle: true,
//         title: Text(
//           "Tapify".toUpperCase(),
//           style: TextStyle(fontFamily: 'Sofia Pro Regular', fontSize: 18.sp),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             _homeScaffoldKey.currentState?.openDrawer();
//           },
//           icon: SvgPicture.asset(
//             Assets.icons.menuIcon,
//             height: 18,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => CartPage()));
//             },
//             icon: SvgPicture.asset(
//               Assets.icons.cartIcon,
//               height: 25,
//             ),
//           ),
//         ],
//       ),
//       // body: logic.getDynamicHomeView(),
//       // body: SingleChildScrollView(
//       //   child: Column(
//       //     children: [
//       //       SearchBarContainer(),
//       //       CustomDivider(),
//       //       TitleText(),
//       //       CountDownTimer(),
//       //       AnimatedMarqueeText(),
//       //       CircularProductList(),
//       //       CategoryList(),
//       //       ProductsGallery(),
//       //       ProductsCarousel(),
//       //       SingleImageView(),
//       //       SingleVideoView(),
//       //       ProductSlider(),
//       //       ProductGridViewByCategory(),
//       //       ProductGridViewSimple(),
//       //       DiscountBanner(),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }