import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/auth/logic.dart';
import 'package:tapify_admin/src/modules/auth/view_forgot_password.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../custom_widgets/customTextField.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../utils/constants/colors.dart';
import '../cart/logic.dart';
import '../home/view.dart';
import 'components/custom_button.dart';
import 'components/or_divider.dart';
import 'components/otherAccount.dart';

class SignInPage extends StatelessWidget {

  SignInPage({Key? key}) : super(key: key);


  final logic = Get.find<AuthLogic>();

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal,
            vertical: pageMarginVertical
        ),
        child: Obx(() {
          return Form(
            key: logic.signInFormKey,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [


                30.heightBox,


                CustomTextField(
                  controller: logic.emailTextController,
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
                  controller: logic.passwordTextController,
                  hint: "Password",
                  isObscure: logic.obscureText2.value,
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
                      logic.obscureText2.value ? Icons.visibility_off : Icons
                          .visibility,
                      color: AppColors.textFieldIconsColor,
                    ),
                    onPressed: () {
                      logic.obscureText2.value = !logic.obscureText2.value;
                    },
                  ),
                ),


                30.heightBox,


                GlobalElevatedButton(
                  text: "sign in", onPressed: () {
                      if(logic.signInFormKey.currentState!.validate()){
                        AuthLogic.to.isProcessing.value = true;
                        AuthLogic.to.signInUser(context: context);
                      }
                },
                  isLoading: logic.isProcessing.value,
                ),


                15.heightBox,


                GestureDetector(
                  onTap: () {
                    Get.to(()=>ForgotPasswordPage(), opaque: false, transition: Transition.native);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ForgotPasswordPage()));
                  },
                  child: Text("Forgot password?",
                    style: context.text.bodyMedium,
                  ),
                ),

                (CartLogic.to.getAccCreationSetting.contains("Required") || logic.isCheckoutContinue.isFalse) ?  const SizedBox() : const OrDivider(),
                // const ContinueWithSocial(),


              ],
            ),
          );
        }),
      ),
    );
  }
}