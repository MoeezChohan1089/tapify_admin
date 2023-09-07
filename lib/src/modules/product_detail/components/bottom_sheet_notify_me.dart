import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../cart/logic.dart';
import '../logic.dart';

void notifyMeBottomSheet({required BuildContext context}) {
  final logic = Get.put(ProductDetailLogic());
  // TextEditingController _controller = new TextEditingController();


  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
              color: Colors.white,
              // decoration: BoxDecoration(
              //     color: Colors.grey.shade100),
              child: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: pageMarginHorizontal
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          18.heightBox,


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: SizedBox()),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Notify me when available",
                                  style: context.text.bodyLarge,
                                ),
                              ),

                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Icon(
                                      Icons.close,
                                      color: AppColors.appTextColor,
                                      size: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          30.heightBox,
                          Text(
                            "We will send you a notification as soon as this product is available again.",
                            style: context.text.bodyMedium?.copyWith(color: AppColors.appHintColor),
                          ),

                          25.heightBox,

                          CustomTextField(
                            hint: "Email",
                            controller: logic.notifyController,
                            keyBoardType: TextInputType.emailAddress,
                            fieldVerticalPadding: 8,
                            autoFocus: false,
                          ),

                          15.heightBox,

                        GlobalElevatedButton(
                          text: "Notify Me",
                          onPressed: () {

                            HapticFeedback.lightImpact();
                            Navigator.of(context).pop();
                          },
                          isLoading: false,
                        ),

                          20.heightBox,
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),
        );
      });
}