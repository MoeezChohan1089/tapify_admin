import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';
import 'package:tapify_admin/src/modules/auth/view.dart';
import 'package:tapify_admin/src/modules/bottom_nav_bar/logic.dart';

import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/database_controller.dart';
import '../../utils/global_instances.dart';
import 'api_service/profile_apis.dart';
import 'state.dart';

class ProfileLogic extends GetxController {
  static ProfileLogic get to => Get.find();
  final ProfileState state = ProfileState();
  RxList infor = [].obs;
  RxList infor1 = [].obs;
  RxList userInfo = [].obs;
  RxBool isProcessing = false.obs;

  // ShopifyUser userGet = ShopifyUser();

  signOutUser({required BuildContext context}) async {
    // customLoader.showLoader(context);

    isProcessing.value = true;

    if (await signOutApiService()) {
      LocalDatabase.to.box.remove("customerAccessToken");
      // customLoader.hideLoader();
      isProcessing.value = false;

      BottomNavBarLogic.to.currentPageIndex.value = 0;
      showToastMessage(message: "Logout successfully.");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Now Guest User',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
    } else {
      showToastMessage(message: "Something went Wrong");
      isProcessing.value = false;
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Something went Wrong',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      // customLoader.hideLoader();
    }
  }

  deleteUser({required BuildContext context, required String id}) async {
    customLoader.showLoader(context);
    print("value id: $id");
    if (await deleteAccountApiService(id: id)) {
      LocalDatabase.to.box.remove("customerAccessToken");
      customLoader.hideLoader();
      Get.offAll(
        () => AuthPage(),
      );
      showToastMessage(message: "Account delete");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Account delete',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
    } else {
      showToastMessage(message: "Something went Wrong");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Something went Wrong',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      customLoader.hideLoader();
    }
  }

  void getUserInfo() {
    final List info = LocalDatabase.to.box.read('userInfo') ?? [];
    userInfo.value.assignAll(info);
  }
}
