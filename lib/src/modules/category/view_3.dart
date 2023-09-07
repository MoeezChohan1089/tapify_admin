//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tapify_admin/src/utils/constants/colors.dart';
// import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
//
// import '../../custom_widgets/custom_app_bar.dart';
// import '../../utils/skeleton_loaders/shimmerLoader.dart';
//
// class CategoryPage3 extends StatelessWidget {
//   const CategoryPage3({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'collection',
//         showBack: false,
//         showMenuIcon: true,
//       ),
//       body: Column(
//           children: List.generate(
//               4, (index) {
//             return GestureDetector(
//               onTap: () {
//                 // Get.to(() => CategoryProducts(
//                 //   collectionID: logic.categoryCollection[index].id,
//                 //   categoryName: logic.categoryCollection[index].title,));
//               },
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: 6, horizontal: pageMarginHorizontal),
//                 child: Stack(
//                   children: [
//                     ///--- old working
//                     SizedBox(
//                       width: double.maxFinite,
//                       height: 130.h,
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(3.r),
//                             child: CachedNetworkImage(
//                               imageUrl: 'https://ssp.dcie.miami.edu/_assets/images/admission/071114_jabreu_021j-business-boys-480x320.jpg',
//                               fit: BoxFit.cover,
//                               height: double.infinity,
//                               width: double.infinity,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                   CachedBackgroundImagePage(),
//                               errorWidget: (context, url, error) =>
//                               const Icon(Icons.error),
//                             ),
//                           ),
//                           Positioned.fill(
//                               child: Align(
//                                 alignment: Alignment.topRight,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Container(padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal*2, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.customWhiteTextColor,
//                                         borderRadius: BorderRadius.circular(3.r)
//                                       ),
//                                       child: Text("fff", textAlign: TextAlign.center,)),
//                                 ),
//                               ))
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           })
//       ),
//     );
//   }
// }
