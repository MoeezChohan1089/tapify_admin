import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../../custom_widgets/customTextField.dart';
import '../../../../custom_widgets/custom_elevated_button.dart';
import '../../../../custom_widgets/custom_snackbar.dart';
import '../../../../custom_widgets/custom_text_field.dart';
import '../../../../global_controllers/database_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/margins_spacnings.dart';
import '../../../auth/components/custom_button.dart';
import '../../components/delete_account_dialog.dart';
import '../../logic.dart';
import '../logic.dart';

class EditProfileFormScreen extends StatefulWidget {
  const EditProfileFormScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileFormScreen> createState() => _EditProfileFormScreenState();
}

class _EditProfileFormScreenState extends State<EditProfileFormScreen> {
  final logic = Get.put(Edit_profileLogic());
  String? password;
  String? confirmPassword;

  final logic2 = Get.put(ProfileLogic());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.personalInformation.value = LocalDatabase.to.box.read('userInfo');
      if (logic.personalInformation.value.isNotEmpty) {
        logic.editFirstController.text = logic.personalInformation.value[0]['firstname'];
        logic.editLastController.text = logic.personalInformation.value[0]['lastname'];
        logic.editEmailController.text = logic.personalInformation.value[0]['email'];
      }
    });
    // logic.getDynamicHomeView();
  }



  @override
  Widget build(BuildContext context) {
    return Obx(() {

      return Form(
        key: logic.formKeyValue,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
          child: Column(
            children: [
              20.heightBox,

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: logic.editFirstController,
                      hint: "First Name",
                      onChanged: (e){
                        (logic.editFirstController.text != logic.personalInformation.value[0]['firstname'])?
                        logic.isChange.value = true:logic.isChange.value = false;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'First Name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  15.widthBox,
                  Expanded(
                    child: CustomTextField(
                      controller: logic.editLastController,
                      hint: "Last Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                      onChanged: (e){
                        (logic.editLastController.text != logic.personalInformation.value[0]['lastname'])?
                        logic.isChange.value = true:logic.isChange.value = false;
                      },
                    ),
                  ),
                ],
              ),
              15.heightBox,
              CustomTextField(
                controller: logic.editEmailController,
                hint: "Email",
                keyBoardType: TextInputType.emailAddress,
                onChanged: (e){
                  logic.editEmailController.text != logic.personalInformation.value[0]['email']?
                      logic.isChange.value = true:logic.isChange.value = false;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              //   15.heightBox,
              // CustomTextField(
              //   controller: logic.editPassController,
              //   hint: "Password",
              //   isObscure: logic.obscureText.value,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Password is required';
              //     }
              //     return null;
              //   },
              //   suffixIcon: IconButton(
              //     icon: Icon(
              //       logic.obscureText.value ? Icons.visibility_off : Icons
              //           .visibility,
              //       color: AppColors.textFieldIconsColor,
              //     ),
              //     onPressed: () {
              //       logic.obscureText.value = !logic.obscureText.value;
              //     },
              //   ),
              // ),
              15.heightBox,
              CustomTextField(
                controller: logic.editPassController,
                hint: "Password",
                isObscure: logic.obscureText1.value,
                onChanged: (e){
                  logic.editEmailController.text != logic.personalInformation.value[0]['email']?
                  logic.isChange.value = true:logic.isChange.value = false;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    logic.obscureText1.value ? Icons.visibility_off : Icons
                        .visibility,
                    color: AppColors.textFieldIconsColor,
                  ),
                  onPressed: () {
                    logic.obscureText1.value = !logic.obscureText1.value;
                  },
                ),
              ),
              15.heightBox,
              CustomTextField(
                controller: logic.editConfirmController,
                hint: "Confirm Password",
                isObscure: logic.obscureText2.value,
                onChanged: (e){
                  logic.editEmailController.text != logic.personalInformation.value[0]['email']?
                  logic.isChange.value = true:logic.isChange.value = false;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Confirm Password is required';
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

              SizedBox(
                width: double.maxFinite,
                child: GlobalElevatedButton(
                  text: "Edit Profile",
                    onPressed: () {
                  if (logic.editFirstController.text != logic.personalInformation.value[0]['firstname'] ||
                      logic.editLastController.text != logic.personalInformation.value[0]['lastname'] ||
                      logic.editEmailController.text != logic.personalInformation.value[0]['email']) {
                    HapticFeedback.lightImpact();
                    print("name: ${logic.editFirstController.text} ==== ${logic.personalInformation.value[0]['firstname']}");
                    print("name: ${logic.editLastController.text} ==== ${logic.personalInformation.value[0]['lastname']}");
                    print("name: ${logic.editEmailController.text} == ${logic.personalInformation.value[0]['email']}");
                    logic.updateNewProfile(context: context);
                  } else {
                    // Profile information is the same, show message
                    // showToastMessage(message: "Your profile is the same. No changes were made.");
                  }
                },
                  isLoading: logic.isProcessing.value,
                  isDisable: logic.isChange.value?false:true,
                ),



                // ElevatedButton(
                //     onPressed: () async {
                //       if (logic.editFirstController.text != personalInformation[0]['firstname'] ||
                //           logic.editLastController.text != personalInformation[0]['lastname'] ||
                //           logic.editEmailController.text != personalInformation[0]['email']) {
                //         // Perform update logic here
                //         // Vibration.vibrate(duration: 100);
                //         HapticFeedback.lightImpact();
                //         logic.updateNewProfile(context: context);
                //       } else {
                //         // Profile information is the same, show message
                //         showToastMessage(message: "Your profile is the same. No changes were made.");
                //       }
                //       // ProductDetailLogic.to.addProductToCart();
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.black,
                //       foregroundColor: Colors.white,
                //       elevation: 0,
                //       // Set the text color of the button
                //       padding: const EdgeInsets.all(8),
                //       // Set the padding around the button content
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(
                //             0), // Set the border radius of the button
                //       ),
                //     ),
                //     child: Text("Edit Profile",
                //       style: context.text.bodyMedium!.copyWith(
                //           color: Colors.white, height: 1.1),)),
              ),



              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: pageMarginHorizontal,
              //       vertical: pageMarginVertical * 2
              //   ),
              //   child: GestureDetector(
              //     onTap: () {
              //       alertShowDeleteDialogue(
              //           context: context, deleteAcc: logic.infor.value);
              //     },
              //     child: DecoratedBox(
              //       decoration: const BoxDecoration(
              //         border: Border(
              //           bottom: BorderSide(
              //             color: AppColors.appPriceRedColor,
              //             width: 1.0,
              //           ),
              //         ),
              //       ),
              //       child: Text("Delete Account",
              //         style: context.text.bodyMedium
              //             ?.copyWith(
              //             color: AppColors.appPriceRedColor
              //         ),),
              //     ),
              //   ),
              // ),





              // Padding(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: pageMarginHorizontal,
              //       vertical: pageMarginVertical * 2
              //   ),
              //   child: InkWell(
              //     onTap: () {
              //       alertShowDeleteDialogue(
              //           context: context, deleteAcc: logic.infor.value);
              //       // logic.deleteUser(context: context, id: );
              //     },
              //     child: Container(
              //       decoration: const BoxDecoration(
              //           border: Border(bottom: BorderSide(color: AppColors.appPriceRedColor))
              //       ),
              //       padding: EdgeInsets.symmetric(
              //         vertical: pageMarginVertical / 2,
              //       ),
              //       child: Text("Delete Account",
              //         textAlign: TextAlign.center,
              //         style: context.text.bodyMedium?.copyWith(color: AppColors.appPriceRedColor, fontSize: 14.sp),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      );
    });
  }
}