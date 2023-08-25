import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/margins_spacnings.dart';
import 'logic.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final logic = Get.find<AuthLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return SizedBox(
            height: 35.h,
            // color: Colors.red,
            child: FadeInImage.memoryNetwork(
              image: AppConfig.to.homeAppBarLogo.value,
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              imageErrorBuilder: (context, url, error) => Container(
                color: Colors.grey.shade200,
                // color: Colors.grey.shade200,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.icons.noImageIcon,
                    height: 25.h,
                  ),
                ),
              ),
              //     (context, url) => SizedBox(
              //   height: 50.h,
              //   width: 100.w,
              //   child: Shimmer.fromColors(
              //     baseColor: Colors.grey.shade300,
              //     highlightColor: Colors.grey.shade100,
              //     child: Container(
              //       color: AppColors.customWhiteTextColor,
              //     ),
              //   ),
              // ),
              // errorWidget: (context, url, error) => Text(
              //   title.toUpperCase(),
              //   style: context.text.titleSmall
              //       ?.copyWith(fontSize: 16.sp, height: 3),
              // ),
            ),
          );
        }),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.customBlackTextColor,
            )),
      ),
      body: Column(
        children: [
          // 70.heightBox,
          // Row(
          //   children: [
          //     Expanded(child: Align(
          //         alignment: Alignment.bottomLeft,
          //         child: IconButton(onPressed: () {
          //           Get.back();
          //         },
          //             icon: const Icon(Icons.arrow_back_ios_new_rounded,
          //               color: AppColors.customBlackTextColor,)))),
          //     Expanded(
          //         flex: 2,
          //         child:
          //         Obx(() {
          //           return SizedBox(
          //             height: 35.h,
          //             // color: Colors.red,
          //             child: CachedNetworkImage(
          //               imageUrl: AppConfig.to.homeAppBarLogo.value,
          //               fit: BoxFit.cover,
          //               placeholder: (context, url) =>
          //                   SizedBox(
          //                     height: 50.h,
          //                     width: 100.w,
          //                     child: Shimmer.fromColors(
          //                       baseColor: Colors.grey.shade300,
          //                       highlightColor: Colors.grey.shade100,
          //                       child: Container(
          //                         color: AppColors.customWhiteTextColor,
          //                       ),
          //                     ),
          //                   ),
          //               errorWidget: (context, url, error) =>
          //                   Text(
          //                     'tapday',
          //                     style: context.text.titleSmall
          //                         ?.copyWith(fontSize: 16.sp, height: 3),
          //                   ),
          //             ),
          //           );
          //         })
          //     ),
          //     const Expanded(child: SizedBox(),)
          //   ],
          // ),
          50.heightBox,

          Form(
            key: logic.forgetPassFormKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forget password?",
                    style: context.text.labelLarge?.copyWith(fontSize: 16.5.sp),
                  ),
                  5.heightBox,
                  Text("Enter your email that associated with your account",
                      style: context.text.bodyMedium?.copyWith(
                          fontSize: 14.5.sp, color: AppColors.appHintColor)),

                  30.heightBox,

                  CustomTextField(
                    controller: logic.emailForgotController,
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

                  // CustomTextFieldC(
                  //   controller: logic.emailForgotController,
                  //   hintText: 'Email Address',
                  //   hintFontSize: 16.0,
                  //   validation: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Email is required';
                  //     }
                  //     return null;
                  //   },
                  //   isOutlineInputBorder: true,
                  //   isOutlineInputBorderColor: AppColors.customGreyPriceColor,
                  //   textColor: AppColors.customGreyBorderColor,
                  //   textFieldFillColor: Colors.white,
                  //   fontWeight: FontWeight.bold,
                  //   fieldborderRadius: 0,
                  //   outlineTopLeftRadius: 0,
                  //   outlineTopRightRadius: 0,
                  //   outlineBottomLeftRadius: 0,
                  //   outlineBottomRightRadius: 0,
                  //   textFontSize: 16.0,
                  //   onTap: () async {
                  //     null;
                  //   },
                  // ),

                  30.heightBox,

                  Obx(() {
                    return GlobalElevatedButton(
                      text: "Submit",
                      onPressed: () async {
                        if (logic.forgetPassFormKey.currentState!.validate()) {
                          AuthLogic.to.isProcessing.value = true;
                          AuthLogic.to.forgotUser(context: context);
                        }
                      },
                      isLoading: AuthLogic.to.isProcessing.value,
                    );
                  }),

                  // Container(
                  //   width: context.deviceWidth,
                  //   height: 40.h,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     boxShadow: <BoxShadow>[
                  //       BoxShadow(
                  //           color: Colors.grey.shade200,
                  //           blurRadius: 15.0,
                  //           offset: const Offset(0.0, 0.75)
                  //       )
                  //     ],
                  //   ),
                  //   child: AuthBlackButton(
                  //     buttonTitle: "Submit",
                  //     onPressed: () async {
                  //       if(logic.formKeyValue.currentState!.validate()){
                  //         AuthLogic.to.forgotUser(context: context);
                  //       }
                  //     },
                  //   ),
                  //   // ElevatedButton(
                  //   //   onPressed: (){
                  //   //     if(logic.formKeyValue.currentState!.validate()){
                  //   //       AuthLogic.to.forgotUser(context: context);
                  //   //     }
                  //   //
                  //   //   },
                  //   //   style: ElevatedButton.styleFrom(
                  //   //       backgroundColor: Colors.black,
                  //   //       foregroundColor: Colors.white,
                  //   //       shape: const BeveledRectangleBorder()
                  //   //   ),
                  //   //   child: Text(
                  //   //       'Submit',
                  //   //       style: context.text.bodyLarge?.copyWith(
                  //   //           color: Colors.white
                  //   //       )
                  //   //   ),
                  //   // ),
                  //
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}