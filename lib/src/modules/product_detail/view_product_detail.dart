import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:tapify_admin/src/utils/global_instances.dart';

import '../../api_services/shopify_flutter/models/src/checkout/line_item/line_item.dart';
import '../../api_services/shopify_flutter/models/src/product/option/option.dart';
import '../../api_services/shopify_flutter/models/src/product/product.dart';
import '../../api_services/shopify_flutter/models/src/product/product_variant/product_variant.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_product_Card.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../global_controllers/currency_controller.dart';
import '../../global_controllers/reviews/reviews_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import '../cart/components/product_added_to_cart_sheet.dart';
import '../cart/logic.dart';
import '../category/view_category_products.dart';
import '../recently_viewed/logic.dart';
import '../recently_viewed/view.dart';
import '../wishlist/logic.dart';
import 'components/bottom_sheet_notify_me.dart';
import 'components/containerDivider.dart';
import 'components/product_photo_gallery.dart';

class NewProductDetails extends StatefulWidget {
  final String productId;

  const NewProductDetails({super.key, required this.productId});

  @override
  State<NewProductDetails> createState() => _NewProductDetailsState();
}

class _NewProductDetailsState extends State<NewProductDetails> {
  Rx<List<Product>> productsList = Rx<List<Product>>([]);
  Rx<List<Product>> recommendedProducts = Rx<List<Product>>([]);
  Rx<List<ProductVariant>> variantsList = Rx<List<ProductVariant>>([]);
  Rx<List<Option>> options = Rx<List<Option>>([]);

  // Rx<List> variantsList = Rx<List>([]);
  // Rx<List> options = Rx<List>([]);
  RxString selectedOptions = "".obs;

