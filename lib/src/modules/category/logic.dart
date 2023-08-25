

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:shopify_flutter/models/models.dart';
// import 'package:shopify_flutter/shopify/shopify.dart';

import '../../api_services/shopify_flutter/enums/enums.dart';
import '../../api_services/shopify_flutter/models/models.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../utils/global_instances.dart';
import 'api_service/api_service_category.dart';
import 'api_service/model_filters.dart';
import 'state.dart';

class CategoryLogic extends GetxController {
  static CategoryLogic get to => Get.find();
  final CategoryState state = CategoryState();
  Rx<bool> isLoading = false.obs;
  List<Collection> categoryCollection = [];
  List<Product> categoryProductCollection = [];
  List<int> productLength = [];
  RxList<Product> productsFetch = RxList<Product>();
  RxBool loadingValue = false.obs;
  Rx<bool> categoryProductLoader = false.obs;
  final RefreshController loadMoreController =
  RefreshController(initialRefresh: false);
  SortKeyProductCollection sortKeyProduct = SortKeyProductCollection.TITLE;
  List<Map<String, dynamic>>  selectedFilters = [];
  RxBool showFilteredProducts = false.obs;
  RxString currentCategoryId = "".obs;
  double priceRangeMin = 0.0;
  double priceRangeMax = 0.0;
  bool _noMoreProductsShown = false;

  ///-------- Filters
  List<Filter> filtersAvailable = [];

  @override
  void onInit() {
    super.onInit();
    categoryService();
  }

  categoryService() async {
    // debugPrint("value of list> ${categoryCollection.length}");
    try {
      // final shopifyStore = ShopifyStore.instance;
      final categoryProducts = await shopifyStore.getAllCollections();
      categoryCollection = categoryProducts;
      // debugPrint("value of category list > ${categoryCollection.length}");
      await categoryProductService();
      update();
      customLoader.hideLoader();
      return true;
    } catch (e) {
      print("Error getting collections => $e");
      // showToastMessage(message: "Something went wrong");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Something went wrong',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      return false;
    }
  }


  categoryProductService() async {
    // debugPrint("value of list1111> $categoryProductCollection");
    try {
      categoryProductLoader.value = true;
      // final shopifyStore = ShopifyStore.instance;
      categoryProductCollection = []; // Initialize as empty list
      productLength = []; // Initialize as empty map
      List<Future> futures = [];
      for (int i = 0; i < categoryCollection.length; i++) {
        Future future = shopifyStore
            .getAllProductsFromCollectionById(categoryCollection[i].id)
            .then((categoryProducts) {
          categoryProductCollection.addAll(categoryProducts); // Merge products to the list
          productLength.add(categoryProducts.length); // Add length to the list
// Add length to the map with category id as key
//           debugPrint(
//               "new value of ${categoryCollection.indexOf(categoryCollection[i])} $productLength");
        });
        futures.add(future);
      }
      await Future.wait(futures);
      categoryProductLoader.value = false;
      return true;
    } catch (e) {
      categoryProductLoader.value = false;
      debugPrint("Error in products length API $e");
      showToastMessage(message: "Something went wrong");
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     isDismissible: true,
      //     message: 'Something went wrong',
      //     duration: Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      customLoader.hideLoader();
      return false;
    }
  }




  // categoryProductService() async {
  //   debugPrint("value of list1111> $categoryProductCollection");
  //   try {
  //
  //     categoryProductLoader.value = true;
  //     final shopifyStore = ShopifyStore.instance;
  //     List<Future> futures = [];
  //     for (int i = 0; i < categoryCollection.length; i++) {
  //       Future future = shopifyStore
  //           .getAllProductsFromCollectionById(categoryCollection[i].id)
  //           .then((categoryProducts) {
  //         categoryProductCollection = categoryProducts;
  //         productLength.add(categoryProductCollection.length);
  //         debugPrint(
  //             "new value of ${categoryCollection.indexOf(categoryCollection[i])} ${productLength} :: ${productLength[i]}");
  //       });
  //       futures.add(future);
  //     }
  //     await Future.wait(futures);
  //     categoryProductLoader.value = false;
  //     return true;
  //
  //     // categoryProductLoader.value = true;
  //     // for (int i = 0; i < categoryCollection.length; i++) {
  //     //   final shopifyStore = ShopifyStore.instance;
  //     //   final categoryProducts = await shopifyStore
  //     //       .getAllProductsFromCollectionById(categoryCollection[i].id);
  //     //   categoryProductCollection = categoryProducts;
  //     //   productLength.add(categoryProductCollection.length);
  //     //   // Update the productLength list
  //     //   categoryProductLoader.value = false;
  //     //   debugPrint(
  //     //       "new value of ${categoryCollection.indexOf(categoryCollection[i])} ${productLength} :: ${productLength[i]}");
  //     // }
  //     // return true;
  //   } catch (e) {
  //     categoryProductLoader.value = false;
  //     debugPrint("Error in getting categories products API $e");
  //     Get.showSnackbar(
  //       const GetSnackBar(
  //         isDismissible: true,
  //         message: 'Something went wrong',
  //         duration: Duration(seconds: 2),
  //         backgroundColor: Colors.black,
  //       ),
  //     );
  //     customLoader.hideLoader();
  //     return false;
  //   }
  // }

