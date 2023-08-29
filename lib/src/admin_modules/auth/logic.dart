import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';

import '../../custom_widgets/custom_snackbar.dart';
import '../home/view.dart';
import 'api_services/api_services.dart';
import 'components/error_fetching_dialog.dart';
import 'components/fetching_shop_dialog.dart';
import 'components/invalid_qr_code.dart';

class AdminAuthLogic extends GetxController {
  static AdminAuthLogic get to => Get.find();

  TextEditingController emailAdminController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  RxBool obscureText = true.obs;
  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  RxBool isProcessing = false.obs;
  RxBool gettingAPIResult = false.obs;

  signInUser({required BuildContext context}) async {
    // customLoader.showLoader(context);
    isProcessing.value = true;
    if (await adminUserLogInService(
        email: emailAdminController.text,
        password: passwordAdminController.text)) {
      await getShopByQRCode(
          qrToken: LocalDatabase.to.box.read("adminSignedInToken"));
      isProcessing.value = false;
      emailAdminController.clear();
      passwordAdminController.clear();
      LocalDatabase.to.box.write("isViewingWithQR", false);

      Get.off(() => AdminHomePage());
    } else {
      isProcessing.value = false;
      showToastMessage(
          message: "Error in signing in, wrong email password entered");
    }
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Back', false, ScanMode.QR);
      debugPrint("QRCode_Result:-- $qrCode ");
      if (qrCode.toString().contains("|")) {
        //---- show dialog
        fetchingShopDetails();

        //----- call the API
        if (await getShopByQRCode(qrToken: qrCode)) {
          LocalDatabase.to.box.write("isViewingWithQR", true);
          LocalDatabase.to.box.write("adminSignedInToken", qrCode);
          Get.off(() => AdminHomePage());
        } else {
          //---- hide dialog
          Get.back();
          errorFetchingDetails();
          //---- show new dialog that shows error
        }
      } else {
        invalidQRCodeDialog();
        debugPrint("Error QR codes doesn't contains token");
      }
    } on PlatformException {
      debugPrint('Failed to scan QR Code.');
    }
  }
}
