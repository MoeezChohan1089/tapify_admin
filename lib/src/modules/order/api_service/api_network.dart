// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';
//
// import '../../global_controllers/database_controller.dart';
//
// getAllOrders({required String token, required List<Order> order}) async {
//   try {
//     ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
//     final userInfoResponse = await shopifyCheckout.getAllOrders(token, reverse: true);
//     order = userInfoResponse!;
//     log("fetch data of order value ====== $order ======");
//     return true;
//   } catch (e) {
//     debugPrint(" Error in order ${e.toString()}");
//     return false;
//   }
// }


