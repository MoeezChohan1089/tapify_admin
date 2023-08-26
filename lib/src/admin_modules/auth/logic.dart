import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../custom_widgets/custom_snackbar.dart';
import '../home/view.dart';
import 'api_services/api_services.dart';

class AdminAuthLogic extends GetxController {
  static AdminAuthLogic get to => Get.find();

  TextEditingController emailAdminController = TextEditingController();
  TextEditingController passwordAdminController = TextEditingController();

  RxBool obscureText = true.obs;
  GlobalKey<FormState> formKeyValue = GlobalKey<FormState>();
  RxBool isProcessing = false.obs;

  signInUser({required BuildContext context}) async {
    // customLoader.showLoader(context);
    isProcessing.value = true;
    if (await adminUserLogInService(
        email: emailAdminController.text,
        password: passwordAdminController.text)) {
      isProcessing.value = false;
      emailAdminController.clear();
      passwordAdminController.clear();
      Get.offAll(() => AdminHomePage());
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
    } on PlatformException {
      debugPrint('Failed to scan QR Code.');
    }
  }
}
