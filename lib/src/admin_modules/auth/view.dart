// class AdminSignInPage extends StatelessWidget {
//   AdminSignInPage({Key? key}) : super(key: key);
//
//   final logic = Get.put(AdminAuthLogic());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: SizedBox(
//           height: 35.h,
//           child: Image.asset(Assets.images.sanaSafinazLogo),
//         ),
//         centerTitle: true,
//         backgroundColor: AppColors.customWhiteTextColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(
//             horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
//         child: Obx(() {
//           return Form(
//             key: logic.formKeyValue,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 30.heightBox,
//                 Text(
//                   "Login to Continue",
//                   style: context.text.labelLarge
//                       ?.copyWith(color: Colors.black, fontSize: 16.sp),
//                 ),
//                 Text(
//                   "Login with credentials to enter the Tapday dashboard",
//                   style: context.text.bodyMedium?.copyWith(
//                       color: AppColors.appHintColor, fontSize: 14.sp),
//                 ),
//                 30.heightBox,
//                 CustomTextField(
//                   controller: logic.emailAdminController,
//                   keyBoardType: TextInputType.emailAddress,
//                   hint: "Email Address",
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Email is required';
//                     } else if (!GetUtils.isEmail(value)) {
//                       return 'Enter valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//                 20.heightBox,
//                 CustomTextField(
//                   controller: logic.passwordAdminController,
//                   hint: "Password",
//                   isObscure: logic.obscureText.value,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required';
//                     } else if (value.toString().length < 8) {
//                       return 'Password must be 8 characters';
//                     }
//                     return null;
//                   },
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       logic.obscureText.value
//                           ? Icons.visibility_off
//                           : Icons.visibility,
//                       color: AppColors.textFieldIconsColor,
//                     ),
//                     onPressed: () {
//                       logic.obscureText.value = !logic.obscureText.value;
//                     },
//                   ),
//                 ),
//                 30.heightBox,
//                 SizedBox(
//                   width: double.maxFinite,
//                   height: 40.h,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Get.to(() => AdminHomePage());
//                     },
//                     style: ElevatedButton.styleFrom(
//                       elevation: 0,
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     child: logic.isProcessing.value
//                         ? const SpinKitThreeBounce(
//                             color: AppColors.customWhiteTextColor,
//                             size: 23.0,
//                           )
//                         : Text(
//                             "Sign In",
//                             style: context.text.bodyLarge?.copyWith(
//                                 color: AppColors.customWhiteTextColor),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../modules/auth/components/or_divider.dart';
import '../../utils/constants/colors.dart';
import 'logic.dart';

class AdminSignInPage extends StatelessWidget {
  AdminSignInPage({Key? key}) : super(key: key);

  final logic = Get.put(AdminAuthLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 35.h,
          child: SvgPicture.asset(Assets.icons.layerIconLogo),
        ),
        centerTitle: true,
        backgroundColor: AppColors.customWhiteTextColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
        child: Obx(() {
          return Form(
            key: logic.formKeyValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                Text(
                  "Login to Continue",
                  style: context.text.labelLarge
                      ?.copyWith(color: Colors.black, fontSize: 16.sp),
                ),
                Container(
                    width: 241.w,
                    child: Text(
                      "Login with credentials to enter the Tapday dashboard",
                      maxLines: 2,
                      style: context.text.bodyMedium?.copyWith(
                          color: AppColors.appHintColor, fontSize: 14.sp),
                    )),
                30.heightBox,
                CustomTextField(
                  controller: logic.emailAdminController,
                  keyBoardType: TextInputType.emailAddress,
                  hint: "Email Address",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Enter valid email address';
                    }
                    return null;
                  },
                ),
                20.heightBox,
                CustomTextField(
                  controller: logic.passwordAdminController,
                  hint: "Password",
                  isObscure: logic.obscureText.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.toString().length < 8) {
                      return 'Password must be 8 characters';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      logic.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textFieldIconsColor,
                    ),
                    onPressed: () {
                      logic.obscureText.value = !logic.obscureText.value;
                    },
                  ),
                ),
                30.heightBox,
                Obx(() {
                  return SizedBox(
                    width: double.maxFinite,
                    height: 42.h,
                    child: ElevatedButton(
                      onPressed: () {
                        if (logic.formKeyValue.currentState!.validate()) {
                          AdminAuthLogic.to.signInUser(context: context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: logic.isProcessing.value
                          ? const SpinKitThreeBounce(
                              color: AppColors.customWhiteTextColor,
                              size: 23.0,
                            )
                          : Text(
                              "Sign In",
                              style: context.text.bodyLarge?.copyWith(
                                  color: AppColors.customWhiteTextColor),
                            ),
                    ),
                  );
                }),
                const OrDivider(),
                SizedBox(
                  width: double.maxFinite,
                  height: 42.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: const Color(0xff3B8C6E),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.blue,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Scan QR Code",
                      style:
                          context.text.bodyLarge?.copyWith(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
