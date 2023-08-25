import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';

final logic = Get.put(ProfileLogic());

alertShowDeleteDialogue(
    {required BuildContext context, required List deleteAcc}) {
  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: AppColors.customWhiteTextColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8.0), // Set your desired border radius here
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.customWhiteTextColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.icons.deleteAccountIcon,
                width: 155,
                height: 110,
              ),
              SizedBox(height: 28.0),
              Text(
                "Confirm Account Deletion",
                style: context.text.bodyMedium!.copyWith(
                    color: AppColors.appTextColor,
                    height: 1.1,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 14.0),
              Text(
                "You're about to permanently delete your account and all associated data. Once deleted, it can't be restored. Are you sure you want to proceed?",
                textAlign: TextAlign.center,
                style: context.text.bodyMedium!
                    .copyWith(color: AppColors.appHintColor, height: 1.1),
              ),
              SizedBox(height: 28.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 38,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Vibration.vibrate(duration: 100);
                            HapticFeedback.lightImpact();
                            Navigator.of(context).pop();
                            // ProductDetailLogic.to.addProductToCart();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                              elevation: 0, // Set the text color of the button
                              padding: const EdgeInsets.all(
                                  8), // Set the padding around the button content
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              side: const BorderSide(
                                width: 1.0,
                                color: AppColors.appPriceRedColor,
                              )),
                          child: Text(
                            "Cancel",
                            style: context.text.bodyMedium!.copyWith(
                                color: AppColors.appPriceRedColor, height: 1.1),
                          )),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () async {
                            // Vibration.vibrate(duration: 100);
                            HapticFeedback.lightImpact();
                            logic.deleteUser(
                                context: context, id: deleteAcc[0]['id']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appPriceRedColor,
                            foregroundColor: Colors.white,
                            elevation: 0, // Set the text color of the button
                            padding: const EdgeInsets.all(
                                8), // Set the padding around the button content
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            "Delete",
                            style: context.text.bodyMedium!
                                .copyWith(color: Colors.white, height: 1.1),
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
