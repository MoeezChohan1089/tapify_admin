import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shopify_flutter/models/src/product/products/products.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';
import 'package:tapify/src/global_controllers/database_controller.dart';
import 'dart:convert';

import '../../../api_services/shopify_flutter/shopify/shopify.dart';
import '../../home/view.dart';

signOutApiService() async{
  try {
    final shopifyStore = ShopifyAuth.instance;
    await shopifyStore.signOutCurrentUser();
    // LocalDatabase.to.box.remove("customerAccessToken");
    log("=== length of retrieved products  ===");
    // // LocalDatabase.to.box.write("sessionActive", true);
    // List userInfo = [{
    //   "name": "${user.firstName} ${user.lastName}",
    //   "email": "${user.email}"
    // }
    // ];
    // LocalDatabase.to.box.write("userInfo", userInfo);
    // LocalDatabase.to.box.write("customerAccessToken", user.);

    return true;
  } catch (e) {
    debugPrint(" Error in fetching products ${e.toString()}");
    return false;
  }
}

deleteAccountApiService({required String id}) async{
  try {
    final shopifyStore = ShopifyAuth.instance;
    await shopifyStore.deleteCustomer(userId: id);
    // LocalDatabase.to.box.remove("customerAccessToken");
    log("=== length of retrieved products  ===");
    // // LocalDatabase.to.box.write("sessionActive", true);
    // List userInfo = [{
    //   "name": "${user.firstName} ${user.lastName}",
    //   "email": "${user.email}"
    // }
    // ];
    // LocalDatabase.to.box.write("userInfo", userInfo);
    // LocalDatabase.to.box.write("customerAccessToken", user.);

    return true;
  } catch (e) {
    debugPrint(" Error in fetching products ${e.toString()}");
    return false;
  }
}