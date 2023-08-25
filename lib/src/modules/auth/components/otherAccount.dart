
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tapify/src/utils/constants/assets.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';

class ContinueWithSocial extends StatefulWidget {
  const ContinueWithSocial({Key? key}) : super(key: key);

  @override
  State<ContinueWithSocial> createState() => _ContinueWithSocialState();
}

class _ContinueWithSocialState extends State<ContinueWithSocial> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialButton(
          text: "Google",
          imagePath: Assets.icons.coloredGoogleIcon,
          onPress: (){},
        ),
        15.heightBox,
        SocialButton(
          text: "Apple",
          imagePath: Assets.icons.appleIcon,
          onPress: (){},
        ),
        15.heightBox,
        SocialButton(
          text: "Facebook",
          imagePath: Assets.icons.coloredFbIcon,
          onPress: (){},
        ),

      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final Function onPress;
  final String text;
  final String imagePath;


  const SocialButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(),
      borderRadius: BorderRadius.circular(5.r),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.appBordersColor, width: .5),
          borderRadius: BorderRadius.circular(5.r),

        ),
        child: Row(
          children: [
             Expanded(
                child: SvgPicture.asset(
                    imagePath
                    // Assets.icons.coloredGoogleIcon
                )),

            25.widthBox,

            Expanded(
              flex: 3,
              child: Text(
                'Continue with $text',
                style: context.text.bodyMedium
              ),
            ),
          ],
        ),
      ),
    );
  }
}