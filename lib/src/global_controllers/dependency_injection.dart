import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/reviews/reviews_controller.dart';
import '../custom_widgets/custom_product_bottom_sheet.dart';
import '../modules/auth/logic.dart';
import '../modules/cart/logic.dart';
import '../modules/category/logic.dart';
import '../modules/recently_viewed/logic.dart';
import '../modules/wishlist/logic.dart';
import 'app_config/config_controller.dart';
import 'connection_status.dart';
import 'database_controller.dart';
import 'currency_controller.dart';

class DependencyInjection {
  static Future<void> init()  async {

    Get.put<LocalDatabase>(
      LocalDatabase(),
      permanent: true,
    );

    Get.put<AppConfig>(
      AppConfig(),
      permanent: true,
    );

    Get.put<NetworkConnection>(
      NetworkConnection(),
      permanent: true,
    );

  }


  static Future<void> initializeAppControllers() async {

    Get.put<CurrencyController>(
      CurrencyController(),
      permanent: true,
    );

    Get.put<CartLogic>(
      CartLogic(),
      permanent: true,
    );

    Get.put<WishlistLogic>(
      WishlistLogic(),
      permanent: true,
    );

    Get.put<ReviewsListController>(
      ReviewsListController(),
      permanent: true,
    );

    Get.put<CategoryLogic>(
      CategoryLogic(),
      permanent: true,
    );

    Get.put<RecentlyViewedLogic>(
      RecentlyViewedLogic(),
      permanent: true,
    );

    Get.put<ProductSheet>(
      ProductSheet(),
      permanent: true,
    );

  }
}