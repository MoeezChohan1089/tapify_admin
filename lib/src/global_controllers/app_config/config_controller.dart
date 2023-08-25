import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../api_services/shopify_flutter/models/models.dart';
import '../../modules/bottom_nav_bar/view.dart';
import '../../modules/home/models/product_info_model.dart';
import '../../modules/home/view_home.dart';
import '../../modules/splash/logic.dart';
import '../../utils/global_instances.dart';
import '../../utils/tapday_api_srvices/api_services.dart';
import '../currency_controller.dart';
import '../database_controller.dart';
import 'config_json.dart';

class AppConfig extends GetxController {
  static AppConfig get to => Get.find();

  ///----- Loading Variables
  RxBool isLoading = true.obs;
  RxBool isLoadingSplashAnimation = true.obs;
  RxBool innerLoader = false.obs;

  ///------ API JSON
  dynamic jsonData;

  ///------ App Config Variables

  final Rx<List<dynamic>> homeWidgetsList = Rx<List<dynamic>>([]);
  final Rx<List<dynamic>> menuWidgetsList = Rx<List<dynamic>>([]);
  final Rx<List<dynamic>> quickActionWidgetList = Rx<List<dynamic>>([]);


  // var homeWidgetsList = [].obs;
  // var menuWidgetsList = [].obs;
  // RxList<dynamic> homeWidgetsList = RxList<dynamic>([]);
  // RxList<dynamic> menuWidgetsList = RxList<dynamic>([]);

  // Rx<List> homeWidgetsList = Rx<List>().obs;
  //  var menuWidgetsList = Rx([]).obs;
  // var menuWidgetsList = [].obs;
  // List menuWidgetsList = [];

  ///------ For Extracting the IDs (For Easily Getting Data)
  List<String> productIDsList = [];
  List<String> collectionIDsList = [];
  final Rx<List> collectionsWidgetsList = Rx<List>([]);

  // List<String> webUrlsIDsList = [];

  ///----- Products Data
  final Rx<List<ProductInfo>> homeProducts = Rx<List<ProductInfo>>([]);
  final Rx<List<ProductInfo>> collectionProducts = Rx<List<ProductInfo>>([]);
  final Rx<List<ProductInfo>> homeWebURLs = Rx<List<ProductInfo>>([]);

  ///----------- Settings -----------///
  //----- App Settings
  late dynamic appSettingsStoreSettings;
  late dynamic appSettingsCustomerAccount;
  late dynamic appSettingsProductDetailPages;
  late dynamic appSettingsCartAndCheckout;

  //----- Customization
  late dynamic customizationCardGiftPopUp;
  late dynamic customizationDiscountCodePopUp;
  late dynamic customizationFavoritePopUp;
  late dynamic customizationForgetPasswordPopUp;
  late dynamic customizationProductImage;
  late dynamic customizationFilters;
  late dynamic customizationMetaField;

  //------ App Listing
  late dynamic appListingBranding;
  late dynamic appListingListing;
  late dynamic appListingBusinessInformation;

  ///------- App Colors
  dynamic primaryColor = const Color(0xff3B8C6E).obs;
  dynamic secondaryColor = const Color(0xffffffff).obs;
  dynamic chatColor = const Color(0xfff56257).obs;
  dynamic cartColor = const Color(0xfff56257).obs;
  dynamic quickViewTextColor = const Color(0xffffffff).obs;
  dynamic quickViewBGColor = const Color(0xff000000).obs;
  dynamic appbarBGColor = const Color(0xffffffff).obs;
  dynamic iconCollectionColor = const Color(0xff000000).obs;

  ///------- App Icons
  RxInt menuIconIndex = 0.obs;
  RxInt chatIconIndex = 0.obs;
  RxInt cartIconIndex = 1.obs;


  ///------- App Logos
  RxString homeAppBarLogo = ''.obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //
  //   ///----- App Config API
  //   // getAppConfigAPICall();
  // }

