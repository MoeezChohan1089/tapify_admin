import 'dart:developer';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// import 'package:shopify_flutter/models/src/checkout/line_item/line_item.dart';
// import 'package:shopify_flutter/models/src/checkout/product_variant_checkout/product_variant_checkout.dart';
// import 'package:shopify_flutter/models/src/product/option/option.dart';
// import 'package:shopify_flutter/models/src/product/product.dart';
// import 'package:shopify_flutter/models/src/shopify_user/address/address.dart';
// import 'package:shopify_flutter/shopify/src/shopify_store.dart';
import 'package:tapify_admin/src/modules/cart/logic.dart';
import 'package:tapify_admin/src/modules/recently_viewed/state.dart';
import '../../api_services/shopify_flutter/models/src/checkout/line_item/line_item.dart';
import '../../api_services/shopify_flutter/models/src/product/option/option.dart';
import '../../api_services/shopify_flutter/models/src/product/product.dart';
import '../../custom_widgets/customPopupDialogue.dart';
import '../../global_controllers/reviews/reviews_controller.dart';
import '../../utils/global_instances.dart';
import '../recently_viewed/logic.dart';
import 'state.dart';

class ProductDetailLogic extends GetxController {
  static ProductDetailLogic get to => Get.find();
  final ProductDetailState state = ProductDetailState();

  Rx<int> currentImageIndex = 0.obs;
  Rx<int> selectedVariantIndex = 0.obs;
  Rx<int> productQuantity = 1.obs;
  RxBool productDetailLoader = false.obs;
  RxBool isProcessing = false.obs;
  Rx<bool> isLoading = false.obs;
  RxString quickBottomSheet = ''.obs;
  // Rx<String> convertValue = ''.obs;
  // Rx<String> convertValue1 = ''.obs;
  RxBool isRouteOk = false.obs;

  final Rx<List<Product>> productsList = Rx<List<Product>>([]);

  Product? get product =>
      productsList.value.isNotEmpty ? productsList.value.first : null;
  Rx<List<Product>> recommendedProducts = Rx<List<Product>>([]);
  final RefreshController loadMoreController =
      RefreshController(initialRefresh: false);

  CarouselController carouselController = CarouselController();
  TextEditingController notifyController = TextEditingController();

  ///----- Reviews
  Rx<Map> productReviews = Rx<Map>({});

  ///----- Product Variants / Options
  dynamic listOfOptions = [];

  getProductDetailAPICall(
      {required BuildContext context,
      required String productId,
      required bool isCartProductId, bool isViewingDetails = false}) async {
    listOfOptions = [];
    productQuantity.value = 1;
    selectedVariantIndex.value = 0;
    update();

    try {
      productDetailLoader.value = true;
      await resetShopify();
      final response = await shopifyStore.getProductsByIds(isCartProductId
          ? ["gid://shopify/Product/454088830815280"]
          : [productId]);

      // gid://shopify/CheckoutLineItem/454088830815280

      productsList.value = response!;
      productDetailLoader.value = false;

      setListOfOptions();

      productFetchService(context, product!.collectionList![0].id);

      logger.i(productsList.value);

      productDetailLoader.value = false;
      if(isViewingDetails){
        RecentlyViewedLogic.to.addToRecentlyViewed(product: product!);
      }

    } catch (e) {
      productDetailLoader.value = false;
      debugPrint("=== Error Fetching Product Details ==> $e ");
    }
    getProductReviews();
  }

  // productFetchService({required BuildContext context, required String id, bool isNewId = false}) async {
  productFetchService(BuildContext context, String id) async {
    // if(isNewId){
    recommendedProducts.value = [];
    // }

    final previousProductValue = productsList.value.length;

    recommendedProducts.value.isEmpty
        ? productDetailLoader.value = true
        : productDetailLoader.value = false;

    update();
    // productsFetch.value.isEmpty?loadingValue.value = true:loadingValue.value = false;
    // productsFetch.value.isNotEmpty ? loadingValue.value = true : loadingValue.value = false;
    debugPrint("in the product fetch function: ");
    if (recommendedProducts.value.isEmpty) {
      print("===== empty products list ======");
    } else {
      print(
          "===== last cursor of product is ${recommendedProducts.value.last.cursor} ======");
    }
    // customLoader.showLoader(context);
    try {
      // final shopifyStore = ShopifyStore.instance;
      final categoryProducts =
          await shopifyStore.getXProductsAfterCursorWithinCollection(
        id,
        8,
      );

      // productsFetch.addAll(categoryProducts!);
      for (var element in categoryProducts ?? []) {
        recommendedProducts.value.add(element);
      }

      // productsFetch.value.isEmpty ?
      // loadingValue.value = false : loadingValue.value = true;
      productDetailLoader.value = false;
      isLoading.value = false;
      // categoryProductLoader.value = false;

      if (previousProductValue == recommendedProducts.value.length) {
        // Get.showSnackbar(
        //   const GetSnackBar(
        //     isDismissible: true,
        //     message: 'No more products',
        //     duration: Duration(seconds: 2),
        //     backgroundColor: Colors.black,
        //   ),
        // );
      }
      update();
    } catch (e) {
      productDetailLoader.value = false;
      isLoading.value = false;
      debugPrint(" Error in fetching collection ${e.toString()}");
    }
  }

