
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../widgets/customTextField.dart';
import 'signInButton.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(Assets.icons.backgroundIcon,
          ),
        ),

        Align(
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset(Assets.icons.backgroundIconBottom,
          ),
        ),
        Positioned.fill(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
          child: Column(

            children: [
              70.heightBox,
              SvgPicture.asset(Assets.icons.appLogoIcon,
                height: 47,
              ),
              89.heightBox,
              CustomTextFieldC(
                // controller: logic.emailController,
                hintText: 'Email',
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                // textAlign: TextAlign.center,
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customBlackTextColor,
                textColor: Colors.black,

                textFieldFillColor: Colors.white,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 0,
                outlineTopLeftRadius: 0,
                outlineTopRightRadius: 0,
                outlineBottomLeftRadius: 0,
                outlineBottomRightRadius: 0,
                textFontSize: 16.0,
                onTap: () async {
                  null;
                },
              ),
              16.heightBox,
              CustomTextFieldC(
                // controller: logic.emailController,
                hintText: 'Password',
                obscureText: true,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
                // textAlign: TextAlign.center,
                hintFontSize: 16.0,
                isOutlineInputBorder: true,
                isOutlineInputBorderColor: AppColors.customBlackTextColor,
                textColor: Colors.black,

                textFieldFillColor: Colors.white,
                // fontWeight: FontWeight.bold,
                fieldborderRadius: 0,
                outlineTopLeftRadius: 0,
                outlineTopRightRadius: 0,
                outlineBottomLeftRadius: 0,
                outlineBottomRightRadius: 0,
                textFontSize: 16.0,
                onTap: () async {
                  null;
                },
              ),
              SignInButton(title: "Sign in",),
            ],
          ),
        )),
      ],
    );
  }
}