  Future<bool> jsonApiCall() async {
    try {
      dio_instance.Response response;
      log("token is ${LocalDatabase.to.box.read("staticUserAuthToken")}");
      dio_instance.Dio dio = dio_instance.Dio();
      var headers = {
        'Authorization': 'Bearer ${LocalDatabase.to.box.read("staticUserAuthToken")}'
      };
      response = await dio.get(
          '${TapDay.adminStructureViewURL}',
          options: dio_instance.Options(headers: headers));
      log("=====> JSON API Response is => ${response.data} <=====");

      Map<String, dynamic> configData = response.data;
      if(response.statusCode == 200 && configData['data'] != null) {
        jsonData = configData['data']['app_json'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("====> Error in calling JSON API => $e <====");
      return false;
    }

  }



  getAppConfigAPICall({bool isRefreshing = false}) async {
    dio_instance.Response response;
    log("token is ${LocalDatabase.to.box.read("staticUserAuthToken")}");
    try {
      isLoadingSplashAnimation.value == true;
      dio_instance.Dio dio = dio_instance.Dio();
      var headers = {
        'Authorization': 'Bearer ${LocalDatabase.to.box.read("staticUserAuthToken")}'
      };

      response = await dio.get(
          '${TapDay.adminStructureViewURL}',
          options: dio_instance.Options(headers: headers));
      print("response code is ${response.statusCode}");
      print("response code is ${response.statusMessage}");
      print("response code is ${response.data}");
      await Future.delayed(const Duration(seconds: 2));
      isLoadingSplashAnimation.value == false;
      LocalDatabase.to.box.read("sessionActive") == true ?  SplashLogic.to.homeWithBottomNav ?  Get.off(() => BottomNavBarPage()) : Get.off(() => HomePage()) :  Get.off(BottomNavBarPage());

    } catch (e) {
      if (e is dio_instance.DioException) {
        isLoadingSplashAnimation.value == false;
        print("Dio error message: ${e.message}");
        if (e.response != null) {
          print("Response data: ${e.response!.data}");
        }
      } else {
        print("Error in getting structure: $e");
      }
      throw "";
    }

    ///---- Decode the JSON
    Map<String, dynamic> configData = response.data;
    jsonData = configData['data']['app_json'];


    ///------------------------------
    await setAppSettings(jsonData["settings"]);
    CurrencyController.to.setMultiCurrency();
    innerLoader.value = true;
    homeWidgetsList.value = jsonData['widgets']["widget"];
    menuWidgetsList.value = jsonData['widgets']["menuItems"];
    log("===== Total Home Widgets Are => ${homeWidgetsList.value.length} ======");
    log("===== Total Menu Widgets Are => ${menuWidgetsList.value.length} ======");
    setColorsAndIcons();
    if (!isRefreshing) {
      checkCachedData();
    }
    await extractIDs();
    if (productIDsList.isNotEmpty) {
      await getProductsDetails();
    }
    if (collectionIDsList.isNotEmpty) {
      await getCollectionDetails();
    }
    isLoading.value = false;
    innerLoader.value = false;
  }


  setupConfigData({bool isRefreshing = false}) async {
    await setAppSettings(jsonData["settings"]);
    CurrencyController.to.setMultiCurrency();
    innerLoader.value = true;

    // domain dynamaic variable
    // print("fsffsfsfsfsfsffsfs: ${jsonData['user']['shops'][0]['domain']}");
    LocalDatabase.to.box.write('domainShop', jsonData['user']['shops'][0]['domain']);



    homeWidgetsList.value = jsonData['widgets']["widget"];
    menuWidgetsList.value = jsonData['widgets']["menuItems"];
    collectionsWidgetsList.value = jsonData['widgets']["collections"];
    quickActionWidgetList.value = jsonData['widgets']['quickAction'];
    log("===== Total Home Widgets Are => ${homeWidgetsList.value.length} ======");
    log("===== Total Menu Widgets Are => ${menuWidgetsList.value.length} ======");
    log("===== Total Quick Widgets Are => ${quickActionWidgetList.value.length} ======");
    setColorsAndIcons();
    if (!isRefreshing) {
      checkCachedData();
    }
    await extractIDs();
    if (productIDsList.isNotEmpty) {
      await getProductsDetails();
    }
    if (collectionIDsList.isNotEmpty) {
      await getCollectionDetails();
    }
    isLoading.value = false;
    innerLoader.value = false;
  }


  checkCachedData() {
    if (LocalDatabase.to.box.read("cachedProducts") != null) {
      log("Yes, products exist in cached");
      List<dynamic> retrievedData = LocalDatabase.to.box.read("cachedProducts");
      List<ProductInfo> convertedData =
      retrievedData.map((data) => ProductInfo.fromJSON(data)).toList();
      homeProducts.value = convertedData;
      isLoading.value = false;
      log("Successfully retrieved cached products: ${homeProducts.value.length}");
    }

    //
    //   if (LocalDatabase.to.box.read("cachedProducts") != null) {
    //
    //     log("yes products exists in cached");
    //
    //     List<ProductInfo> retrievedData = LocalDatabase.to.box.read("cachedProducts");
    // log("===>  Locally Saved Products Data is $retrievedData  <====");
    // // if (retrievedData is List<ProductInfo>) {
    //   // List<ProductInfo> convertedData = retrievedData
    //   //     .map((data) => ProductInfo.fromJSON(data))
    //   //     .toList();
    //   homeProducts.value = retrievedData;
    //   // homeProducts.value = convertedData;
    //   isLoading.value = false;
    // // } else {
    // //   debugPrint('Invalid data type: $retrievedData');
    // //  }
    // }

    // if (LocalDatabase.to.box.read("cachedCollections") != null) {
    //   dynamic retrievedData = LocalDatabase.to.box.read("cachedCollections");
    //   log("===>  Locally Saved Products Data is $retrievedData  <====");
    //   if (retrievedData is List<dynamic>) {
    //     List<ProductInfo> convertedData = retrievedData
    //         .map((data) => ProductInfo.fromCollection(data))
    //         .toList();
    //     homeProducts.value = convertedData;
    //     isLoading.value = false;
    //   } else {
    //     debugPrint('Invalid data type: $retrievedData');
    //   }
    // }
  }

  ///--------- Extract IDs from JSON
  extractIDs() {
    Set<String> productIDs = {};
    Set<String> collectionIDs = {};
    List<ProductInfo> webUrlsIDs = [];
    // Set<String> webUrlsIDs = {};

    for (var element in homeWidgetsList.value) {
      if (element['settings'] != null) {
        var metadata = element['settings']['metadata'];
        if (metadata != null && metadata.containsKey('data')) {
          dynamic data = List<Map<String, dynamic>>.from(
            metadata['data'],
          );

          if (metadata['dataType'] == "product") {
            //------ Product IDs
            for (var item in data) {
              if (item.containsKey('id')) {
                String id = item['id'].toString();
                String concatenatedString = "gid://shopify/Product/$id";
                productIDs.add(concatenatedString);
              }
            }
          } else if (metadata['dataType'] == "collection") {
            //----- Collection IDs
            for (var item in data) {
              if (item.containsKey('id')) {
                String id = item['id'].toString();
                String concatenatedString = "gid://shopify/Collection/$id";
                collectionIDs.add(concatenatedString);
              }
            }
          } else {
            for (var item in data) {
              String webUrl = item['web_url'] ?? '';
              String id = item['id'] ?? '';
              String title = item['title'] ?? '';
              String imageName = item['path'] ?? '';


              ProductInfo productInfo = ProductInfo(
                id: id,
                title: title,
                price: 0.0,
                compareAtPrice: 0.0,
                availableForSale: false,
                // Set the default price for web URLs
                image: imageName,
                webUrl: webUrl,
              );
              webUrlsIDs.add(productInfo);
            }

            ///----- Web URLs
            // for (var item in data) {
            //   if (item.containsKey('id')) {
            //     String id = item['id'].toString();
            //     String concatenatedString = id;
            //     webUrlsIDs.add(concatenatedString);
            //   }
            // }
          }
        }
      }
    }
    productIDsList = productIDs.toList();
    collectionIDsList = collectionIDs.toList();
    homeWebURLs.value = webUrlsIDs;

    log("Length of web urls ${homeWebURLs.value.length}");
  }

  ///---------- Set Colors & Icons
  setColorsAndIcons() {
    log("=== in the colors function ${jsonData["color"]} ===");

    ///---- Assigning Colors
    primaryColor.value =
        jsonData["color"]["colorSettings"]["primaryColor"].toString().toColor();
    secondaryColor.value = jsonData["color"]["colorSettings"]["secondaryColor"]
        .toString()
        .toColor();
    chatColor.value =
        jsonData["color"]["colorSettings"]["chatColor"].toString().toColor();
    cartColor.value =
        jsonData["color"]["colorSettings"]["cartColor"].toString().toColor();
    quickViewTextColor.value =
        jsonData["color"]["colorSettings"]["textColor"].toString().toColor();
    quickViewBGColor.value = jsonData["color"]["colorSettings"]
    ["backgorundColor"]
        .toString()
        .toColor();
    appbarBGColor.value = jsonData["color"]["colorSettings"]["topbarColor"].toString().toColor();
    iconCollectionColor.value = jsonData["color"]["colorSettings"]["iconColor"].toString().toColor();

    ///---- Assign Icons
    menuIconIndex.value = jsonData["color"]["colorSettings"]["menuIcon"];
    chatIconIndex.value = jsonData["color"]["colorSettings"]["chatIcon"];
    cartIconIndex.value = jsonData["color"]["colorSettings"]["cartIcon"];

    ///----- Assign Logos
    homeAppBarLogo.value = jsonData["color"]["colorSettings"]['logoIcon'] ?? "";
  }

  ///--------- Fetch Products Details
  getProductsDetails() async {
    log("Length of Product IDs before ===> ${productIDsList.length}");
    try {
      final response = await shopifyStore.getProductsByIds(productIDsList);
      // homeProducts.value = response ?? [];

      final List<ProductInfo> productInfo = response
          ?.map((product) => ProductInfo.fromProduct(product))
          .toList() ??
          [];

      homeProducts.value = productInfo;

      // innerLoader.value = false;
      // isLoading.value = false;

      // LocalDatabase.to.box.write("cachedProducts", homeProducts.value);

      LocalDatabase.to.box.write(
        "cachedProducts",
        homeProducts.value.map((product) => product.toJSON()).toList(),
      );

      log("==== SUCCESS retrieved first home products ===> ${homeProducts.value.length}  ====");
    } catch (e) {
      // isLoading.value = false;
      // innerLoader.value = false;
      log("==== ERROR in fetching first home collections ==> $e ====");
    }
  }

  ///--------- Fetch Collection Details
  getCollectionDetails() async {
    log("Length of Collection IDs before ===> $collectionIDsList");

    try {
      final response =
      await shopifyStore.getCollectionsByIds(collectionIDsList);

      log("====> Response from Collection Call is $response <=====");

      final List<ProductInfo> collectionsInfo = response
          ?.map((collection) => ProductInfo.fromCollection(collection))
          .toList() ??
          [];

      collectionProducts.value = collectionsInfo;

      // innerLoader.value = false;
      // isLoading.value = false;

      // LocalDatabase.to.box.write("cachedCollections", collectionProducts.value);

      log("==== SUCCESS retrieved first collections products ===> ${collectionProducts.value.length}  ====");
    } catch (e) {
      // isLoading.value = false;
      // innerLoader.value = false;
      log("==== ERROR in fetching first home collections ==> $e ====");
    }
  }

  ///-------- Return Product Info From List
  ProductInfo? getProductById({required dynamic id, required String dataType}) {
    try {
      switch (dataType) {
        case "product":
          return homeProducts.value.firstWhere(
                  (product) => product.id == "gid://shopify/Product/$id");
        case "collection":
          return collectionProducts.value.firstWhere(
                  (product) => product.id == "gid://shopify/Collection/$id");
        default:
          return homeWebURLs.value.firstWhere((product) => product.id == id);
      }
    } catch (e) {
      return null;
    }
  }

  ///-------- Assigning the Settings From JSON
  setAppSettings(Map<String, dynamic> settingsJSON) {
    appSettingsStoreSettings = settingsJSON["appSettings"]["storeSetting"];
    appSettingsCustomerAccount = settingsJSON["appSettings"]["customerAccount"];
    appSettingsProductDetailPages =
    settingsJSON["appSettings"]["productDetailPages"];
    appSettingsCartAndCheckout = settingsJSON["appSettings"]["cartAndCheckout"];

    //----- Customization
    customizationCardGiftPopUp = settingsJSON["customization"]["cardGiftPopup"];
    customizationDiscountCodePopUp =
    settingsJSON["customization"]["discountCodePopup"];
    customizationFavoritePopUp = settingsJSON["customization"]["favoritePopup"];
    customizationForgetPasswordPopUp =
    settingsJSON["customization"]["forgatPasswordPopup"];
    customizationProductImage = settingsJSON["customization"]["productImage"];
    customizationFilters = settingsJSON["customization"]["filters"];
    customizationMetaField = settingsJSON["customization"]["metafield"];

    //------ App Listing
    appListingBranding = settingsJSON["appListing"]["branding"];
    appListingListing = settingsJSON["appListing"]["listing"];
    appListingBusinessInformation =
    settingsJSON["appListing"]["bussnessInformation"];
  }
}