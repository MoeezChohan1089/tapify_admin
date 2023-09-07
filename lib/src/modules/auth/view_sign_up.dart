import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/auth/logic.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../utils/constants/colors.dart';
import '../cart/logic.dart';
import 'components/custom_button.dart';
import 'components/customForm.dart';
import 'components/or_divider.dart';
import 'components/otherAccount.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final logic = Get.find<AuthLogic>();

  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        padding: EdgeInsets.symmetric(
            horizontal: pageMarginHorizontal,
            vertical: pageMarginVertical
        ),

        child: Form(
          key: logic.signUpFormKey,
          child: Column(
            children: [


              20.heightBox,

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Expanded(
                    child: CustomTextField(
                      controller: logic.firstNameController,
                      hint: "First Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'First name is required';
                        }
                        if (logic.containsSpecialCharacters(value) || logic.containsNumbers(value)) {
                          return 'Characters and numbers not allowed';
                        }
                        if (logic.containsOnlySpaces(value)) {
                          return 'Only spaces are denied';
                        }
                        // Add any other required validators here
                        return null;
                      },
                    ),
                  ),
                  15.widthBox,
                  Expanded(
                    child: CustomTextField(
                      controller: logic.lastNameController,
                      hint: "Last Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Last name is required';
                        }
                        if (logic.containsSpecialCharacters(value) || logic.containsNumbers(value)) {
                          return 'Characters and numbers not allowed';
                        }
                        if (logic.containsOnlySpaces(value)) {
                          return 'Only spaces are denied';
                        }
                        // Add any other required validators here
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              20.heightBox,

              CustomTextField(
                controller: logic.emailController,
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

              Obx(() {
                return Column(
                  children: [

                    CustomTextField(
                      controller: logic.passController,
                      hint: "Password",
                      isObscure: logic.obscureText.value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }  else if (value
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

                    20.heightBox,


                    CustomTextField(
                      controller: logic.confirmController,
                      hint: "Confirm Password",
                      isObscure: logic.obscureText1.value,
                      validator: (value) {
                        confirmPassword = value;
                        if (value!.isEmpty) {
                          return 'Confirm Password is required';
                        }
                        if (logic.confirmController.text != logic.passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          logic.obscureText1.value
                              ? Icons.visibility_off
                              : Icons
                              .visibility,
                          color: AppColors.textFieldIconsColor,
                        ),
                        onPressed: () {
                          logic.obscureText1.value = !logic.obscureText1.value;
                        },
                      ),
                    ),


                  ],
                );
              }),

              40.heightBox,


              Obx(() {
                return GlobalElevatedButton(
                  text: "Create Account",
                  onPressed: () async {
                    if (logic.signUpFormKey.currentState!.validate()) {
                      logic.isProcessing.value = true;
                      AuthLogic.to.createNewUser(context: context);
                    }
                  },
                  isLoading: logic.isProcessing.value,
                );
              }),


              (CartLogic.to.getAccCreationSetting.contains("Required") || logic.isCheckoutContinue.isFalse) ?  const SizedBox() : const OrDivider(),
              // const ContinueWithSocial()
            ],
          ),
        ),
      ),
    );
  }
}