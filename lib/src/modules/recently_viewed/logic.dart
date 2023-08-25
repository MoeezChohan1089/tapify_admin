import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../api_services/shopify_flutter/models/models.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/database_controller.dart';
import 'state.dart';

class RecentlyViewedLogic extends GetxController {
  final RecentlyViewedState state = RecentlyViewedState();
  static RecentlyViewedLogic get to => Get.find();

  final Rx<List<Product>> _recentlyViewed = Rx<List<Product>>([]);
  List<Product> get userRecentlyViewed => _recentlyViewed.value;

  @override
  void onInit() {
    super.onInit();
    getLocallySavedRecentlyViewed();
  }

  getLocallySavedRecentlyViewed() {
    if(LocalDatabase.to.box.read("recentlyViewed") != null) {
      List<dynamic> retrievedData = LocalDatabase.to.box.read("recentlyViewed");
      if (kDebugMode) {
        print("retrieved recently viewed product list is => ${retrievedData.length}");
      }
      List<Product> convertedData = retrievedData.map((data) => Product.fromJsonDirect(data)).toList();
      _recentlyViewed.value = convertedData;
    }
  }

  addToRecentlyViewed({required Product product}) {
    try {
      int productIndex = checkIfExistsInRecent(id: product.id);

      if (productIndex != -1) {
        // Product is already in the list, so remove it from its current position
        _recentlyViewed.value = List<Product>.from(_recentlyViewed.value)
          ..removeAt(productIndex);
      }

      // Add the product to the beginning of the list
      _recentlyViewed.value = [product, ..._recentlyViewed.value];

      // Save the recently viewed list to local database
      LocalDatabase.to.box.write("recentlyViewed", _recentlyViewed.value);

      // Provide feedback to the user
      // HapticFeedback.lightImpact();

      // Trigger UI update
      update();
    } catch (e) {
      showToastMessage(message: "Error adding to recently viewed $e");
    }
  }




  // addToRecentlyViewed({required BuildContext context, required Product product}) {
  //   try{
  //     int productIndex = checkIfExistsInRecent(id: product.id);
  //     //--- if it returns -1 it means this product is not there
  //     if(productIndex != -1) {
  //       _recentlyViewed.value = List<Product>.from(_recentlyViewed.value)
  //         ..removeAt(productIndex);
  //       HapticFeedback.lightImpact();
  //     } else {
  //       _recentlyViewed.value = List<Product>.from(_recentlyViewed.value)
  //         ..add(product);
  //       HapticFeedback.lightImpact();
  //     }
  //     LocalDatabase.to.box.write("recentlyViewed", _recentlyViewed.value);
  //     HapticFeedback.lightImpact();
  //     update();
  //   } catch (e) {
  //     showToastMessage(message: "Error adding to recent viewed $e");
  //   }
  // }

  checkIfExistsInRecent({required String id}) {
    return _recentlyViewed.value.indexWhere((product) => product.id == id);
  }


}