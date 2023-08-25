import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';

void showOrderNoteSheet({required BuildContext context}) {
  // TextEditingController _controller = new TextEditingController();

  final cartLogic = CartLogic.to;

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      18.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.appTextColor,
                              size: 25.sp,
                            ),
                          ),
                          Text(
                            "ORDER NOTE",
                            style: context.text.bodyLarge,
                          ),
                          30.widthBox
                        ],
                      ),
                      25.heightBox,
                      CustomTextField(
                        controller: cartLogic.orderNoteTxtController,
                        hint: "Add order note",
                        fieldVerticalPadding: 8,
                        maxLines: 4,
                        autoFocus: true,
                      ),
                      15.heightBox,
                      Obx(() {
                        return GlobalElevatedButton(
                          text: "Add",
                          onPressed: () {
                            // Navigator.of(context).pop();
                            HapticFeedback.lightImpact();

                            if (cartLogic
                                .orderNoteTxtController.text.isNotEmpty) {
                              cartLogic.addOrderNote();
                            } else {
                              showToastMessage(
                                  message: "Please enter valid order note");
                            }
                          },
                          isLoading: cartLogic.isProcessing.value,
                        );
                      }),
                      20.heightBox,
                    ],
                  ),
                ),
              )),
            ),
          ),
        );
      });
}
