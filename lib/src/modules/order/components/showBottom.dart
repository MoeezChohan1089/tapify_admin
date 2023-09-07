import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../custom_widgets/customTextField.dart';
import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../utils/constants/colors.dart';
import '../../auth/components/custom_button.dart';
import '../logic.dart';

final logic = Get.find<OrderLogic>();

void productRatingBottomSheet(context, double finalRating, String prodId,
    int orderNo, String emailDefault) {
  // TextEditingController _controller = new TextEditingController();
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          bool isSubmitEnabled = logic.areFieldsFilled();

          // Add listeners to controllers
          void updateSubmitState() {
            setState(() {
              isSubmitEnabled = logic.areFieldsFilled();
            });
          }

          logic.titleController.addListener(updateSubmitState);
          logic.fullNameController.addListener(updateSubmitState);
          logic.emailController.addListener(updateSubmitState);
          logic.reviewController.addListener(updateSubmitState);
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
            ),
            color: Colors.white,
            child: Wrap(
              children: [
                SafeArea(
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        children: [
                          10.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 50.w,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "What is your rate?",
                                  style: context.text.titleMedium?.copyWith(
                                      color: AppColors.appTextColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColors.appTextColor, size: 30,),
                                ),
                              ),
                            ],
                          ),
                          // Text("What is your rate?",
                          //   style: context.text.titleMedium?.copyWith(color: AppColors.appTextColor, fontSize: 16.sp, fontWeight: FontWeight.bold),),
                          20.heightBox,
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemBuilder: (context, _) =>
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 12,
                                ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                finalRating = rating;
                                print(
                                    "rating star: ${finalRating}");
                              });
                            },
                          ),
                          20.heightBox,
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.maxFinite,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: pageMarginHorizontal,),
                                child: Column(
                                  children: [
                                    20.heightBox,
                                    Text(
                                      "Share your opinion about this product",
                                      style: context.text.titleMedium?.copyWith(
                                          color: AppColors.appTextColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold),),
                                    20.heightBox,
                                    CustomTextField(
                                      controller: logic.titleController,
                                      hint: 'Enter your title',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Title is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    20.heightBox,
                                    CustomTextField(
                                      controller: logic.fullNameController,
                                      hint: 'Full Name',
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Full name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    // 20.heightBox,
                                    // CustomTextField(
                                    //   controller: logic.emailController,
                                    //   hint: 'Email Address',
                                    //   validator: (value) {
                                    //     if (value!.isEmpty) {
                                    //       return 'Email is required';
                                    //     }
                                    //     return null;
                                    //   },
                                    // ),
                                    20.heightBox,
                                    CustomTextField(
                                      controller: logic.reviewController,
                                      hint: 'Your Review',
                                      maxLines: 3,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'review is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    20.heightBox,
                                    Obx(() {
                                      return SizedBox(
                                        width: double.maxFinite,
                                        child: GlobalElevatedButton(
                                          text: "Submit Review", onPressed: () {
                                          HapticFeedback.lightImpact();
                                          print("value Order: ${emailDefault}");
                                          if (isSubmitEnabled) {
                                            logic.createReview(context: context,
                                                id: prodId,
                                                name: logic.fullNameController
                                                    .text,
                                                emailId: emailDefault,
                                                title: "${logic.titleController
                                                    .text}/order$orderNo",
                                                comment: logic.reviewController
                                                    .text,
                                                rating: finalRating);
                                          } else {
                                            null;
                                          }
                                        },
                                          isLoading: logic
                                              .loadingAnimation.value,
                                        ),
                                        // ElevatedButton(
                                        //     onPressed: () async {
                                        //       // Vibration.vibrate(duration: 100);
                                        //       HapticFeedback.lightImpact();
                                        //       print("value id: $prodId");
                                        //       print("value name: ${logic.fullNameController.text}");
                                        //       print("value email: ${logic.emailController.text}");
                                        //       print("value comment: ${logic.reviewController.text}");
                                        //       print("value rating: ${finalRating}");
                                        //       logic.createReview(context: context, id: prodId, name: logic.fullNameController.text, emailId: logic.emailController.text, title: logic.titleController.text, comment: logic.reviewController.text, rating: finalRating);
                                        //       Navigator.pop(context);
                                        //       },
                                        //     style: ElevatedButton.styleFrom(
                                        //       backgroundColor: Colors.black,
                                        //       foregroundColor: Colors.white,
                                        //       elevation: 0,// Set the text color of the button
                                        //       padding: const EdgeInsets.all(8), // Set the padding around the button content
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius: BorderRadius.circular(0), // Set the border radius of the button
                                        //       ),
                                        //     ),
                                        //     child: Text("Submit Review", style: context.text.bodyMedium!.copyWith(color: Colors.white, height: 1.1),)),
                                      );
                                    }),
                                    20.heightBox,
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      });
}