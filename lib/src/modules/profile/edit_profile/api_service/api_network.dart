import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../api_services/shopify_flutter/shopify/shopify.dart';
import '../../../../global_controllers/database_controller.dart';
import '../../../../utils/global_instances.dart';

updateProfileService({required  String firstName, lastName, email, password, customAccessToken}) async {
  log(" Update Profile list ");
  try {
    final shopifyStore = ShopifyCustomer.instance;
    final userEditProfile = await shopifyStore.customerUpdate(firstName: firstName, lastName: lastName, email: email, password: password, customerAccessToken: customAccessToken);



    debugPrint("=== SUCCESS :: Account Updated ===");

    return true;
  } catch (e) {
    debugPrint("====> ERROR :: in creatig account ${e.toString()} <=====");
    return false;
  }
}