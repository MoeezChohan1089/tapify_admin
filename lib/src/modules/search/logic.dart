import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:shopify_flutter/enums/src/sort_key_product.dart';
// import 'package:shopify_flutter/models/src/product/product.dart';
// import 'package:shopify_flutter/shopify/src/shopify_store.dart';
import 'package:tapify/src/global_controllers/database_controller.dart';

import '../../api_services/shopify_flutter/enums/enums.dart';
import '../../api_services/shopify_flutter/models/models.dart';
import '../../api_services/shopify_flutter/models/src/product/product.dart';
import '../../api_services/shopify_flutter/shopify/shopify.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../global_controllers/database_controller.dart';
import '../../utils/global_instances.dart';
import '../cart/logic.dart';
import 'state.dart';

class SearchLogic extends GetxController {
  static SearchLogic get to => Get.find();
  final SearchState state = SearchState();
  final RefreshController loadMoreController =
  RefreshController(initialRefresh: false);


  ///------ Variables
  Rx<bool> isLoading = false.obs;
  Rx<bool> isInnerLoading = false.obs;
  Rx<bool> showSearchedResult = false.obs;
  SortKeyProduct sortKeyProduct = SortKeyProduct.TITLE;
  final searchTextController = TextEditingController();
  final Rx<List<Product>> searchResultProducts = Rx<List<Product>>([]);
  List<Product> get searchedProducts => searchResultProducts.value.isNotEmpty ? searchResultProducts.value : [];
  bool _noMoreProductsShown = false;

  ///----- Paginated Search Result
  Future getPaginatedSearchProducts({bool isNewSearch = false, SortKeyProduct sortKey = SortKeyProduct.TITLE}) async {

    if(isNewSearch){
      searchResultProducts.value = [];
    } else {

    }

    // Check if the search text contains special characters
    RegExp specialCharsSearch = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (specialCharsSearch.hasMatch(searchTextController.text)) {
      // Special characters found, do not execute the search
      return;
    }

    ///----- Checker if New Products Added
    var previousProducts = searchResultProducts.value.length;
    showSearchedResult.value = true;
    searchResultProducts.value.isEmpty ? isLoading.value = true : isLoading.value = false;
    searchResultProducts.value.isNotEmpty ? isInnerLoading.value = true : isInnerLoading.value = false;
    if(searchResultProducts.value.isEmpty){
      print("===== empty products list ======");
    } else {
      print("===== last cursor of product is ${searchResultProducts.value.last.cursor} ======");
    }

    List<dynamic> recentSearches = LocalDatabase.to.box.read('recentSearch') ?? [];

    String searchText = searchTextController.text.trim();

    RegExp specialCharsRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!recentSearches.contains(searchText) && !specialCharsRegex.hasMatch(searchText) && searchText.isNotEmpty) {
      recentSearches.add(searchText);
    }

    LocalDatabase.to.box.write('recentSearch', recentSearches);


    update();

    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;

      final response = await shopifyStore.getXProductsOnQueryAfterCursor(
         searchTextController.text,
         10,
        searchResultProducts.value.isEmpty ? null : searchResultProducts.value.last.cursor ?? "",
        sortKey: sortKey
      );

      for(var element in response ?? []) {

        print("available for sale is ${element.availableForSale}");

        if(AppConfig.to.appSettingsStoreSettings["displaySoldoutInSearch"]){
          searchResultProducts.value.add(element);
        } else {
          if(element.availableForSale == true) {
            searchResultProducts.value.add(element);
          }
        }
      }



      searchResultProducts.value.isEmpty ?
      showSearchedResult.value = false : showSearchedResult.value = true;
      isLoading.value = false;
      isInnerLoading.value = false;