  resetValues() {
    isLoading.value = false;
    productDetailLoader.value = false;
  }

  updateSelectedVariant(
      {required int variantIndex, required int innerOptionIndex}) {
    var subOptions = listOfOptions[variantIndex]['sub_options'];
    for (int i = 0; i < subOptions.length; i++) {
      subOptions[i]['is_selected'] = (i == innerOptionIndex); // Set the tapped option to true, others to false
    }
    returnSelectedAmount(innerOptionIndex);
    update();
  }

  setListOfOptions() {
    for (Option element in product?.option ?? []) {
      if (element.name == "Title") {
        log("=== skips this ====");
      } else {
        dynamic valuesList = [];

        ///--- sub options
        for (var opt in element.values) {
          valuesList.add({
            'is_selected': element.values.indexOf(opt) == 0 ? true : false,
            'name': opt
          });
        }

        ///---- main options
        listOfOptions.add({'name': element.name, 'sub_options': valuesList});
      }
    }
    update();
    // printTheString();
    log("==== length of curated options is ${listOfOptions.length} ====");
  }

  ///------ Return The Selected
  returnSelectedAmount(int innerOptionIndex) {
    log("returned select option string is ${getSelectedOptionsString(innerOptionIndex)}");
    selectedVariantIndex.value = product?.productVariants.indexWhere(
            (element) =>
                element.title == getSelectedOptionsString(innerOptionIndex)) ??
        1;
    int selectedImageIndex = -1;
    for (int i = 0; i < product!.images.length; i++) {
      if (product!.productVariants[selectedVariantIndex.value].image!.id ==
          product!.images[i].id) {
        selectedImageIndex = i;
        break; // Exit the loop once a match is found
      }
    }

    if (selectedImageIndex != -1) {
      carouselController.animateToPage(selectedImageIndex);
    } else {
      // Handle the case when the image index is not found
    }
  }

  String getSelectedOptionsString(int innerOptionIndex) {
    if (listOfOptions.length == 1) {
      // If there is only one item, return the value of 'is_selected' for that item
      return listOfOptions[0]['sub_options'][innerOptionIndex]['name']
          .toString();
    } else {
      // If there are multiple items, concatenate the selected values with '/'
      List<String> selectedOptions = [];

      for (var option in listOfOptions) {
        for (var subOption in option['sub_options']) {
          if (subOption['is_selected']) {
            selectedOptions.add(subOption['name']);
          }
        }
      }
      return selectedOptions.join(' / ');
    }
  }

  getProductReviews() {
    productReviews.value = {};
    final productReviewsInfo = ReviewsListController.to.getProductReviewsList(
        int.parse((product?.id ?? "Product/0").split("Product/")[1]));
    productReviews.value = productReviewsInfo[0];
    log("==== retrieved reviews length is ${productReviewsInfo[0]["review_count"]}  =====");
    log("==== reviews length is ${productReviews.value}  =====");
  }

  ///------ Create Cart / Checkout ID
  addProductToCart(BuildContext context) async {
    // log("value is id======${product?.productVariants[selectedVariantIndex.value].id}=====");
    // log("value is id======${product?.productVariants[selectedVariantIndex.value].title}=====");
    // log("value is id======${product?.id}=====");
    // // log("value is id======${product?.productVariants[selectedVariantIndex.value].id}=====");
    isProcessing.value = true;
    try {
      await CartLogic.to.addToCart(
        context: context,
        fromProductDetailScreen: true,
        lineItem: LineItem(
            title: product?.productVariants[selectedVariantIndex.value].title ??
                "",
            quantity: productQuantity.value,
            id: product?.id,
            variantId:
                product?.productVariants[selectedVariantIndex.value].id ?? "",
            discountAllocations: []),
      );
      isProcessing.value = false;
      update();
    } catch (e) {
      isProcessing.value = false;
    }

    // } else {
    //   Get.showSnackbar(
    //      GetSnackBar(
    //       isDismissible: true,
    //       message: 'Sorry, limit exceeds, Max ${product?.productVariants[selectedVariantIndex.value].quantityAvailable} units available',
    //       duration: const Duration(seconds: 2),
    //       backgroundColor: Colors.black,
    //     ),
    //   );
    // }
  }

}