  Product get product => productsList.value.first;
  RxBool isLoading = true.obs;
  Rx<int> currentImageIndex = 0.obs;
  Rx<int> selectedVariantIndex = (-1).obs;
  Rx<int> productQuantity = 1.obs;
  RxBool isProcessing = false.obs;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProductDetailAPICall(
        context: context,
      );
    });
  }

  getProductDetailAPICall({required BuildContext context}) async {
    try {
      recommendedProducts.value = [];
      productsList.value = [];
      // await resetShopify();
      final response = await shopifyStore.getProductsByIds([widget.productId]);
      productsList.value = response!;
      // getListOfVariants();
      variantsList.value = productsList.value.first.productVariants;
      options.value = productsList.value.first.option;
      setSelectedVariantByDefault();
      if (context.mounted) {
        fetchRecommendedProducts(
            productsList.value.first.collectionList![0].id);
      }
      logger.i(productsList.value);
      RecentlyViewedLogic.to
          .addToRecentlyViewed(product: productsList.value.first);
    } catch (e) {
      debugPrint("=== Error Fetching Product Details ==> $e ");
    }
  }
  ///----- New Variants Logic ---------

  void setSelectedVariantByDefault() {
    for (ProductVariant variant in variantsList.value) {
      if (variant.availableForSale) {
        setState(() {
          selectedOptions.value = variant.title;
        });
        break;
      }
    }
    if (selectedOptions.value != "") {
      selectedVariantIndex.value =
          findMatchingVariantIndex(selectedOptions.value);
    } else {
      selectedOptions.value = variantsList.value[0].title;
      selectedVariantIndex.value = 0;
    }
    print("first selected is => $selectedOptions");
  }

  void _onOptionSelected(String optionValue, int index) {
    List<String> newSelectedOptions = selectedOptions.value.split(' / ');

    // Update the value at the specified index
    newSelectedOptions[index] = optionValue;

    setState(() {
      selectedOptions.value = newSelectedOptions.join(' / ');
    });

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

  ///-----------------------------------

  fetchRecommendedProducts(String id) async {
    try {
      final categoryProducts =
          await shopifyStore.getXProductsAfterCursorWithinCollection(
        id,
        8,
      );
      recommendedProducts.value = categoryProducts ?? [];
    } catch (e) {
      debugPrint(" Error in fetching recommended products ${e.toString()}");
    }
  }

  newReviewsFunction({required Product product}) {
    Rx<Map> productReviews = Rx<Map>({});
    final productReviewsInfo = ReviewsListController.to
        .getProductReviewsList(int.parse((product.id).split("Product/")[1]));
    productReviews.value = productReviewsInfo[0];
    return productReviews.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'product detail',
        showBack: true,
      ),
      body: Obx(() {
        // log("===> length in circulating => ${product.productVariants.length} <====");
        return productsList.value.isEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ShimerCarosalSliderPage(),
                    ShimertitlePage(),
                    ShimerSizeAndColorPage(),
                    ShimertitlePage(),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    imagesCarousel(),
                    titleAndPrice(),
                    variantsListWidget(),
                    quantityControllerWidget(),
                    // notifyMeWidget(),
                    productDetailsExpanders(),
                    reviewsListWidget(),
                    recommendedProductsWidget(),
                    recentlyViewedProductsWidget(),
                  ],
                ),
              );
      }),
      bottomNavigationBar: Obx(() {
        return productsList.value.isEmpty
            ? const SizedBox.shrink()
            : product.productVariants[selectedVariantIndex.value]
                    .availableForSale
                ? addToCartButton()
                : notifyMeWidget();
      }),
    );
  }

  //------ Images Carousel
  Widget imagesCarousel() {
    return Obx(() {
      return SizedBox(
        height: context.deviceHeight / 1.8,
        child: Wrap(
          children: [
            Stack(
              children: [
                (product.images.isNotEmpty)
                    ? GestureDetector(
                        onTap: () => Get.to(() => ProductPhotoGallery(
                              product: product,
                          carouselController: carouselController,
                          currentImageIndex: currentImageIndex,
                            ), opaque: false, transition: Transition.native),
                        child: CarouselSlider(
                          items: List.generate(product.images.length ?? 0,
                              (index) {
                            return CachedNetworkImage(
                              imageUrl: product.images.isNotEmpty
                                  ? '${product.images[index].originalSrc.split('?')[0]}?width=800'
                                  : '',
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      ShimerCarosalSliderPage(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            );
                          }),
                          carouselController: carouselController,
                          options: CarouselOptions(
                              height: context.deviceHeight / 1.8,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              enableInfiniteScroll: false,
                              reverse: false,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, _) {
                                currentImageIndex.value = index;
                              }),
                        ),
                      )
                    : Container(
                        height: context.deviceHeight / 1.8,
                        color: Colors.grey.shade200,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.icons.noImageIcon,
                            height: 35.h,
                          ),
                        ),
                      ),
                Positioned(
                    left: pageMarginHorizontal,
                    top: pageMarginVertical * 1.5,
                    child: Container(
                      padding: EdgeInsets.only(right: 10.w, left: 10.w, top: 4.h
                          // vertical: 4.h
                          ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                            product.productVariants[selectedVariantIndex.value]
                                        .availableForSale ==
                                    true
                                ? "In Stock"
                                : "Out of Stock",
                            style: context.text.bodyMedium
                                ?.copyWith(color: Colors.black)),
                      ),
                    )),
                Positioned(
                    right: pageMarginHorizontal * 1.2,
                    bottom: pageMarginVertical * 1.2,
                    child: GestureDetector(
                      onTap: () async {
                        log("link is ${product.onlineStoreUrl}");

                        ///----- Share Functionality Will be Here
                        await Share.share(
                            "${product.title} \nPrice: ${product.formattedPrice} \n${product.onlineStoreUrl}");
                      },
                      child: SvgPicture.asset(
                        Assets.icons.shareIcon,
                        // height: 20.h,
                        // color: Colors.black,
                        // size: 20.sp,
                      ),
                    )),
              ],
            ),
            product.images.length == 1 ? 0.heightBox : 10.heightBox,
            product.images.length != 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        product.images.length ?? 0,
                        (index) => Obx(() {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 250),
                                      height: 7.h,
                                      width: currentImageIndex.value == index
                                          ? 25.h
                                          : 7.h,
                                      decoration: currentImageIndex.value ==
                                              index
                                          ? BoxDecoration(
                                              color: AppConfig
                                                  .to.primaryColor.value,
                                              borderRadius:
                                                  BorderRadius.circular(50.r))
                                          : BoxDecoration(
                                              color: AppColors.appBordersColor,
                                              borderRadius:
                                                  BorderRadius.circular(50.r)),
                                    ),
                                  ),
                                  4.widthBox
                                ],
                              );
                            })),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      );
    });
  }

  //------ Title & Price
  Widget titleAndPrice() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(
          left: pageMarginHorizontal,
          right: pageMarginHorizontal,
          top: product.images.length == 1
              ? pageMarginVertical
              : pageMarginVertical * 1.8,
          bottom: pageMarginVertical,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.vendor.toString().capitalize ?? "",
                      style: context.text.bodySmall?.copyWith(
                          height: 1.1,
                          color: AppColors.appHintColor,
                          fontSize: 14.sp),
                    ),
                    (pageMarginVertical / 2).heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: context.text.bodyMedium
                                ?.copyWith(height: 1.1, fontSize: 20.sp),
                          ),
                        ),
                      ],
                    ),
                    (pageMarginVertical / 2).heightBox,

                    ///------- price for variant product
                    Row(
                      children: [
                        Text(
                          (product.productVariants[selectedVariantIndex.value]
                                      .price.amount !=
                                  0)
                              ? CurrencyController.to.getConvertedPrice(
                                  priceAmount: product
                                      .productVariants[
                                          selectedVariantIndex.value]
                                      .price
                                      .amount)
                              : "FREE",
                          style: context.text.bodyMedium?.copyWith(
                              height: 1.1,
                              color: ((product
                                              .productVariants[
                                                  selectedVariantIndex.value]
                                              .compareAtPrice ??
                                          0) !=
                                      0)
                                  ? AppColors.appPriceRedColor
                                  : AppColors.appTextColor),
                        ),
                        8.widthBox,
                        ((product.productVariants[selectedVariantIndex.value]
                                        .compareAtPrice ??
                                    0) !=
                                0)
                            ? Text(
                                // '${(logic.product?.productVariants[logic.selectedVariantIndex.value].compareAtPrice?.formattedPrice ?? 0)}',

                                CurrencyController.to.getConvertedPrice(
                                    priceAmount: product
                                            .productVariants[
                                                selectedVariantIndex.value]
                                            .compareAtPrice
                                            ?.amount ??
                                        0.00,
                                    includeSign: false),
                                style: context.text.bodyMedium?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14.sp,
                                  color: AppColors.appHintColor,
                                  height: 1.1,
                                ),
                              )
                            : const SizedBox(),

                        ///------- Reviews & Stars
                        newReviewsFunction(product: product)['review_count'] ==
                                null
                            ? const SizedBox()
                            : Container(
                                margin:
                                    const EdgeInsets.only(bottom: 4, left: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      itemSize: 17.sp,
                                      initialRating: newReviewsFunction(
                                                  product:
                                                      product)['review_count'] >
                                              0
                                          ? newReviewsFunction(
                                              product: product)['avg_rating']
                                          : 0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      unratedColor: AppColors.appHintColor
                                          .withOpacity(.7),
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Color(0xfffbb03b),
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                    4.widthBox,
                                    Text(
                                        '(${newReviewsFunction(product: product)['review_count']})',
                                        style: context.text.bodyMedium
                                            ?.copyWith(
                                                height: 0.1,
                                                color: AppColors.appHintColor))
                                  ],
                                ),
                              )
                      ],
                    ),

                    (pageMarginVertical / 3).heightBox,
                  ],
                )),
                Obx(() {
                  bool isProductInWishlist = WishlistLogic.to
                          .checkIfExistsInBookmark(id: product.id) !=
                      -1;
                  return GestureDetector(
                    onTap: () => WishlistLogic.to.addOrRemoveBookmark(
                        context: context, product: product),
                    child: SvgPicture.asset(
                      Assets.icons.heartFilled,
                      color: isProductInWishlist
                          ? Colors.red
                          : Colors.grey.shade200,
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      );
    });
  }

  ///---- New Variants
  Widget variantsListWidget() {
    return Obx(() {
      return variantsList.value.isEmpty
          ? AppConfig.to.appSettingsProductDetailPages["dispalySizeCart"] ==
                  true
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        Assets.images.chartImage,
                        height: 16,
                      ),
                      6.widthBox,
                      Text(
                        "Size Chart",
                        style: context.text.bodyMedium,
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()
          :
          // variantsList.value.length > 1 &&
          variantsList.value[0].title != "Default Title"
              ? Padding(
                  padding: EdgeInsets.only(
                      left: pageMarginHorizontal,
                      right: pageMarginHorizontal,
                      bottom: 5),
                  child: Column(
                    children: options.value.map((option) {
                      return Container(
                        padding: EdgeInsets.only(
                            top: options.value.indexOf(option) == 0 ? 0 : 14.h,
                            bottom: options.value.indexOf(option) == options.value.length - 1 ? 12.h : 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(option.name, style: context.text.bodyLarge),
                            Row(
                              children:
                                  option.values.asMap().entries.map<Widget>(
                                (entry) {
                                  int index = entry.key;
                                  String value = entry.value;

                                  bool isDefaultSelected =
                                      isDefaultOptionSelected(value);

                                  bool isSelected = isOptionSelected(
                                      options.value.indexOf(option), value);
                                  // selectedOptions.value.contains(value);

                                  int matchingVariantIndex =
                                      findMatchingVariantIndex(
                                          selectedOptions.value);

                                  print(
                                      "value is $value , key index is $index :: matching is $matchingVariantIndex :: selected string is ${selectedOptions.value}");

                                  bool isAvailable = isOptionAvailable(
                                      options.value.indexOf(option), value);

                                  return GestureDetector(
                                    onTap: () {
                                      _onOptionSelected(
                                          value, options.value.indexOf(option));
                                    },
                                    child:
                                    // isAvailable ?
                                    Padding(
                                            padding: EdgeInsets.only(
                                                right: 10.w, top: 6.h),
                                            child: InkWell(
                                              onTap: () {
                                                HapticFeedback.lightImpact();
                                                _onOptionSelected(
                                                    value,
                                                    options.value
                                                        .indexOf(option));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    right: 9.w,
                                                    left: 9.w,
                                                    bottom: 11.h,
                                                    top: 14.h),
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .textFieldBGColor,
                                                    border: Border.all(
                                                        color: isSelected
                                                            ? AppConfig
                                                                .to
                                                                .primaryColor
                                                                .value
                                                            : Colors
                                                                .transparent,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3.r)),
                                                child: Text(
                                                  value,
                                                  style: context.text.bodyMedium
                                                      ?.copyWith(
                                                    height: 0.5,
                                                    color:
                                                    isSelected
                                                        ? AppConfig.to
                                                            .primaryColor.value
                                                        :  isAvailable ? AppColors
                                                            .appTextColor : AppColors.appProductCardTitleColor.withOpacity(.7),
                                                    decoration: isAvailable == false ? TextDecoration.lineThrough : null                                                ),
                                                ),
                                              ),
                                            ),
                                          )
                                  );
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
    });
  }

  //------- Quantity Controller
  Widget quantityControllerWidget() {
    return product
                .productVariants[selectedVariantIndex.value].availableForSale ==
            false
        ? const SizedBox.shrink()
        : Column(
            children: [
              Divider(
                color: AppColors.appHintColor,
                thickness: .2,
                indent: pageMarginHorizontal,
                endIndent: pageMarginHorizontal,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: pageMarginVertical / 3,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: context.text.bodyLarge,
                      ),
                      Row(
                        children: [
                          (product.productVariants[selectedVariantIndex.value]
                                          .availableForSale ==
                                      true &&
                                  (product
                                              .productVariants[
                                                  selectedVariantIndex.value]
                                              .quantityAvailable >
                                          0 &&
                                      product
                                              .productVariants[
                                                  selectedVariantIndex.value]
                                              .quantityAvailable <
                                          10))
                              ? Text(
                                  "Only ${product.productVariants[selectedVariantIndex.value].quantityAvailable} left",
                                  style: context.text.bodyMedium
                                      ?.copyWith(color: AppColors.appHintColor),
                                )
                              : const SizedBox.shrink(),
                          20.widthBox,
                          Obx(() {
                            return Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (productQuantity.value > 1) {
                                      productQuantity.value -= 1;
                                      HapticFeedback.lightImpact();
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.remove,
                                      color: AppColors.appHintColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: pageMarginHorizontal * 2,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: AppColors.textFieldBGColor),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        productQuantity.value.toString(),
                                        textAlign: TextAlign.center,
                                        style: context.text.bodyLarge,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    try {
                                      if (product
                                              .productVariants[
                                                  selectedVariantIndex.value]
                                              .availableForSale ==
                                          true) {
                                        if (product
                                                .productVariants[
                                                    selectedVariantIndex.value]
                                                .quantityAvailable >
                                            0) {
                                          if (productQuantity.value <
                                              product
                                                  .productVariants[
                                                      selectedVariantIndex
                                                          .value]
                                                  .quantityAvailable) {
                                            productQuantity.value += 1;
                                            HapticFeedback.lightImpact();
                                          } else {
                                            showToastMessage(
                                                message:
                                                    "Whoa! Currently ${product.productVariants[selectedVariantIndex.value].quantityAvailable} available.");
                                          }
                                        } else {
                                          productQuantity.value += 1;
                                          HapticFeedback.lightImpact();
                                        }
                                      }
                                    } catch (e) {
                                      log("error in incrementing");
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: const SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.appHintColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColors.appHintColor,
                thickness: .2,
                indent: pageMarginHorizontal,
                endIndent: pageMarginHorizontal,
              ),
            ],
          );
  }

  //------- Notify Me Widget
  Widget notifyMeWidget() {
    return Obx(() {
      return SafeArea(
        child: Visibility(
          visible: product.productVariants[selectedVariantIndex.value]
                      .availableForSale ==
                  true
              ? false
              : true,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: pageMarginHorizontal,
                vertical: pageMarginVertical - 5),
            child: GestureDetector(
              onTap: () {
                notifyMeBottomSheet(context: context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 11),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppColors.appPriceRedColor, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.notifyMeIcon,
                      height: 18,
                      color: AppColors.appPriceRedColor,
                    ),
                    10.widthBox,
                    Text(
                      "Notify me when available",
                      textAlign: TextAlign.center,
                      style: context.text.bodyMedium?.copyWith(
                          color: AppColors.appPriceRedColor, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  //------- Product Details Expanders
  productDetailsExpanders() {
    return ContainerDivider(product: product);
  }

  //------- Reviews List
  Widget reviewsListWidget() {
    return Obx(() {
      return (newReviewsFunction(product: product)['reviews_list'] == null ||
              newReviewsFunction(product: product)['reviews_list'].isEmpty)
          ? const SizedBox.shrink()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: pageMarginHorizontal,
                      vertical: pageMarginVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reviews',
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.appTextColor, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: pageMarginHorizontal),
                  child: Row(
                      children: List.generate(
                          newReviewsFunction(product: product)["reviews_list"]
                              .length, (index) {
                    return Container(
                      width: 300.w,
                      height: 121.h,
                      margin:
                          EdgeInsets.only(right: pageMarginHorizontal / 1.5),
                      padding: EdgeInsets.only(
                          left: pageMarginHorizontal,
                          right: pageMarginHorizontal,
                          top: pageMarginVertical / 1.5),
                      // padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                              color: AppColors.appHintColor, width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            newReviewsFunction(product: product)["reviews_list"]
                                [index]["reviewer"]["name"],
                            style: context.text.bodyMedium,
                          ),
                          // 2.heightBox,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${double.parse(newReviewsFunction(product: product)['avg_rating'].toStringAsFixed(1))}",
                                style: context.text.labelSmall
                                    ?.copyWith(fontSize: 13.sp, height: 2.1),
                              ),
                              4.widthBox,
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 18.sp,
                                initialRating: double.parse(newReviewsFunction(
                                        product: product)['avg_rating']
                                    .toStringAsFixed(1)),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0,
                                ),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // setState(() {
                                  //   // _rating = rating;
                                  // });
                                },
                              ),
                            ],
                          ),
                          5.heightBox,
                          Text(
                            newReviewsFunction(product: product)["reviews_list"]
                                [index]["body"],
                            maxLines: 3,
                            style: context.text.bodySmall!.copyWith(
                                // fontSize: 13.sp,
                                overflow: TextOverflow.ellipsis,
                                height: 1.1),
                          ),
                        ],
                      ),
                    );
                  })),
                ),
              ],
            );
    });
  }

  //----- Recommended products
  Widget recommendedProductsWidget() {
    return Obx(() {
      return recommendedProducts.value.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                25.heightBox,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recommended',
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.appTextColor, fontSize: 16.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          // print(
                          //     "value of ID in recommended====>${widget.product!.collectionList![0].id}");
                          Get.to(() => CategoryProducts(
                                collectionID: product.collectionList![0].id,
                                categoryName: product.collectionList![0].title,
                              ), opaque: false, transition: Transition.native);
                        },
                        child: Text(
                          'View All',
                          style: context.text.bodyMedium?.copyWith(
                              color: AppColors.appTextColor, fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                12.heightBox,
                SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(recommendedProducts.value.length,
                        (index) {
                      return product.id == recommendedProducts.value[index].id
                          ? const SizedBox()
                          : Container(
                              height: 250.h,
                              width: context.deviceWidth / 2.2,
                              // color: Colors.yellow,
                              margin: EdgeInsets.only(
                                right: pageMarginHorizontal,
                              ),
                              child: CustomProductCard(
                                product: recommendedProducts.value[index],
                              ));
                    }),
                  ),
                ),
              ],
            )
          : const SizedBox();
    });
  }

  //-------- Recently Viewed
  Widget recentlyViewedProductsWidget() {
    return GetBuilder<RecentlyViewedLogic>(
      builder: (logic) {
        return logic.userRecentlyViewed.isNotEmpty &&
                logic.userRecentlyViewed.length != 1
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  25.heightBox,
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recently Viewed',
                          style: context.text.bodyMedium?.copyWith(
                              color: AppColors.appTextColor, fontSize: 16.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Get.to(() => RecentlyViewedPage(), opaque: false, transition: Transition.native);
                          },
                          child: Text(
                            'View All',
                            style: context.text.bodyMedium?.copyWith(
                                color: AppColors.appTextColor, fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  12.heightBox,
                  SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          logic.userRecentlyViewed.length > 8
                              ? 8
                              : logic.userRecentlyViewed.length, (index) {
                        // return product.product?.id ==
                        return product.id == logic.userRecentlyViewed[index].id
                            ? const SizedBox()
                            : Container(
                                height: 250.h,
                                width: context.deviceWidth / 2.2,
                                // color: Colors.yellow,
                                margin: EdgeInsets.only(
                                  right: pageMarginHorizontal,
                                ),
                                child: CustomProductCard(
                                  product: logic.userRecentlyViewed[index],
                                ),
                              );
                      }),
                    ),
                  ),
                ],
              )
            : const SizedBox();
      },
    );
  }

  //-------- Add to Cart Button
  Widget addToCartButton() {
    return Obx(() {
      return SafeArea(
        child: SizedBox(
          height: 60.h,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal,
                  vertical: pageMarginVertical / 2),
              child: GlobalElevatedButton(
                text: product.productVariants[selectedVariantIndex.value]
                            .availableForSale ==
                        true
                    ? (AppConfig.to.appSettingsCartAndCheckout[
                                "navigationCustomers"] ==
                            true)
                        ? "Buy Now"
                        : "add to cart"
                    : "Out of Stock",
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  if (product.productVariants[selectedVariantIndex.value]
                          .availableForSale ==
                      true) {
                    if (product.productVariants[selectedVariantIndex.value]
                            .quantityAvailable >
                        0) {
                      if (productQuantity.value <
                          product.productVariants[selectedVariantIndex.value]
                              .quantityAvailable) {
                        if (CartLogic.to.checkFromCart(
                            product.productVariants[selectedVariantIndex.value]
                                .quantityAvailable,
                            productQuantity.value,
                            product.productVariants[selectedVariantIndex.value]
                                .id)) {
                          isProcessing.value = true;
                          try {
                            if (await CartLogic.to.addToCart(
                              context: context,
                              fromProductDetailScreen: true,
                              lineItem: LineItem(
                                  title: product
                                      .productVariants[
                                          selectedVariantIndex.value]
                                      .title,
                                  quantity: productQuantity.value,
                                  id: product.id,
                                  variantId: product
                                      .productVariants[
                                          selectedVariantIndex.value]
                                      .id,
                                  discountAllocations: []),
                            )) {
                              if (context.mounted) {
                                productAddedbottomSheet(
                                    context,
                                    "${product.image.split("?v=")[0]}?width=300",
                                    // product.images[0].originalSrc,
                                    // product.images[0].originalSrc,
                                    product.vendor,
                                    product.title,
                                    product.price,
                                    product.compareAtPrice);
                              }
                            }
                            isProcessing.value = false;
                          } catch (e) {
                            isProcessing.value = false;
                          }
                        } else {
                          showToastMessage(
                              message:
                                  "You have already added the max available in cart");
                        }
                      } else {
                        showToastMessage(
                            message:
                                "Whoa there! Maximum quantity reached. Try fewer items or save some for others! 😊");
                      }
                    } else {
                      isProcessing.value = true;
                      try {
                        if (await CartLogic.to.addToCart(
                          context: context,
                          fromProductDetailScreen: true,
                          lineItem: LineItem(
                              title: product
                                  .productVariants[selectedVariantIndex.value]
                                  .title,
                              quantity: productQuantity.value,
                              id: product.id,
                              variantId: product
                                  .productVariants[selectedVariantIndex.value]
                                  .id,
                              discountAllocations: []),
                        )) {
                          if (context.mounted) {
                            productAddedbottomSheet(
                                context,
                                "${product.image.split("?v=")[0]}?width=300",
                                product.vendor,
                                product.title,
                                product.price,
                                product.compareAtPrice);
                          }
                        }

                        isProcessing.value = false;
                      } catch (e) {
                        isProcessing.value = false;
                      }
                    }
                  }
                },
                isLoading: isProcessing.value,
                isDisable: product.productVariants[selectedVariantIndex.value]
                            .availableForSale ==
                        true
                    ? false
                    : true,
              )),
        ),
      );
    });
  }
}