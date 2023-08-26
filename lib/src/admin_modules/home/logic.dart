import 'package:get/get.dart';

class AdminHomeLogic extends GetxController {
  static AdminHomeLogic get to => Get.find();

  RxBool isProcessing = false.obs;

  RxInt browsingShopId = 0.obs;
  RxString browsingShop = "".obs;
  RxString browsingShopDomain = "".obs;
  RxString browsingStorefrontToken = "d0d94fa9247bc280d6054076506d28a7".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // requestPermission();
    // loadFCM();
    // listenFCM();
  }
}
