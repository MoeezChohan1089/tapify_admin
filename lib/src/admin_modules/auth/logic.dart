import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/admin_modules/home/view.dart';

import '../../custom_widgets/custom_snackbar.dart';
import '../../modules/auth/api_services/auth_api_service.dart';
import 'state.dart';

class AuthLogic extends GetxController {
  static AuthLogic get to => Get.find();
  final AuthState state = AuthState();

  TextEditingController emailAdminController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  RxBool obscureText = true.obs;
  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  RxBool isProcessing = false.obs;


  signInUser({required BuildContext context}) async {
    // customLoader.showLoader(context);
    isProcessing.value = true;
    if (await staticUserAPI(
        email: emailAdminController.text,
        password: passwordAdminController.text)) {
      ///----- API Successful

      // customLoader.hideLoader();

      isProcessing.value = false;
      emailAdminController.clear();
      passwordAdminController.clear();
      // if (onSuccessNavigator != null) {
      //   onSuccessNavigator!();
      // } else {
      //
      // }
      Get.offAll(() => HomePage());

    } else {
      isProcessing.value = false;
      showToastMessage(message: "Error in signing in, wrong email password entered");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Error in signing in, wrong email password entered',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      // customLoader.hideLoader();
    }
  }

}
