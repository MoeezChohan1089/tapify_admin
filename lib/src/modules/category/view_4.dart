//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tapify/src/utils/extensions.dart';
//
// import '../../custom_widgets/custom_app_bar.dart';
// import '../../utils/constants/colors.dart';
// import '../../utils/constants/margins_spacnings.dart';
// import '../../utils/skeleton_loaders/shimmerLoader.dart';
// import '../profile/components/profile_page_tiles.dart';
//
// class CategoryPage4 extends StatelessWidget {
//   const CategoryPage4({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'sub collection',
//         showBack: false,
//         showMenuIcon: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: pageMarginVertical, horizontal: pageMarginHorizontal),
//               child: Stack(
//                 children: [
//                   ///--- old working
//                   SizedBox(
//                     width: double.maxFinite,
//                     height: 130.h,
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(3.r),
//                           child: CachedNetworkImage(
//                             imageUrl: 'https://ssp.dcie.miami.edu/_assets/images/admission/071114_jabreu_021j-business-boys-480x320.jpg',
//                             fit: BoxFit.cover,
//                             height: double.infinity,
//                             width: double.infinity,
//                             progressIndicatorBuilder:
//                                 (context, url, downloadProgress) =>
//                                 CachedBackgroundImagePage(),
//                             errorWidget: (context, url, error) =>
//                             const Icon(Icons.error),
//                           ),
//                         ),
//                         Positioned.fill(
//                             child: Align(
//                               alignment: Alignment.topRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Container(padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal*2, vertical: 5),
//                                     decoration: BoxDecoration(
//                                         color: AppColors.customWhiteTextColor,
//                                         borderRadius: BorderRadius.circular(3.r)
//                                     ),
//                                     child: Text("fff", textAlign: TextAlign.center, style: context.text.bodyMedium?.copyWith(color: Colors.black, fontSize: 11.sp),)),
//                               ),
//                             ))
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             20.heightBox,
//             Column(
//               children: List.generate(6, (index){
//                 return GestureDetector(
//                   onTap: () {
//
//                   },
//                   behavior: HitTestBehavior.opaque,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                         border: Border(
//                           top: BorderSide(
//                             color: AppColors.appBordersColor,
//                             width: 0.5,
//                           ),
//                           // bottom: BorderSide(
//                           //   color: AppColors.appBordersColor,
//                           //   width: 0.5,
//                           // ),
//                         )
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: pageMarginVertical
//                       ),
//                       margin: EdgeInsets.symmetric(
//                           horizontal: pageMarginHorizontal
//                       ),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Shoes",
//                             style: context.text.bodyLarge?.copyWith(color: AppColors.appTextColor, fontSize: 16.sp),
//                           ),
//
//                           Icon(
//                             Icons.arrow_forward_ios_rounded,
//                             color: Colors.black,
//                             size: 18.sp,
//                           )
//
//
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
