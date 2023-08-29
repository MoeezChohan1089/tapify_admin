import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../api_services/shopify_flutter/models/models.dart';
import '../api_services/shopify_flutter/models/src/product/option/option.dart';
import '../api_services/shopify_flutter/models/src/product/product.dart';
import '../api_services/shopify_flutter/models/src/product/product_variant/product_variant.dart';
import '../global_controllers/app_config/config_controller.dart';
import '../global_controllers/currency_controller.dart';
import '../modules/cart/components/product_added_to_cart_sheet.dart';
import '../modules/cart/logic.dart';
import '../modules/home/models/product_info_model.dart';
import '../modules/product_detail/view_product_detail.dart';
import '../utils/constants/assets.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/margins_spacnings.dart';
import '../utils/global_instances.dart';
import 'custom_elevated_button.dart';
import 'custom_snackbar.dart';

class ProductSheet extends GetxController {
  static ProductSheet get to => Get.find();
  var listOfOptions = [];

  RxBool isProcessing = false.obs;
  Rx<int> selectedVariantIndex = (-1).obs;
  Rx<List<ProductVariant>> variantsList = Rx<List<ProductVariant>>([]);
  Rx<List<Option>> options = Rx<List<Option>>([]);
  RxString selectedOptions = "".obs;
  bool get directNavigateToCheckout =>
      AppConfig.to.appSettingsCartAndCheckout["navigationCustomers"];

  late Product? controllerProduct;

  set setProduct(Product value) {
    controllerProduct = value;
  }

  // setListOfOptions(Product product) {
  //   for (Option element in product.option ?? []) {
  //     if (element.name == "Title") {
  //       log("=== skips this ====");
  //     } else {
  //       dynamic valuesList = [];
  //
  //       ///--- sub options
  //       for (var opt in element.values) {
  //         valuesList.add({
  //           'is_selected': element.values.indexOf(opt) == 0 ? true : false,
  //           'name': opt
  //         });
  //       }
  //
  //       ///---- main options
  //       listOfOptions.add({'name': element.name, 'sub_options': valuesList});
  //     }
  //   }
  //   // update();
  //   // printTheString();
  //   log("==== length of curated options is ${listOfOptions.length} ====");
  // }

  // updateSelectedVariant({required int variantIndex,
  //   required int innerOptionIndex,
  //   required Product product}) {
  //   var subOptions = listOfOptions[variantIndex]['sub_options'];
  //   for (int i = 0; i < subOptions.length; i++) {
  //     subOptions[i]['is_selected'] = (i ==
  //         innerOptionIndex); // Set the tapped option to true, others to false
  //   }
  //   returnSelectedAmount(innerOptionIndex, product);
  //   update();
  // }

  // returnSelectedAmount(int innerOptionIndex, Product product) {
  //   log("returned select option string is ${getSelectedOptionsString(
  //       innerOptionIndex)}");
  //   selectedVariantIndex.value = product.productVariants.indexWhere((element) =>
  //   element.title == getSelectedOptionsString(innerOptionIndex)) ??
  //       1;
  // }

  // String getSelectedOptionsString(int innerOptionIndex) {
  //   if (listOfOptions.length == 1) {
  //     // If there is only one item, return the value of 'is_selected' for that item
  //     return listOfOptions[0]['sub_options'][innerOptionIndex]['name']
  //         .toString();
  //   } else {
  //     // If there are multiple items, concatenate the selected values with '/'
  //     List<String> selectedOptions = [];
  //
  //     for (var option in listOfOptions) {
  //       for (var subOption in option['sub_options']) {
  //         if (subOption['is_selected']) {
  //           selectedOptions.add(subOption['name']);
  //         }
  //       }
  //     }
  //     return selectedOptions.join(' / ');
  //   }
  // }

  ///------- new variants ---------///

  setListOfVariantsAndOptions(Product product) {
    variantsList.value = product.productVariants;
    options.value = product.option;
    setSelectedVariantByDefault();
    update();
  }

  void setSelectedVariantByDefault() {
    for (ProductVariant variant in variantsList.value) {
      if (variant.availableForSale) {
        // setState(() {
        selectedOptions.value = variant.title;
        // });
        update();
        break;
      }
    }
    print("first selected is $selectedOptions");
    if (selectedOptions.value != "") {
      selectedVariantIndex.value =
          findMatchingVariantIndex(selectedOptions.value);
    } else {
      selectedVariantIndex.value = 0;
    }
  }

