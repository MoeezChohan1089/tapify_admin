import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/custom_snackbar.dart';
import '../../../global_controllers/database_controller.dart';
import '../../../utils/global_instances.dart';
import '../../bottom_nav_bar/logic.dart';
import '../../bottom_nav_bar/view.dart';
import '../logic.dart';
import 'api_service/api_network.dart';
import 'state.dart';

class Edit_profileLogic extends GetxController {
  final Edit_profileState state = Edit_profileState();

  TextEditingController editFirstController = TextEditingController();
  TextEditingController editLastController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editPassController = TextEditingController();
  TextEditingController editConfirmController = TextEditingController();

  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  RxBool obscureText = true.obs;
  RxBool obscureText1 = true.obs;
  RxBool obscureText2 = true.obs;
  RxList infor = [].obs;
  RxBool isChange = false.obs;

  RxBool isProcessing = false.obs;
  RxList personalInformation = [].obs;

  @override
  void onInit() {
    super.onInit();
    infor.value = LocalDatabase.to.box.read('userInfo') ?? [];
    update();
  }

  updateNewProfile({required BuildContext context}) async {
    // customLoader.showLoader(context);

     isProcessing.value = true;

    final updatedFirstName = editFirstController.text;
    final updatedLastName = editLastController.text;
    final updatedEmail = editEmailController.text;

    if (await updateProfileService(
        firstName: updatedFirstName,
        password: editPassController.text,
        email: updatedEmail,
        lastName: updatedLastName,
        customAccessToken: LocalDatabase.to.box.read('customerAccessToken'))) {
      showToastMessage(message: "Profile updated successfully");

      // Update the 'infor' list with the new profile information
      LocalDatabase.to.box.remove("userInfo");
      //
      List userInfo = [{
        "firstname": "${editFirstController.text}",
        "lastname": "${editLastController.text}",
        "email": "${editEmailController.text}"
      }
      ];
      personalInformation.value = userInfo;
      LocalDatabase.to.box.write("userInfo", personalInformation.value);

      isProcessing.value = false;
      isChange.value = false;

      // customLoader.hideLoader();
      infor.value = LocalDatabase.to.box.read('userInfo') ?? [];
      ProfileLogic.to.infor.value = infor.value;

      update();
    } else {
      showToastMessage(message: "Error in updating profile.");
      // customLoader.hideLoader();
      isProcessing.value = false;

    }
  }

  void getUserInfo() {
    final List<Map<String, dynamic>> info =
        LocalDatabase.to.box.read('userInfo') ?? [];
    infor.value.assignAll(info);
  }
}