      if(previousProducts == searchResultProducts.value.length){
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
      log("==== SUCCESS retrieved products ===> ${searchResultProducts.value.length}  ====");

    } catch (e) {
      showSearchedResult.value = false;
      isLoading.value = false;
      update();
      log("==== ERROR in fetching products ==> $e ====");
    }

  }

  Future getPaginatedSearchProductsByRecentTitle({bool isNewSearch = false, required String recentTitle, SortKeyProduct sortKey = SortKeyProduct.TITLE}) async {


    searchTextController.text = recentTitle;

    if(isNewSearch){
      searchResultProducts.value = [];
    } else {

    }

    // Check if the search text contains special characters
    RegExp specialCharsSearch = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (specialCharsSearch.hasMatch(recentTitle)) {
      // Special characters found, do not execute the search
      return;
    }

    ///----- Checker if New Products Added
    var previousProducts = searchResultProducts.value.length;
    showSearchedResult.value = true;
    searchResultProducts.value.isEmpty ? isLoading.value = true : isLoading.value = false;
    searchResultProducts.value.isNotEmpty ? isInnerLoading.value = true : isInnerLoading.value = false;
    if(searchResultProducts.value.isEmpty){
      print("===== empty products list ======");
    } else {
      print("===== last cursor of product is ${searchResultProducts.value.last.cursor} ======");
    }

    List<dynamic> recentSearches = LocalDatabase.to.box.read('recentSearch') ?? [];

    String searchText = recentTitle.trim();

    RegExp specialCharsRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    if (!recentSearches.contains(searchText) && !specialCharsRegex.hasMatch(searchText) && searchText.isNotEmpty) {
      recentSearches.add(searchText);
    }

    LocalDatabase.to.box.write('recentSearch', recentSearches);


    update();

    try {
      ShopifyStore shopifyStore = ShopifyStore.instance;

      final response = await shopifyStore.getXProductsOnQueryAfterCursor(
          recentTitle,
          6,
          searchResultProducts.value.isEmpty ? null : searchResultProducts.value.last.cursor ?? "",
          sortKey: sortKey
      );

      for(var element in response ?? []) {
        searchResultProducts.value.add(element);
      }

      searchResultProducts.value.isEmpty ?
      showSearchedResult.value = false : showSearchedResult.value = true;
      isLoading.value = false;
      isInnerLoading.value = false;
      if(previousProducts == searchResultProducts.value.length){
        // showToastMessage(message: "No more products");
      }
      update();
      log("==== SUCCESS retrieved products ===> ${searchResultProducts.value.length}  ====");

    } catch (e) {
      showSearchedResult.value = false;
      isLoading.value = false;
      update();
      log("==== ERROR in fetching products ==> $e ====");
    }

  }


  ///----
  ///----------- Page Functions -----------///
  ///----
  // getSearchedProducts() async {
  //   log("====== in the search products field =======");
  //   showSearchedResult.value = true;
  //   isLoading.value = true;
  //
  //
  //   try {
  //     final response = await shopifyStore.getAllProductsOnQuery(
  //       "",
  //       searchTextController.text
  //     );
  //     _searchResultProducts.value = response ?? [];
  //
  //     _searchResultProducts.value.isEmpty ?
  //       showSearchedResult.value = false : showSearchedResult.value = true;
  //
  //     isLoading.value = false;
  //     log("==== SUCCESS retrieved products ===> ${_searchResultProducts.value}  ====");
  //   } catch (e) {
  //     showSearchedResult.value = false;
  //     isLoading.value = false;
  //     log("==== ERROR in fetching home products ==> $e ====");
  //   }
  //
  //
  //
  // }

  // addProductToCart({required BuildContext context, index}) {
  //
  //   // log("value is ${product?.productVariants[selectedVariantIndex.value].manageInventory}");
  //
  //   // if(productQuantity.value <= (product?.productVariants[selectedVariantIndex.value].quantityAvailable ?? 1)) {
  //   CartLogic.to.addToCart(context: context, lineItem:
  //   LineItem(
  //       title: searchedProducts[index].title ?? "",
  //       quantity: 1,
  //       // id: product?.id ?? "",
  //       variantId: searchedProducts[index].id ?? "",
  //       discountAllocations: []
  //   )
  //   );
  //   // } else {
  //   //   Get.showSnackbar(
  //   //      GetSnackBar(
  //   //       isDismissible: true,
  //   //       message: 'Sorry, limit exceeds, Max ${product?.productVariants[selectedVariantIndex.value].quantityAvailable} units available',
  //   //       duration: const Duration(seconds: 2),
  //   //       backgroundColor: Colors.black,
  //   //     ),
  //   //   );
  //   // }
  //
  //
  // }


  ///----- Reset Values
  resetValues() {
    // _searchResultProducts.value = [];
    _noMoreProductsShown = false;
     isLoading.value = false;
     showSearchedResult.value = false;
     searchTextController.clear();
  }






}