  fetchProductBasedOnFilters({required BuildContext context, bool isNewId = false, SortKeyProductCollection sortKey = SortKeyProductCollection.TITLE}) async {
    // if(isNewId){
    productsFetch.value = [];
    // }

    update();


    // final previousProductValue = productsFetch.value.length;
    productsFetch.value.isEmpty ? loadingValue.value = true : loadingValue.value = false;
    update();
    debugPrint("filter api function");

    try {
      final categoryProducts = await shopifyStore.getFilteredXProductsAfterCursorWithinCollection(
        currentCategoryId.value,
        250,
        selectedFilters.length == 1 ? selectedFilters[0] : selectedFilters,
        startCursor: showFilteredProducts.isTrue ? productsFetch.value.isEmpty ? null : productsFetch.value.last.cursor : null,
        sortKey: sortKey,
      );
      showFilteredProducts.value = true;
      for(var element in categoryProducts ?? []) {
        productsFetch.value.add(element);
      }
      log("length of products is ${productsFetch.length}");
      loadingValue.value = false;
      isLoading.value = false;
      update();
    } catch (e) {
      loadingValue.value = false;
      isLoading.value = false;
      debugPrint(" Error in fetching filter products ${e.toString()}");
    }
  }





  resetFilters() {
    selectedFilters = [];
    showFilteredProducts = false.obs;
    update();
  }

  productFetchService({required BuildContext context, required String id, bool isNewId = false, SortKeyProductCollection sortKey = SortKeyProductCollection.TITLE}) async {
    currentCategoryId.value = id;
    if(isNewId){
      productsFetch.value = [];
    }

    final previousProductValue = productsFetch.value.length;

    productsFetch.value.isEmpty ? loadingValue.value = true : loadingValue.value = false;

    update();
    // productsFetch.value.isEmpty?loadingValue.value = true:loadingValue.value = false;
    // productsFetch.value.isNotEmpty ? loadingValue.value = true : loadingValue.value = false;
    debugPrint("in the product fetch function: ");

    if(productsFetch.value.isEmpty) {
      print("===== empty products list ======");
    } else {
      print("===== last cursor of product is ${productsFetch.value.last.cursor} ======");
    }
    // customLoader.showLoader(context);
    try {
      // final shopifyStore = ShopifyStore.instance;
      final categoryProducts = await shopifyStore.getXProductsAfterCursorWithinCollection(id, 10,
          startCursor: productsFetch.value.isEmpty ? null : productsFetch.value.last.cursor,
          sortKey: sortKey,
      );



      ///----- Call the Filters API here
      if(productsFetch.isEmpty) {
        print("handle to be fetched is ${categoryProducts![0].collectionList![0].handle}");
        filtersAvailable =  await getCollectionFilters(
          collectHandle: categoryProducts[0].collectionList![0].handle!,
        );
      }

      // productsFetch.addAll(categoryProducts!);
      for(var element in categoryProducts ?? []) {
        productsFetch.value.add(element);
      }

      // productsFetch.value.isEmpty ?
      // loadingValue.value = false : loadingValue.value = true;
      loadingValue.value = false;
      isLoading.value = false;
      // categoryProductLoader.value = false;

      if(previousProductValue == productsFetch.value.length){
        if(!_noMoreProductsShown){
          // showToastMessage(message: "No more products");
          // Get.showSnackbar(
          //   const GetSnackBar(
          //     isDismissible: true,
          //     message: 'No more products',
          //     duration: Duration(seconds: 2),
          //     backgroundColor: Colors.black,
          //   ),
          // );
          _noMoreProductsShown = true;
        }
      }
      update();
    } catch (e) {
      loadingValue.value = false;
      isLoading.value = false;
      debugPrint(" Error in fetching collection ${e.toString()}");
      update();
    }
  }

  resetValues() {
    _noMoreProductsShown = false;
    isLoading.value = false;
    showFilteredProducts.value = false;
    loadingValue.value = false;
  }

}