  void _onOptionSelected(String optionValue, int index) {
    List<String> newSelectedOptions = selectedOptions.value.split(' / ');

    // Update the value at the specified index
    newSelectedOptions[index] = optionValue;

    // setState(() {
    selectedOptions.value = newSelectedOptions.join(' / ');
    // });
    update();

    selectedVariantIndex.value =
        findMatchingVariantIndex(selectedOptions.value);
    log("Selected Variant Index: ${selectedVariantIndex.value}");
  }

  int findMatchingVariantIndex(String selectedOptions) {
    List<String> selectedOptionsList = selectedOptions.split(' / ');

    for (int i = 0; i < variantsList.value.length; i++) {
      String variantTitle = variantsList.value[i].title;
      List<String> variantOptions = variantTitle.split(' / ');

      if (variantOptions.length != selectedOptionsList.length) {
        continue;
      }

      bool allOptionsMatch = true;
      for (int j = 0; j < variantOptions.length; j++) {
        if (variantOptions[j] != selectedOptionsList[j]) {
          allOptionsMatch = false;
          break;
        }
      }

      if (allOptionsMatch) {
        return i; // Match found
      }
    }
    return -1; // No match found
  }

  bool isOptionAvailable(int index, String newValue) {
    if (selectedOptions.value != "") {
      List<String> optionsList = selectedOptions.value.split(' / ');
      optionsList[index] = newValue;
      final optionString = optionsList.join(' / ');
      int variantIndex = findMatchingVariantIndex(optionString);
      return variantIndex != -1 &&
          variantsList.value[variantIndex].availableForSale;
    }
    // Return a default value (e.g., false) when the conditions are not met.
    return false;
  }

  bool isOptionSelected(int index, String value) {
    if (selectedOptions.value != "") {
      List<String> optionsList = selectedOptions.value.split(' / ');
      return optionsList[index] == value;
    }
    // Return a default value (e.g., false) when the conditions are not met.
    return false;
  }

  bool isDefaultOptionSelected(String value) {
    return selectedOptions.isNotEmpty &&
        selectedOptions.split(' / ')[0] == value.split(' / ')[0] &&
        findMatchingVariantIndex(selectedOptions.value) != -1;
  }

  ///---------------------------------

  fetchProductDetailById(String productId) async {
    controllerProduct = null;
    update();
    try {
      final response = await shopifyStore.getProductsByIds([productId]);
      setProduct = (response ?? []).first;
      listOfOptions = [];
      selectedVariantIndex.value = 0;
      // setListOfOptions(controllerProduct!);
      setListOfVariantsAndOptions(controllerProduct!);
      isProcessing.value = false;
      update();
    } catch (e) {
      if (kDebugMode) {
        print("Error in getting product details => $e");
      }
    }
  }

