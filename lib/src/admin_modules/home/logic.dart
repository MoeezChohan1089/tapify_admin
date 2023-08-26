import 'package:get/get.dart';

class AdminHomeLogic extends GetxController {
  static AdminHomeLogic get to => Get.find();

  RxBool isProcessing = false.obs;

  RxInt browsingShopId = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // requestPermission();
    // loadFCM();
    // listenFCM();
  }
}
