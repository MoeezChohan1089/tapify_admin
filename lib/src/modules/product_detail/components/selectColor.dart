// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tapify/src/utils/constants/colors.dart';
// import 'package:tapify/src/utils/constants/margins_spacnings.dart';
// import 'package:tapify/src/utils/extensions.dart';
//
// class SelectColor extends StatefulWidget {
//   const SelectColor({Key? key}) : super(key: key);
//
//   @override
//   State<SelectColor> createState() => _SelectColorState();
// }
//
// class _SelectColorState extends State<SelectColor> {
//   String selectedDirection = "Large";
//   List<String> specialist = ["Large", "Medium", "Small"];
//
//   List<DropdownMenuItem> generateItems(List<String> spesialis) {
//     List<DropdownMenuItem> items = [];
//     for (var item in spesialis) {
//       items.add(
//         DropdownMenuItem(
//           child: Text("$item"),
//           value: item,
//         ),
//       );
//     }
//     return items;
//   }
//
//   customButton(String title) {
//     return Container(
//         padding: EdgeInsets.only(right: 8.w, left: 8.w, bottom: 9.h, top: 9.h),
//         decoration: BoxDecoration(
//             border: Border.all(color: AppColors.customGreyTextColor, width: 1)),
//         child:
//             Text(title, style: context.text.bodyMedium?.copyWith(height: 0.9))
//         // DropdownButton(
//         //   menuMaxHeight: 300,
//         //   isExpanded: true,
//         //   underline: SizedBox(),
//         //   icon: Icon(Icons.keyboard_arrow_down_outlined),
//         //   value: selectedDirection,
//         //   items: generateItems(specialist),
//         //   onChanged: (dynamic item) {
//         //     setState(() {
//         //       selectedDirection = item;
//         //     });
//         //   },
//         // ),
//         );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: pageMarginHorizontal,
//         right: pageMarginHorizontal,
//         bottom: pageMarginVertical / 1.8,
//
//         // horizontal: pageMarginHorizontal, vertical: pageMarginVertical
//       ),
//       child: SizedBox(
//         width: double.maxFinite,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Color", style: context.text.bodyLarge),
//             8.heightBox,
//             Wrap(
//               children: [
//                 customButton("Black"),
//                 8.widthBox,
//                 customButton("White"),
//                 8.widthBox,
//                 customButton("Blue"),
//                 8.widthBox,
//                 customButton("Red"),
//                 8.widthBox,
//                 customButton("Green"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