  productDetailBottomSheet(
      {required BuildContext context,
        Product? product,
        bool fetchProductDetail = false,
        bool fromCartPage = false,
        ProductInfo? productInfo,
        int? indexFromCartItem}) async {
    variantsList.value = [];
    options.value = [];

    if (fetchProductDetail) {
      isProcessing.value = true;
      // variantsList.value.clear();
      await resetShopify();
      controllerProduct = null;
      ProductSheet.to.update();
      fetchProductDetailById(productInfo!.id);

      if (context.mounted) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return GetBuilder<ProductSheet>(builder: (logic) {
                return Obx(() {
                  return Wrap(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        child: SafeArea(
                            child: Column(
                              children: [
                                5.heightBox,

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: pageMarginHorizontal,
                                      vertical: pageMarginVertical / 2),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 80.h,
                                        height: 80.h,
                                        child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(5.r),
                                            child: FadeInImage.memoryNetwork(
                                                placeholder: kTransparentImage,
                                                imageErrorBuilder: (context, url,
                                                    error) =>
                                                    Container(
                                                      color: Colors.grey.shade200,
                                                      child: Center(
                                                        child: SvgPicture.asset(
                                                          Assets.icons.noImageIcon,
                                                          height: 25.h,
                                                        ),
                                                      ),
                                                    ),
                                                fit: BoxFit.cover,
                                                image: productInfo.image
                                              // "${product.image.split("?v=")[0]}?width=300}"
                                            )),
                                      ),
                                      10.widthBox,
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          GetBuilder<ProductSheet>(
                                              builder: (logic) {
                                                return controllerProduct == null
                                                    ? const SizedBox()
                                                    : Text(
                                                  controllerProduct
                                                      ?.vendor.capitalize ??
                                                      "",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: context.text.bodySmall
                                                      ?.copyWith(
                                                      color: AppColors
                                                          .appHintColor,
                                                      fontSize: 10.sp),
                                                );
                                              }),
                                          4.heightBox,

                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              productInfo.title,
                                              maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                              style: context.text.bodySmall?.copyWith(
                                                  color: AppColors.appTextColor,
                                                  // color: AppColors.appProductCardTitleColor,
                                                  fontSize: 13.sp),
                                            ),
                                          ),
                                          2.heightBox,

                                          ///-------- Pricing
                                          GetBuilder<ProductSheet>(
                                              builder: (logic) {
                                                return controllerProduct == null
                                                    ? const SizedBox()
                                                    : Row(
                                                  children: [
                                                    Text(
                                                      controllerProduct!
                                                          .productVariants[
                                                      selectedVariantIndex
                                                          .value]
                                                          .price
                                                          .amount ==
                                                          0
                                                          ? "FREE"
                                                          : CurrencyController.to
                                                          .getConvertedPrice(
                                                          priceAmount: controllerProduct!
                                                              .productVariants[
                                                          selectedVariantIndex.value]
                                                              .price
                                                              .amount ??
                                                              0),
                                                      style: context.text.bodyMedium?.copyWith(
                                                          color: controllerProduct!
                                                              .compareAtPrice !=
                                                              0
                                                              ? AppColors
                                                              .appPriceRedColor
                                                              : AppColors
                                                              .appTextColor),
                                                    ),
                                                    3.widthBox,
                                                    controllerProduct!
                                                        .compareAtPrice !=
                                                        0
                                                        ? Text(
                                                      CurrencyController.to
                                                          .getConvertedPrice(
                                                          priceAmount:
                                                          controllerProduct!
                                                              .compareAtPrice ??
                                                              0),
                                                      style: context
                                                          .text.bodySmall
                                                          ?.copyWith(
                                                          color: AppColors
                                                              .appHintColor,
                                                          fontSize:
                                                          10.sp,
                                                          decoration:
                                                          TextDecoration
                                                              .lineThrough),
                                                    )
                                                        : const SizedBox(),
                                                  ],
                                                );
                                              }),

                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewProductDetails(
                                                            productId:
                                                            productInfo.id,
                                                          )));
                                            },
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: AppConfig
                                                        .to.primaryColor.value,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                "View Details",
                                                style: context.text.bodyMedium
                                                    ?.copyWith(
                                                    color: AppConfig
                                                        .to.primaryColor.value),
                                              ),
                                            ),
                                          ),
                                          // Text("View Details",
                                          //   style: context.text.titleMedium?.copyWith(color: AppColors.customGreyTextColor, fontSize: 14.sp, decoration: TextDecoration.underline,decorationThickness: 2.0,),),
                                        ],
                                      ),
                                      const Spacer(),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Icon(Icons.close,
                                                  color: AppColors.appHintColor)))
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: AppColors.appBordersColor,
                                  thickness: .5,
                                ),

                                ///-------- List of Variants
                                GetBuilder<ProductSheet>(builder: (sheetLogic) {
                                  return
                                    // variantsList.value.length > 1 &&
                                    variantsList.value.isEmpty
                                        ? const SizedBox.shrink()
                                        : variantsList.value[0].title
                                        .toUpperCase() !=
                                        "DEFAULT TITLE"
                                    // variantsList.value[0].title.toUpperCase() != "Default Title"
                                        ? Padding(
                                      padding: EdgeInsets.only(
                                          left: pageMarginHorizontal,
                                          right: pageMarginHorizontal,
                                          bottom: 20),
                                      child: Column(
                                        children:
                                        options.value.map((option) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                top: options.value
                                                    .indexOf(
                                                    option) ==
                                                    0
                                                    ? 0
                                                    : 14.h),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text(option.name,
                                                    style: context.text
                                                        .bodyLarge),
                                                Row(
                                                  children: option
                                                      .values
                                                      .asMap()
                                                      .entries
                                                      .map<Widget>(
                                                        (entry) {
                                                      int index =
                                                          entry.key;
                                                      String value =
                                                          entry.value;

                                                      bool
                                                      isDefaultSelected =
                                                      isDefaultOptionSelected(
                                                          value);

                                                      bool isSelected =
                                                      isOptionSelected(
                                                          options
                                                              .value
                                                              .indexOf(
                                                              option),
                                                          value);
                                                      // selectedOptions.value.contains(value);

                                                      int matchingVariantIndex =
                                                      findMatchingVariantIndex(
                                                          selectedOptions
                                                              .value);

                                                      print(
                                                          "value is $value , key index is $index :: matching is $matchingVariantIndex :: selected string is ${selectedOptions.value}");

                                                      bool isAvailable =
                                                      isOptionAvailable(
                                                          options
                                                              .value
                                                              .indexOf(
                                                              option),
                                                          value);

                                                      return GestureDetector(
                                                          onTap: () {
                                                            if (isAvailable) {
                                                              _onOptionSelected(
                                                                  value,
                                                                  options
                                                                      .value
                                                                      .indexOf(option));
                                                            } else {
                                                              print(
                                                                  "can be selected");
                                                              const snackBar =
                                                              SnackBar(
                                                                content:
                                                                Text('Sorry, its out of stock'),
                                                              );
                                                              ScaffoldMessenger.of(
                                                                  context)
                                                                  .showSnackBar(
                                                                  snackBar);
                                                            }
                                                          },
                                                          child: isAvailable
                                                              ? Padding(
                                                              padding: EdgeInsets.only(right: 10.w, top: 6.h),
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    HapticFeedback.lightImpact();
                                                                    _onOptionSelected(value, options.value.indexOf(option));
                                                                  },
                                                                  child: Container(
                                                                      padding: EdgeInsets.only(right: 9.w, left: 9.w, bottom: 11.h, top: 14.h),
                                                                      decoration: BoxDecoration(color: AppColors.textFieldBGColor, border: Border.all(color: isSelected ? AppConfig.to.primaryColor.value : Colors.transparent, width: 1), borderRadius: BorderRadius.circular(3.r)),
                                                                      child: Text(value,
                                                                          style: context.text.bodyMedium?.copyWith(
                                                                            height: 0.5,
                                                                            color: isSelected ? AppConfig.to.primaryColor.value : AppColors.appTextColor,
                                                                          )))))
                                                              : Padding(
                                                              padding: EdgeInsets.only(right: 10.w, top: 6.h),
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    HapticFeedback.lightImpact();
                                                                    showToastMessage(message: "This variant is not available right now");
                                                                  },
                                                                  child: Container(padding: EdgeInsets.only(right: 9.w, left: 9.w, bottom: 11.h, top: 14.h), decoration: BoxDecoration(color: AppColors.textFieldBGColor, borderRadius: BorderRadius.circular(3.r)), child: Text(value, style: context.text.bodyMedium?.copyWith(height: 0.5, color: AppColors.appProductCardTitleColor.withOpacity(.8), decoration: TextDecoration.lineThrough))))));
                                                    },
                                                  ).toList(),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                        : const SizedBox.shrink();
                                }),

                                5.heightBox,

                                Obx(() {
                                  return GlobalElevatedButton(
                                    text: controllerProduct == null
                                        ? ""
                                        : controllerProduct!
                                        .productVariants[
                                    selectedVariantIndex.value]
                                        .availableForSale ==
                                        true
                                        ? directNavigateToCheckout
                                        ? "buy now"
                                        : "add to cart"
                                        : "Out of Stock",
                                    onPressed: () async {
                                      HapticFeedback.lightImpact();

                                      if (directNavigateToCheckout) {
                                        CartLogic.to.checkoutToWeb();
                                      } else {
                                        if (controllerProduct!
                                            .productVariants[
                                        selectedVariantIndex.value]
                                            .quantityAvailable >
                                            0) {
                                          if (CartLogic.to.checkFromCart(
                                              controllerProduct!
                                                  .productVariants[
                                              selectedVariantIndex.value]
                                                  .quantityAvailable,
                                              1,
                                              controllerProduct!
                                                  .productVariants[
                                              selectedVariantIndex.value]
                                                  .id)) {
                                            isProcessing.value = true;

                                            int? indexInCart = CartLogic
                                                .to.currentCart?.lineItems
                                                .indexWhere((lineItem) =>
                                            lineItem.variantId ==
                                                controllerProduct!
                                                    .productVariants[
                                                selectedVariantIndex
                                                    .value]
                                                    .id);

                                            log("find in the cart list is => $indexInCart");

                                            if (await CartLogic.to.addToCart(
                                                context: context,
                                                fromProductCardBottomSheet: true,
                                                fromCartScreen: fromCartPage,
                                                isDifferentVariant: (indexInCart !=
                                                    -1 &&
                                                    CartLogic
                                                        .to
                                                        .currentItemIndex
                                                        .value !=
                                                        -1)
                                                    ? false
                                                    : true,

                                                // isDifferentVariant: (CartLogic.to.currentCart?.lineItems[CartLogic.to.currentItemIndex.value].variant!.id != controllerProduct!
                                                //     .productVariants[
                                                // selectedVariantIndex.value]
                                                //     .id),
                                                lineItem: (fromCartPage &&
                                                    (CartLogic
                                                        .to
                                                        .currentCart
                                                        ?.lineItems[CartLogic
                                                        .to
                                                        .currentItemIndex
                                                        .value]
                                                        .variant!
                                                        .id !=
                                                        controllerProduct!
                                                            .productVariants[
                                                        selectedVariantIndex
                                                            .value]
                                                            .id))
                                                    ? LineItem(
                                                  id: CartLogic
                                                      .to
                                                      .currentCart
                                                      ?.lineItems[CartLogic
                                                      .to
                                                      .currentItemIndex
                                                      .value]
                                                      .id,
                                                  variantId: controllerProduct!
                                                      .productVariants[
                                                  selectedVariantIndex
                                                      .value]
                                                      .id,
                                                  quantity: 1,
                                                  title: CartLogic
                                                      .to
                                                      .currentCart!
                                                      .lineItems[CartLogic
                                                      .to
                                                      .currentItemIndex
                                                      .value]
                                                      .title,
                                                  discountAllocations: [],
                                                )
                                                    : LineItem(
                                                    title: controllerProduct!
                                                        .productVariants[selectedVariantIndex.value]
                                                        .title,
                                                    quantity: 1,
                                                    variantId: controllerProduct!.productVariants[selectedVariantIndex.value].id,
                                                    discountAllocations: []))) {
                                              if (context.mounted) {
                                                productAddedbottomSheet(
                                                    context,
                                                    "${controllerProduct!.image.split("?v=")[0]}?width=300",

                                                    // product!.images[0].originalSrc,
                                                    controllerProduct?.vendor,
                                                    controllerProduct?.title,
                                                    controllerProduct?.price,
                                                    controllerProduct
                                                        ?.compareAtPrice);
                                              }
                                            }

                                            isProcessing.value = false;
                                          } else {
                                            showToastMessage(
                                                message:
                                                "You have already added the max available in cart");
                                          }
                                        } else {
                                          isProcessing.value = true;

                                          ///----- check if already exists in cart
                                          int? indexInCart = CartLogic
                                              .to.currentCart?.lineItems
                                              .indexWhere((lineItem) =>
                                          lineItem.variantId ==
                                              controllerProduct!
                                                  .productVariants[
                                              selectedVariantIndex
                                                  .value]
                                                  .id);

                                          log("find in the cart list is => $indexInCart");

                                          ///-----
                                          if (await CartLogic.to.addToCart(
                                              context: context,
                                              fromProductCardBottomSheet: true,
                                              fromCartScreen: fromCartPage,
                                              isDifferentVariant: (indexInCart != -1 &&
                                                  CartLogic.to.currentItemIndex.value !=
                                                      -1)
                                                  ? false
                                                  : true,
                                              // isDifferentVariant: (CartLogic.to.currentCart?.lineItems[CartLogic.to.currentItemIndex.value].variant!.id != controllerProduct!
                                              //     .productVariants[
                                              // selectedVariantIndex.value]
                                              //     .id),

                                              lineItem: (fromCartPage &&
                                                  (CartLogic
                                                      .to
                                                      .currentCart
                                                      ?.lineItems[CartLogic
                                                      .to
                                                      .currentItemIndex
                                                      .value]
                                                      .variant!
                                                      .id !=
                                                      controllerProduct!
                                                          .productVariants[
                                                      selectedVariantIndex
                                                          .value]
                                                          .id))
                                                  ? LineItem(
                                                id: CartLogic
                                                    .to
                                                    .currentCart
                                                    ?.lineItems[CartLogic
                                                    .to
                                                    .currentItemIndex
                                                    .value]
                                                    .id,
                                                variantId: controllerProduct!
                                                    .productVariants[
                                                selectedVariantIndex
                                                    .value]
                                                    .id,
                                                quantity: CartLogic
                                                    .to
                                                    .currentCart
                                                    ?.lineItems[CartLogic
                                                    .to
                                                    .currentItemIndex
                                                    .value]
                                                    .quantity ??
                                                    1,
                                                // quantity: 1,
                                                title: CartLogic
                                                    .to
                                                    .currentCart!
                                                    .lineItems[CartLogic
                                                    .to
                                                    .currentItemIndex
                                                    .value]
                                                    .title,
                                                discountAllocations: [],
                                              )
                                                  : LineItem(
                                                  title: controllerProduct!
                                                      .productVariants[
                                                  selectedVariantIndex.value]
                                                      .title,
                                                  quantity: 1,
                                                  variantId: controllerProduct!.productVariants[selectedVariantIndex.value].id,
                                                  discountAllocations: []))) {
                                            if (context.mounted) {
                                              productAddedbottomSheet(
                                                  context,
                                                  "${(controllerProduct?.image ?? "").split("?v=")[0]}?width=300",

                                                  // product!.images[0].originalSrc,
                                                  controllerProduct?.vendor,
                                                  controllerProduct?.title,
                                                  controllerProduct?.price,
                                                  controllerProduct
                                                      ?.compareAtPrice);
                                            }
                                          }

                                          isProcessing.value = false;
                                        }
                                      }
                                    },
                                    isLoading: isProcessing.value,
                                    applyHorizontalPadding: true,
                                    isDisable: controllerProduct == null
                                        ? false
                                        : controllerProduct!
                                        .productVariants[
                                    selectedVariantIndex.value]
                                        .availableForSale ==
                                        true
                                        ? false
                                        : true,
                                  );
                                }),

                                20.heightBox,
                              ],
                            )),
                      ),
                    ],
                  );
                });
              });
            });
      }
    } else {
      setListOfVariantsAndOptions(product!);
      setProduct = product;
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            print("value of bottom sheet ID: ${product.id}====");
            return Obx(() {
              return Wrap(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: SafeArea(
                        child: Column(
                          children: [
                            5.heightBox,

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: pageMarginHorizontal,
                                  vertical: pageMarginVertical / 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80.h,
                                    height: 80.h,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5.r),
                                        child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            imageErrorBuilder:
                                                (context, url, error) => Container(
                                              color: Colors.grey.shade200,
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  Assets.icons.noImageIcon,
                                                  height: 25.h,
                                                ),
                                              ),
                                            ),
                                            fit: BoxFit.cover,
                                            image:
                                            "${product.image.split("?v=")[0]}?width=300}")),
                                  ),
                                  10.widthBox,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.vendor.capitalize ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.text.bodySmall?.copyWith(
                                            color: AppColors.appHintColor,
                                            fontSize: 10.sp),
                                      ),
                                      4.heightBox,

                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          product.title ?? "",
                                          maxLines: 1,
                                          // overflow: TextOverflow.ellipsis,
                                          style: context.text.bodySmall?.copyWith(
                                              color: AppColors.appTextColor,
                                              // color: AppColors.appProductCardTitleColor,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                      2.heightBox,

                                      ///-------- Pricing
                                      Row(
                                        children: [
                                          Text(
                                            product
                                                .productVariants[
                                            selectedVariantIndex
                                                .value]
                                                .price
                                                .amount ==
                                                0
                                                ? "FREE"
                                                : CurrencyController.to
                                                .getConvertedPrice(
                                                priceAmount: product
                                                    .productVariants[
                                                selectedVariantIndex
                                                    .value]
                                                    .price
                                                    .amount ??
                                                    0),
                                            style: context.text.bodyMedium
                                                ?.copyWith(
                                                color: product.compareAtPrice !=
                                                    0
                                                    ? AppColors.appPriceRedColor
                                                    : AppColors.appTextColor),
                                          ),
                                          3.widthBox,
                                          product.compareAtPrice != 0
                                              ? Text(
                                            CurrencyController.to
                                                .getConvertedPrice(
                                                priceAmount: product
                                                    .compareAtPrice ??
                                                    0),
                                            style: context.text.bodySmall
                                                ?.copyWith(
                                                color: AppColors
                                                    .appHintColor,
                                                fontSize: 10.sp,
                                                decoration: TextDecoration
                                                    .lineThrough),
                                          )
                                              : const SizedBox(),
                                        ],
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewProductDetails(
                                                        productId: product.id,
                                                      )));
                                        },
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color:
                                                AppConfig.to.primaryColor.value,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "View Details",
                                            style: context.text.bodyMedium
                                                ?.copyWith(
                                                color: AppConfig
                                                    .to.primaryColor.value),
                                          ),
                                        ),
                                      ),
                                      // Text("View Details",
                                      //   style: context.text.titleMedium?.copyWith(color: AppColors.customGreyTextColor, fontSize: 14.sp, decoration: TextDecoration.underline,decorationThickness: 2.0,),),
                                    ],
                                  ),
                                  Spacer(),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: AppColors.appHintColor,
                                          )))
                                ],
                              ),
                            ),
                            const Divider(
                              color: AppColors.appBordersColor,
                              thickness: .5,
                            ),

                            ///-------- List of Variants
                            GetBuilder<ProductSheet>(builder: (sheetLogic) {
                              return
                                // variantsList.value.length > 1 &&
                                variantsList.value[0].title != "Default Title"
                                    ? Padding(
                                  padding: EdgeInsets.only(
                                      left: pageMarginHorizontal,
                                      right: pageMarginHorizontal,
                                      bottom: 20),
                                  child: Column(
                                    children: options.value.map((option) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                            top: options.value
                                                .indexOf(option) ==
                                                0
                                                ? 0
                                                : 14.h),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(option.name,
                                                style:
                                                context.text.bodyLarge),
                                            Row(
                                              children: option.values
                                                  .asMap()
                                                  .entries
                                                  .map<Widget>(
                                                    (entry) {
                                                  int index = entry.key;
                                                  String value =
                                                      entry.value;

                                                  bool isDefaultSelected =
                                                  isDefaultOptionSelected(
                                                      value);

                                                  bool isSelected =
                                                  isOptionSelected(
                                                      options.value
                                                          .indexOf(
                                                          option),
                                                      value);
                                                  // selectedOptions.value.contains(value);

                                                  int matchingVariantIndex =
                                                  findMatchingVariantIndex(
                                                      selectedOptions
                                                          .value);

                                                  print(
                                                      "value is $value , key index is $index :: matching is $matchingVariantIndex :: selected string is ${selectedOptions.value}");

                                                  bool isAvailable =
                                                  isOptionAvailable(
                                                      options.value
                                                          .indexOf(
                                                          option),
                                                      value);

                                                  return GestureDetector(
                                                      onTap: () {
                                                        if (isAvailable) {
                                                          _onOptionSelected(
                                                              value,
                                                              options.value
                                                                  .indexOf(
                                                                  option));
                                                        } else {
                                                          print(
                                                              "can be selected");
                                                          const snackBar =
                                                          SnackBar(
                                                            content: Text(
                                                                'Sorry, its out of stock'),
                                                          );
                                                          ScaffoldMessenger
                                                              .of(
                                                              context)
                                                              .showSnackBar(
                                                              snackBar);
                                                        }
                                                      },
                                                      child: isAvailable
                                                          ? Padding(
                                                          padding: EdgeInsets.only(
                                                              right:
                                                              10.w,
                                                              top: 6.h),
                                                          child: InkWell(
                                                              onTap: () {
                                                                HapticFeedback
                                                                    .lightImpact();
                                                                _onOptionSelected(
                                                                    value,
                                                                    options.value.indexOf(option));
                                                              },
                                                              child: Container(
                                                                  padding: EdgeInsets.only(right: 9.w, left: 9.w, bottom: 11.h, top: 14.h),
                                                                  decoration: BoxDecoration(color: AppColors.textFieldBGColor, border: Border.all(color: isSelected ? AppConfig.to.primaryColor.value : Colors.transparent, width: 1), borderRadius: BorderRadius.circular(3.r)),
                                                                  child: Text(value,
                                                                      style: context.text.bodyMedium?.copyWith(
                                                                        height: 0.5,
                                                                        color: isSelected ? AppConfig.to.primaryColor.value : AppColors.appTextColor,
                                                                      )))))
                                                          : Padding(
                                                          padding: EdgeInsets.only(right: 10.w, top: 6.h),
                                                          child: InkWell(
                                                              onTap: () {
                                                                HapticFeedback
                                                                    .lightImpact();
                                                                showToastMessage(
                                                                    message:
                                                                    "This variant is not available right now");
                                                              },
                                                              child: Container(padding: EdgeInsets.only(right: 9.w, left: 9.w, bottom: 11.h, top: 14.h), decoration: BoxDecoration(color: AppColors.textFieldBGColor, borderRadius: BorderRadius.circular(3.r)), child: Text(value, style: context.text.bodyMedium?.copyWith(height: 0.5, color: AppColors.appProductCardTitleColor.withOpacity(.8), decoration: TextDecoration.lineThrough))))));
                                                },
                                              ).toList(),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                                    : const SizedBox.shrink();
                            }),

                            5.heightBox,

                            Obx(() {
                              return GlobalElevatedButton(
                                text: product
                                    .productVariants[
                                selectedVariantIndex.value]
                                    .availableForSale ==
                                    true
                                    ? directNavigateToCheckout
                                    ? "buy now"
                                    : "add to cart"
                                    : "Out of Stock",
                                onPressed: () async {
                                  HapticFeedback.lightImpact();
                                  if (product
                                      .productVariants[
                                  selectedVariantIndex.value]
                                      .quantityAvailable >
                                      0) {
                                    if (CartLogic.to.checkFromCart(
                                        product
                                            .productVariants[
                                        selectedVariantIndex.value]
                                            .quantityAvailable,
                                        1,
                                        product
                                            .productVariants[
                                        selectedVariantIndex.value]
                                            .id)) {
                                      isProcessing.value = true;

                                      if (await CartLogic.to.addToCart(
                                          context: context,
                                          fromProductCardBottomSheet: true,
                                          lineItem: LineItem(
                                              title: product
                                                  .productVariants[
                                              selectedVariantIndex.value]
                                                  .title,
                                              quantity: 1,
                                              variantId: product
                                                  .productVariants[
                                              selectedVariantIndex.value]
                                                  .id,
                                              discountAllocations: []))) {
                                        if (context.mounted) {
                                          productAddedbottomSheet(
                                              context,
                                              "${product.image.split("?v=")[0]}?width=300",

                                              // product.images[0].originalSrc,
                                              product.vendor,
                                              product.title,
                                              product.price,
                                              product.compareAtPrice);
                                        }
                                      }

                                      isProcessing.value = false;
                                    } else {
                                      showToastMessage(
                                          message:
                                          "You have already added the max available in cart");
                                    }
                                  } else {
                                    isProcessing.value = true;

                                    if (await CartLogic.to.addToCart(
                                        context: context,
                                        fromProductCardBottomSheet: true,
                                        lineItem: LineItem(
                                            title: product
                                                .productVariants[
                                            selectedVariantIndex.value]
                                                .title,
                                            quantity: 1,
                                            variantId: product
                                                .productVariants[
                                            selectedVariantIndex.value]
                                                .id,
                                            discountAllocations: []))) {
                                      if (context.mounted) {
                                        productAddedbottomSheet(
                                            context,
                                            "${product.image.split("?v=")[0]}?width=300",

                                            // product.images[0].originalSrc,
                                            product.vendor,
                                            product.title,
                                            product.price,
                                            product.compareAtPrice);
                                      }
                                    }

                                    isProcessing.value = false;
                                  }
                                  // }
                                },
                                isLoading: isProcessing.value,
                                applyHorizontalPadding: true,
                                isDisable: product
                                    .productVariants[
                                selectedVariantIndex.value]
                                    .availableForSale ==
                                    true
                                    ? false
                                    : true,
                              );
                            }),

                            20.heightBox,
                          ],
                        )),
                  ),
                ],
              );
            });
          });
    }
  }
}