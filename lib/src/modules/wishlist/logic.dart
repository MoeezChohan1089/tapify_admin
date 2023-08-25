import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/modules/product_detail/logic.dart';
// import 'package:shopify_flutter/models/src/product/product.dart';
import 'package:vibration/vibration.dart';

import '../../api_services/shopify_flutter/models/src/product/product.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/database_controller.dart';
import '../../utils/global_instances.dart';
import 'state.dart';

class WishlistLogic extends GetxController {
  static WishlistLogic get to => Get.find();
  final WishlistState state = WishlistState();

  final Rx<List<Product>> _wishlist = Rx<List<Product>>([]);
  List<Product> get userWishlist => _wishlist.value;



  @override
  void onInit() {
    super.onInit();
    getLocallySavedWishlist();
  }

  getLocallySavedWishlist() {
    if(LocalDatabase.to.box.read("wishlist") != null) {
      List<dynamic> retrievedData = LocalDatabase.to.box.read("wishlist");
        print("retrieved product list is => $retrievedData");
      List<Product> convertedData = retrievedData.map((data) => Product.fromJsonDirect(data)).toList();
      _wishlist.value = convertedData;
    }

    // if(LocalDatabase.to.box.read("wishlist") != null) {
    //   final dynamic jsonList = LocalDatabase.to.box.read("wishlist");
    //   print("retrieved product list is => $jsonList");
    //   if (jsonList != null) {
    //     _wishlist.value = jsonList.map((json) => Product.fromJson(json)).toList();
    //   }
    // }
  }

  addOrRemoveBookmark({required BuildContext context, required Product product}) {
    try{
      int productIndex = checkIfExistsInBookmark(id: product.id);
      if(productIndex != -1) {
        _wishlist.value = List<Product>.from(_wishlist.value)
          ..removeAt(productIndex);
        HapticFeedback.lightImpact();
      } else {
        _wishlist.value = List<Product>.from(_wishlist.value)
          ..add(product);
        HapticFeedback.lightImpact();
      }
      LocalDatabase.to.box.write("wishlist", _wishlist.value);
      // HapticFeedback.lightImpact();
      update();
    } catch (e) {
      showToastMessage(message: "Error adding to wishlist $e");
    }
  }

  getProductFromID({required BuildContext context, required String productID}) async{
    try{
      final response = await shopifyStore.getProductsByIds([productID]);
      Product product = response!.first;
      addOrRemoveBookmark(context: context, product: product);
    } catch (e) {
      showToastMessage(message: "Error adding to wishlist $e");

    }


  }

  checkIfExistsInBookmark({required String id}) {
    return _wishlist.value.indexWhere((product) => product.id == id);
  }

}