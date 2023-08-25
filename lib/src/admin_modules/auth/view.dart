import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../custom_widgets/customTextField.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../modules/auth/components/or_divider.dart';
import '../../utils/constants/colors.dart';
import '../home/view.dart';
import 'logic.dart';

class SignInPage extends StatelessWidget {

  SignInPage({Key? key}) : super(key: key);


  final logic = Get.put(AuthLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: SafeArea(
      //   child: Visibility(
      //     // visible: ,
      //     child: Wrap(
      //       children: [
      //         Center(
      //           child: Padding(
      //             padding: EdgeInsets.symmetric(
      //                 vertical: pageMarginVertical
      //             ),
      //             child:
      //             GestureDetector(
      //               onTap: () {
      //                 // alertShowDeleteDialogue(
      //                 //     context: context, deleteAcc: logic.infor.value);
      //               },
      //               child: DecoratedBox(
      //                 decoration: const BoxDecoration(
      //                   border: Border(
      //                     bottom: BorderSide(
      //                       color: AppColors.appTextColor,
      //                       width: 1.0,
      //                     ),
      //                   ),
      //                 ),
      //                 child: Text("Continue As Guest",
      //                   style: context.text.bodyMedium
      //                       ?.copyWith(
      //                       color: AppColors.appTextColor,
      //                     fontSize: 14.sp
      //                   ),),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        title: SizedBox(
          height: 35.h,
          // color: Colors.red,
          child: SvgPicture.asset(Assets.icons.layerIconLogo),
        ),
        centerTitle: true,
        backgroundColor: AppColors.customWhiteTextColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal,
            vertical: pageMarginVertical
        ),
        child: Obx(() {
          return Form(
            key: logic.formKeyValue,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                30.heightBox,
                Text("Login to Continue",
                  style: context.text.labelLarge?.copyWith(
                      color: Colors.black, fontSize: 16.sp),),
                Container(
                    width: 241.w,
                    child: Text(
                      "Login with credentials to enter the Tapday dashboard",
                      maxLines: 2,
                      style: context.text.bodyMedium?.copyWith(
                          color: AppColors.appHintColor, fontSize: 14.sp),)),
                30.heightBox,
                CustomTextField(
                  controller: logic.emailAdminController,
                  keyBoardType: TextInputType.emailAddress,
                  hint: "Email Address",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    else if (!GetUtils.isEmail(value)) {
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
                    }
                    else if (value
                        .toString()
                        .length < 8) {
                      return 'Password must be 8 characters';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      logic.obscureText.value ? Icons.visibility_off : Icons
                          .visibility,
                      color: AppColors.textFieldIconsColor,
                    ),
                    onPressed: () {
                      logic.obscureText.value = !logic.obscureText.value;
                    },
                  ),
                ),


                30.heightBox,

                Obx(() {
                  return Container(
                    width: double.maxFinite,
                    height: 42.h,
                    // padding: EdgeInsets.symmetric(
                    //   horizontal: pageMarginHorizontal
                    // ),
                    child: ElevatedButton(

                      onPressed: () {
                        if(logic.formKeyValue.currentState!.validate()){
                          // AuthLogic.to.isProcessing.value = true;
                          // AuthLogic.to.signInUser(context: context);
                          AuthLogic.to.signInUser(context: context);
                        }

                        // Get.to(() => HomePage());
                      },


                      // onPressed: isDisable || isLoading
                      //     ? null // If the button is disabled or in loading state, onPressed should be null
                      //     : () {
                      //   HapticFeedback.lightImpact();
                      //   onPressed();
                      // },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: const Color(0xff3B8C6E),
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
                        // controller: AnimationController(
                        //     vsync: this, duration: const Duration(milliseconds: 1200)),
                      )
                          : Text(
                        "Sign In",
                        style: context.text.bodyLarge?.copyWith(
                            color: AppColors.customWhiteTextColor),
                      ),
                    ),
                  );
                }),
                OrDivider(),
                Container(
                  width: double.maxFinite,
                  height: 42.h,
                  // padding: EdgeInsets.symmetric(
                  //     horizontal: pageMarginHorizontal
                  // ),
                  child: ElevatedButton(

                    onPressed: () {
                      // if(logic.formKeyValue.currentState!.validate()){
                      //   // AuthLogic.to.isProcessing.value = true;
                      //   // AuthLogic.to.signInUser(context: context);
                      //   AuthLogic.to.signInUser(context: context);
                      // }
                    },


                    // onPressed: isDisable || isLoading
                    //     ? null // If the button is disabled or in loading state, onPressed should be null
                    //     : () {
                    //   HapticFeedback.lightImpact();
                    //   onPressed();
                    // },
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
                      style: context.text.bodyLarge?.copyWith(
                          color: Colors.blue),
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