import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:tapify_admin/src/utils/tapday_api_srvices/api_services.dart';

import '../admin_modules/home/logic.dart';
import '../api_services/shopify_flutter/shopify/shopify.dart';
import '../api_services/shopify_flutter/shopify_config.dart';
import '../custom_widgets/customLoaderWidget.dart';
import '../custom_widgets/custom_loader.dart';

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
    storefrontAccessToken: AdminHomeLogic.to.browsingStorefrontToken.value,
    // storefrontAccessToken: TapDay.storeFrontAccessToken,
    // adminAccessToken: "${LocalDatabase.to.box.read("storeAdminToken")}",
    storeUrl: AdminHomeLogic.to.browsingShopDomain.value,
    // storeUrl: AdminHomeLogic.to.browsingShopDomain.value ?? TapDay.shopNameUrl,
  );
}

Future<String> fetchShopSplashImage(String storeName) async {
  var dio = Dio();
  var response = await dio.request(
    "${TapDay.clientSplashImageURL}?store=$storeName",
    options: Options(
      method: 'GET',
    ),
  );
  if (response.statusCode == 200) {
    log("value of splash json: ${json.encode(response.data)}");
    return (response.data['data'] == null || response.data['data'] == "")
        ? ""
        : response.data['data']['package_id'];
  } else {
    log("${response.statusMessage}");
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
