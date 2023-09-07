import 'package:get/get.dart';

import '../../global_controllers/notification_service.dart';

class AdminHomeLogic extends GetxController {
  static AdminHomeLogic get to => Get.find();

  RxBool isProcessing = false.obs;
  var customerShopsList = [].obs;
  RxInt browsingShopId = 0.obs;
  RxString browsingShop = "".obs;
  RxString browsingShopDomain = "".obs;
  RxString browsingStorefrontToken = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    requestPermission();
    loadFCM();
    listenFCM();
    subscriberAdminFCM();

    // requestPermission();
    // loadFCM();
    // listenFCM();
  }
}
