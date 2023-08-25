import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:tapify/src/utils/tapday_api_srvices/api_services.dart';

import '../api_services/shopify_flutter/shopify/shopify.dart';
import '../api_services/shopify_flutter/shopify_config.dart';
import '../custom_widgets/customLoaderWidget.dart';
import '../custom_widgets/custom_loader.dart';
import '../global_controllers/database_controller.dart';

///----- For Circular Loader Indicator
final CustomLoader customLoader = CustomLoader();
final CustomLoaderWidget customLoaderWidget = CustomLoaderWidget();

///----- For Printing Logs
final Logger logger = Logger();

///----- Shopify Instances
ShopifyStore shopifyStore = ShopifyStore.instance;
ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
ShopifyAuth shopifyAuth = ShopifyAuth.instance;


resetShopify() {
  ShopifyConfig.setConfig(
    storefrontAccessToken: '${TapDay.storeFrontAccessToken}',
    // adminAccessToken: "${LocalDatabase.to.box.read("storeAdminToken")}",
    storeUrl: LocalDatabase.to.box.read('domainShop') ?? '${TapDay.shopNameUrl}',
    // storefrontApiVersion: '2023-01',
  );
}


Future<String> fetchRandomImage() async {

  // return "https://images.unsplash.com/photo-1599032909756-5deb82fea3b0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=464&q=80";
  // return "https://images.unsplash.com/photo-1615395886070-57612cbe1dd7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=388&q=80";
  // return "https://images.unsplash.com/photo-1544376798-89aa6b82c6cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80";

  var dio = Dio();
  var response = await dio.request(
    '${TapDay.adminSplashURL}',
    options: Options(
      method: 'GET',
    ),
  );

  if (response.statusCode == 200) {
    print("value of splash json: ${json.encode(response.data)}" );
    return (response.data['data'] == null || response.data['data'] == "") ? "" : response.data['data']['package_id'];
  }
  else {
    print(response.statusMessage);
    return "https://c4.wallpaperflare.com/wallpaper/536/854/415/alexandra-daddario-4k-pc-desktop-hd-wallpaper-preview.jpg";
  }

  // final dio = Dio();
  //
  // try {
  //   final response = await dio.get<List<int>>(
  //     'https://picsum.photos/200/300',
  //     options: Options(responseType: ResponseType.bytes),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     log("Response is $response <====");
  //     return response.data!;
  //   } else {
  //     throw Exception('Failed to load image');
  //   }
  // } catch (error) {
  //   throw Exception('Failed to load image');
  // }
}