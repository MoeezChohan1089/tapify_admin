//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tapify_admin/src/modules/product_detail/api_services.dart';
// import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
// import 'package:tapify_admin/src/utils/extensions.dart';
// import 'package:vibration/vibration.dart';
//
// import '../../../custom_widgets/customPopupDialogue.dart';
// import '../../../utils/constants/colors.dart';
// import '../../auth/components/custom_button.dart';
// import '../logic.dart';
//
// class CartButton extends StatefulWidget {
//   String? title;
//   CartButton({Key? key, this.title}) : super(key: key);
//
//   @override
//   State<CartButton> createState() => _CartButtonState();
// }
//
// class _CartButtonState extends State<CartButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical / 2),
//       child: SizedBox(
//         width: double.maxFinite,
//         child: AuthBlackButton(
//           buttonTitle: "${widget.title}",
//           onPressed: (){
//             HapticFeedback.lightImpact();
//             ProductDetailLogic.to.addProductToCart(context);
//           },
//         ),
//       ),
//     );
//   }
// }