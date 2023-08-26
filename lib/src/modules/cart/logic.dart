import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shopify_flutter/models/src/checkout/checkout.dart';
// import 'package:shopify_flutter/models/src/checkout/line_item/line_item.dart';
// import 'package:shopify_flutter/shopify/src/shopify_checkout.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:tapify_admin/src/modules/cart/view.dart';
import 'package:tapify_admin/src/modules/product_detail/logic.dart';
import 'package:tapify_admin/src/utils/tapday_api_srvices/api_services.dart';

import '../../admin_modules/home/logic.dart';
import '../../api_services/shopify_flutter/models/models.dart';
import '../../custom_widgets/custom_product_bottom_sheet.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../custom_widgets/local_notification_service.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../global_controllers/currency_controller.dart';
import '../../utils/global_instances.dart';
import '../auth/view.dart';
import '../home/logic.dart';
import 'api_services.dart';
import 'components/discountCodeDialogue.dart';
import 'components/order_checkout_webview.dart';
import 'components/out_of_stock_lineitems_dialog.dart';
import 'components/un_completed_cart_dialog.dart';
import 'state.dart';

class CartLogic extends GetxController {
  static CartLogic get to => Get.find();
  final CartState state = CartState();

  ///------ Variables
  dynamic cartCheckoutID;
  Checkout? currentCart;
  List<LineItem> outOfStockLineItems = [];
  // List<Product> productList = [];
  List discountCodesAdded = [];
  List giftCardsAdded = [];
  dynamic totalDiscountApplied = 0;
  dynamic totalGiftCardAmountApplied = 0;
  TextEditingController discountCodeTextController = TextEditingController();
  TextEditingController giftCardTextController = TextEditingController();
  TextEditingController orderNoteTxtController = TextEditingController();
  Order? orderDetailsMain;
  Rx<bool> loaderEnable = false.obs;
  Rx<bool> isProcessing = false.obs;
  Rx<bool> loadingAnimation = false.obs;
  final NotificationService _notificationService = NotificationService();
  RxInt currentItemIndex = (-1).obs;

  String get getAccCreationSetting =>
      AppConfig.to.appSettingsCustomerAccount["checkAccountCreation"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    ///----- implement API logic here
    Future.delayed(const Duration(milliseconds: 2500), () {
      getCartCheckoutInfo(checkingUnCompleteCart: true);
    });
  }

  ///------ Functions

  checkUnCompletedCart() {
    if (currentCart != null && currentCart!.lineItems.isNotEmpty) {
      if (currentCart!.lineItems.isNotEmpty) {
        if (AppConfig.to.appSettingsCartAndCheckout["requiredAbandonendCart"] ==
            true) {
          unCompletedCartItemDialog();
        }
      } else {
        print("there is no item in cart");
      }
    } else {
      print('current cart is null');
    }
  }

  //---- Apply Discount From Home-Discount Widget
  applyDiscount(String shopifyCode) async {
    discountCodeTextController.text = shopifyCode;
    await applyDiscountCode();
    // showToastMessage(message: "Discount code has been added to ");
  }

  checkUnCompletedCartNotification() {
    if (currentCart != null && currentCart!.lineItems.isNotEmpty) {
      if (currentCart!.lineItems.isNotEmpty) {
        if (AppConfig.to.appSettingsCartAndCheckout["requiredAbandonendCart"] ==
            true) {
          Timer.periodic(Duration(hours: 1), (timer) {
            DateTime now = DateTime.now();
            DateTime scheduledTime = now.add(Duration(hours: 1));

            _notificationService.scheduleNotifications(
                id: cartLogic.currentCart!.lineItems.length,
                title: 'Message Reminder',
                body:
                    'Do not miss out on your cart items! Complete your purchase now and enjoy exclusive offers.',
                time: scheduledTime,
                payLoad: Get.to(() => CartPage()));
          });
        }
      } else {
        print("there is no item in cart");
      }
    } else {
      print('current cart is null');
    }
  }

  //---- Loading Animation
  loadAnimation() async {
    loadingAnimation.value = true;
    update();
    await Future.delayed(const Duration(milliseconds: 1000));
    loadingAnimation.value = false;
    update();
  }

  //---- Get Cart/Checkout Info
  getCartCheckoutInfo(
      {bool applyingCode = false, bool checkingUnCompleteCart = false}) async {
    try {
      final currentCheckOutId = await getCheckOutId();
      // ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
      final response = await shopifyCheckout
          .getCheckoutInfoQuery(currentCheckOutId, getShippingInfo: false);
      currentCart = response;
      // print("my tracking response on checkout info is => ${response.lineItems[1].variant!.quantityAvailable}");

      update();

      if (checkingUnCompleteCart) {
        checkUnCompletedCart();
        checkUnCompletedCartNotification();
      }

      //---- Discount Checker / Calculate Function
      discountChecker(isApplyingGiftOrDiscount: applyingCode);

      log("====> SUCCESS current cart details => $response  <=====");
    } catch (e) {
      log("====> ERROR getting current cart info $e <=====");
    }
  }

  //---- Create/Get Checkout ID
  Future<String> getCheckOutId() async {
    String? cartId = LocalDatabase.to.box.read("cartId");
    if (cartId != null) {
      return cartId;
    } else {
      try {
        // ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;

        final response = await shopifyCheckout.createCheckout();
        log("====> SUCCESS Cart Created with Id ${response.id}  <=====");
        LocalDatabase.to.box.write("cartId", response.id);
        return response.id;
      } catch (e) {
        log("====> ERROR Creating Cart $e <=====");
        throw Exception('Error creating cart: $e');
      }
    }
  }

  //---- Reset Cart
  resetCart() {
    log("==== Order Placed Resetting Cart ====");
    LocalDatabase.to.box.remove("cartId");
    currentCart = null;
    update();
  }

  addOrderNote() async {
    isProcessing.value = true;
    final currentCheckOutId = await getCheckOutId();
    await addOrderNoteToCheckout(
        currentCheckOutId, orderNoteTxtController.text);
    isProcessing.value = false;
    orderNoteTxtController.clear();
    Get.back();
    showToastMessage(message: "Order note has been added successfully");
  }

  Future<bool> addToCart({
    required BuildContext context,
    required LineItem lineItem,
    bool fromProductCardBottomSheet = false,
    bool fromProductDetailScreen = false,
    bool fromCartScreen = false,
    bool isDifferentVariant = false,
  }) async {
    bool returningValue = false;

    try {
      dynamic response;
      final currentCheckOutId = await getCheckOutId();
      if (fromCartScreen && isDifferentVariant) {
        response = await shopifyCheckout.updateLineItemsInCheckout(
          checkoutId: currentCheckOutId,
          lineItems: [
            lineItem,
          ],
        );
      } else {
        response = await shopifyCheckout.addLineItemsToCheckout(
          checkoutId: currentCheckOutId,
          lineItems: [
            lineItem,
          ],
        );
      }

      ///--------- Implement Discount logic Here
      if (LocalDatabase.to.box.read("tappedOnDiscount") != null &&
          LocalDatabase.to.box.read("tappedOnDiscount") == true) {
        //--- means discount yet to be added
        discountCodeTextController.text = HomeLogic.to.widgetShopifyCode.value;
        await applyDiscountCode();
        LocalDatabase.to.box.write("tappedOnDiscount", false);
      }
      currentCart = response;
      update();

      if (AppConfig.to.appSettingsCartAndCheckout["navigationCustomers"] ==
          true) {
        if (fromProductCardBottomSheet) {
          ProductSheet.to.isProcessing.value = false;
        }
        if (fromProductDetailScreen) {
          ProductDetailLogic.to.isProcessing.value = false;
        }
        checkoutToWeb();
        returningValue = false;
      } else {
        if (fromProductCardBottomSheet) {
          if (context.mounted) Navigator.pop(context);
          if (context.mounted && !fromCartScreen) {
            returningValue = true;

            // productAddedToCart(
            //     context,
            //     "${ProductSheet.to.controllerProduct!.images[0].originalSrc.split("?v=")[0]}?width=300",
            //     ProductSheet.to.controllerProduct!.vendor,
            //     ProductSheet.to.controllerProduct!.title,
            //     ProductSheet.to.controllerProduct!.price,
            //     ProductSheet.to.controllerProduct!.compareAtPrice);
          } else {
            showToastMessage(message: "Product has been updated");
          }
        }
        if (fromProductDetailScreen) {
          if (context.mounted) {
            //----- return true here
            returningValue = true;
          }
        }
      }
      log("====> SUCCESS product added to cart <=====");
      return returningValue;
    } catch (e) {
      log("Error in adding product => $e");
      return false;
    }
  }

  removeFromCart({required LineItem lineItem}) async {
    try {
      // ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;

      final currentCheckOutId = await getCheckOutId();
      final response = await shopifyCheckout.removeLineItemsFromCheckout(
        checkoutId: currentCheckOutId,
        lineItems: [
          lineItem,
        ],
      );
      currentCart = response;
      // print("my tracking response on remove from cart is => ${response.lineItems[2].variant!.quantityAvailable}");

      isProcessing.value = false;
      update();
      log("====> SUCCESS product removed from cart $response  <=====");
    } catch (e) {
      isProcessing.value = false;
      log("====> ERROR removing product from cart $e <=====");
    }
  }

  //---- Update Product Quantity In Cart
  updateProductQuantity(
      {required BuildContext context, required LineItem lineItem}) async {
    try {
      // customLoaderWidget.hideLoader();
      // customLoaderWidget.showLoader(context);
      // ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;
      final currentCheckOutId = await getCheckOutId();
      final response = await shopifyCheckout.updateLineItemsInCheckout(
        checkoutId: currentCheckOutId,
        lineItems: [
          lineItem,
        ],
      );
      // customLoaderWidget.hideLoader();
      currentCart = response;
      // print("my tracking response on update cart is => ${response.lineItems[2].variant!.quantityAvailable}");

      isProcessing.value = false;
      update();
      log("====> SUCCESS product update in cart $response  <=====");
    } catch (e) {
      // customLoaderWidget.hideLoader();
      isProcessing.value = false;
      log("====> ERROR product update in cart $e <=====");
    }
  }

  //---- Apply Discount
  applyDiscountCode({String discountCode = "B2JPKHWFV7NX"}) async {
    //---- Order off 30%
    // applyDiscountCode({String discountCode = "5731CA08E56H"}) async {   //--- product off discount  50%
    log("==== in the discount apply function ====");

    try {
      final currentCheckOutId = await getCheckOutId();
      final response = await shopifyCheckout.checkoutDiscountCodeApply(
          currentCheckOutId, discountCodeTextController.text);
      getCartCheckoutInfo(applyingCode: true);
      discountCodesAdded = [];
      LocalDatabase.to.box.remove("discountCodes");
    } catch (e) {
      log("====> ERROR applying discount code $e <=====");
      await Future.delayed(const Duration(milliseconds: 250));
      isProcessing.value = false;
      discountCodeTextController.clear();
      showToastMessage(message: "Discount code is invalid or has been expired");
    }
  }

  //---- Remove Discount Code from Cart
  removeDiscountCode(int index) async {
    log("in the remove discount doe function");

    isProcessing.value = true;

    try {
      // ShopifyCheckout shopifyCheckout = ShopifyCheckout.instance;

      final currentCheckOutId = await getCheckOutId();
      // final response =
      final response = await shopifyCheckout.checkoutDiscountCodeRemove(
        currentCheckOutId,
      );
      await getCartCheckoutInfo();

      //---- Remove from Local
      showToastMessage(
          message:
              "Discount code ${discountCodesAdded[index]} has been removed from cart");
      discountCodesAdded.removeAt(index);
      if (discountCodesAdded.isEmpty) {
        log("list is empty now");
        LocalDatabase.to.box.remove("discountCodes");
        totalDiscountApplied = 0;
      } else {
        log("list is not empty now");
        LocalDatabase.to.box.write("discountCodes", discountCodesAdded);
      }
      isProcessing.value = false;
      update();

      log("====> SUCCESS discount code removed $response  <=====");
    } catch (e) {
      isProcessing.value = false;

      log("====> ERROR removing discount code $e <=====");
    }
  }

  //---- Check / Calculate Discount Amount
  discountChecker({bool isApplyingGiftOrDiscount = false}) {
    //--- Remove the Previous Applied Discount Codes
    totalDiscountApplied = 0;

    //---- Remove the Previous Applied GiftCards
    totalGiftCardAmountApplied = 0;
    // giftCardsAdded = [];
    // LocalDatabase.to.box.remove("giftCards");

    if (currentCart != null) {
      if (currentCart!.lineItems.isNotEmpty) {
        for (var element in currentCart!.lineItems) {
          if (element.discountAllocations.isNotEmpty) {
            for (var discount in element.discountAllocations) {
              log("===== ${discount.allocatedAmount?.amount} ====");
              totalDiscountApplied =
                  totalDiscountApplied + discount.allocatedAmount?.amount;
            }
          }
        }
      }

      if (currentCart!.appliedGiftCards.isNotEmpty) {
        for (var giftCard in currentCart!.appliedGiftCards) {
          log("===== ${giftCard.amountUsedV2.amount} ====");
          totalGiftCardAmountApplied =
              totalGiftCardAmountApplied + giftCard.amountUsedV2.amount;
        }
      }
    }

    if (totalDiscountApplied != 0) {
      if (LocalDatabase.to.box.read("discountCodes") != null) {
        discountCodesAdded = LocalDatabase.to.box.read("discountCodes");
        if (discountCodeTextController.text.isNotEmpty &&
            !discountCodesAdded
                .contains(discountCodeTextController.text.toUpperCase())) {
          discountCodesAdded.add(discountCodeTextController.text.toUpperCase());
          LocalDatabase.to.box.write("discountCodes", discountCodesAdded);
        }
      } else {
        if (discountCodeTextController.text.isNotEmpty) {
          discountCodesAdded.add(discountCodeTextController.text.toUpperCase());
          LocalDatabase.to.box.write("discountCodes", discountCodesAdded);
        }
      }
      if (isApplyingGiftOrDiscount) {
        showToastMessage(
            message:
                "Discount code applied, you have saved $totalDiscountApplied");
      }
    } else {
      // if(isApplyingGiftOrDiscount) {
      //   showToastMessage(message: "Discount code is invalid or expired");
      // }
      LocalDatabase.to.box.remove("discountCodes");
    }
    if (isApplyingGiftOrDiscount) {
      // customLoaderWidget.hideLoader();

      isProcessing.value = false;
    }

    discountCodeTextController.clear();
    giftCardTextController.clear();
    update();

    // log("====> Total Calculated/Applied Discount is $totalDiscountApplied   <=====");
  }

  //---- Apply Gift Card to Checkout
  applyGiftCard({String giftCard = "997588B94E4F3DG5"}) async {
    log("==== in the gift card apply function ====");

    try {
      final currentCheckOutId = await getCheckOutId();
      final response = await shopifyCheckout.checkoutGiftCardAppend(
          currentCheckOutId, [giftCardTextController.text]);
      log("====> SUCCESS applied gift card to cart  <=====");
      showToastMessage(message: "Gift Card has been applied successfully");
      getCartCheckoutInfo(applyingCode: true);
    } catch (e) {
      log("====> ERROR applying gift card  $e <=====");
      // customLoaderWidget.hideLoader();
      await Future.delayed(const Duration(milliseconds: 250));
      isProcessing.value = false;
      giftCardTextController.clear();
      showToastMessage(
          message: "Gift Card is invalid or has been consumed already");
    }
  }

  //---- Remove Gift Card from Checkout
  removeGiftCard({required String giftCardId}) async {
    log("==== in the gift card removing function ====");
    isProcessing.value = true;
    try {
      final currentCheckOutId = await getCheckOutId();
      // const giftCardId = "gid://shopify/AppliedGiftCard/317943316792";
      final response = await shopifyCheckout.checkoutGiftCardRemove(
          giftCardId, currentCheckOutId);
      log("====> SUCCESS removed gift card from cart  <=====");
      giftCardTextController.clear();
      showToastMessage(message: "Gift Card has been removed from cart");
      await getCartCheckoutInfo();
      isProcessing.value = false;
    } catch (e) {
      isProcessing.value = false;
      log("====> ERROR removing gift card  $e <=====");
      showToastMessage(message: "Error in removing Gift Card");
    }
  }

  //----- check if out of stock before checkout
  Future<bool> checkIfItemsOutOfStock() async {
    isProcessing.value = true;

    await resetShopify();
    outOfStockLineItems = [];
    // bool anyItemOutOfStock = false;
    final currentCheckOutId = await getCheckOutId();
    final response = await shopifyCheckout
        .getCheckoutInfoQuery(currentCheckOutId, getShippingInfo: false);
    currentCart = response;
    update();

    ///------ till here you have get the updated cart
    ///---- now
    ///-------- check if any item is out of stock before placning the order
    for (LineItem item in response.lineItems) {
      if (item.variant!.availableForSale == false) {
        outOfStockLineItems.add(item);
      }
    }
    update();

    log("eturning log => ${outOfStockLineItems.isEmpty ? false : true}");

    return outOfStockLineItems.isEmpty ? false : true;
  }

  //----- Route to Checkout Web
  checkoutToWeb({bool continueAsGuest = false}) async {
    checkOutFunction() async {
      final currentCheckOutId = await getCheckOutId();
      if (CartLogic.to.getAccCreationSetting.contains("Disabled") ||
          continueAsGuest == true) {
        Get.to(() => CheckoutWebView(
              checkoutUrl: currentCart?.webUrl ?? "",
              checkoutAsGuest: continueAsGuest,
            ));
      } else {
        if (LocalDatabase.to.box.read("customerAccessToken") != null) {
          // final currentCheckOutId = await getCheckOutId();

          ///------ Associate the Cart to Current User
          try {
            final userAccessToken =
                await LocalDatabase.to.box.read("customerAccessToken");
            log('==== current user id is ${LocalDatabase.to.box.read("customerAccessToken")} ====');
            await shopifyCheckout.checkoutCustomerAssociate(
                currentCheckOutId, userAccessToken);
            log("====> SUCCESS :: Checkout Associated To Current User <====-");

            ///------ Go to Checkout
            Get.to(() => CheckoutWebView(
                  checkoutUrl: currentCart?.webUrl ?? "",
                ));
          } catch (e) {
            log("====> ERROR associating checkout to user $e <=====");
          }
        } else {
          Get.to(
              () => AuthPage(
                    onSuccess: () async {
                      await shopifyCheckout.checkoutCustomerAssociate(
                          currentCheckOutId,
                          LocalDatabase.to.box.read("customerAccessToken"));
                      Get.off(() => CheckoutWebView(
                            checkoutUrl: currentCart?.webUrl ?? "",
                          ));
                    },
                  ),
              transition: Transition.downToUp,
              fullscreenDialog: true,
              duration: const Duration(milliseconds: 250));
        }
      }
    }

    if (await checkIfItemsOutOfStock()) {
      isProcessing.value = false;
      outOfStockCartItemsDialog(
          context: Get.context!,
          onContinue: () => checkOutFunction(),
          outOfStockLineItems: outOfStockLineItems);
    } else {
      isProcessing.value = false;
      checkOutFunction();
    }
  }

  //----create Order For Super Admin------//
  createOrderService(
      {required String user_email,
      required String order_id,
      required String amount}) async {
    try {
      Dio dio = Dio();

      final data = {
        'shop': AdminHomeLogic.to.browsingShopDomain.value,
        'user_email': user_email,
        'order_id': order_id,
        'amount': amount,
        'type': Platform.isAndroid ? 'Android' : 'IOS'
      };

      print(
          "barrer Token is: ===== ${LocalDatabase.to.box.read('staticUserAuthToken')}");

      var headers = {
        'Authorization':
            'Bearer ${LocalDatabase.to.box.read('staticUserAuthToken')}'
      };

      final response = await dio.post(
        '${TapDay.createOrderURL}',
        data: data,
        options: Options(headers: headers),
      );

      Map<String, dynamic> responseData = response.data;

      // Handle the response
      if (response.statusCode == 200 && responseData["success"] == true) {
        // Request succeeded

        // Process the response data as needed

        log("==>> Create Order For Admin -> $responseData =====");

        return true;
      } else {
        // Request failed
        debugPrint("==>> Error In Order : Not 200 --> ${response.data} =====");
        return false;
      }
    } catch (error) {
      // Handle any Dio errors or exceptions
      debugPrint("==>> Order IN ERROR : $error =====");
      showToastMessage(message: "$error");

      // Get.showSnackbar(
      //   GetSnackBar(
      //     isDismissible: true,
      //     message: '$error',
      //     duration: const Duration(seconds: 2),
      //     backgroundColor: Colors.black,
      //   ),
      // );
      return false;
    }
  }

  //------ Return Cart Total Amount
  String returnCartSubTotal() {
    return CurrencyController.to.getConvertedPrice(
        priceAmount: ((cartLogic.currentCart!.totalPriceV2.amount -
                        getOutOfStockItemsAmount()) -
                    cartLogic.totalGiftCardAmountApplied) <
                0
            ? 0
            : ((cartLogic.currentCart!.totalPriceV2.amount -
                    getOutOfStockItemsAmount()) -
                cartLogic.totalGiftCardAmountApplied));
  }

  //----- Calculate Total Amount of All Out of Stock Items
  getOutOfStockItemsAmount() {
    double amountCalculated = 0.0;
    for (LineItem item in currentCart!.lineItems) {
      if (item.variant!.availableForSale == false) {
        amountCalculated =
            amountCalculated + (item.variant!.priceV2!.amount * item.quantity);
      }
    }
    return amountCalculated;
  }

  //----- if quantity of tapped product is greater than 0
  //----- frist check if tapped product already available in cart
  //------- if yes, then check how many units are available of tapped and how many of the same are in the cart
  //----------- if both matches () then show message you have already added max of available
  //----------- if
  // bool checkFromCart(int availableQuantityOfVariant, int quantityToBeAdded, dynamic variantId) {
  //   bool checker = false;
  //   int indexOfProduct = currentCart!.lineItems.indexWhere((variant) => variant.variantId == variantId);
  //   int quantityInCart = currentCart!.lineItems[indexOfProduct].quantity;
  //   (quantityToBeAdded == quantityInCart) ? false :
  //   return checker;
  // }
  bool checkFromCart(int availableQuantityOfVariant, int quantityToBeAdded,
      dynamic variantId) {
    if (currentCart == null || currentCart!.lineItems.isEmpty) {
      return true; // Cart is empty, so product can be added
    }

    int indexOfProduct = currentCart!.lineItems
        .indexWhere((variant) => variant.variantId == variantId);

    if (indexOfProduct == -1) {
      return true; // Product not found in cart, so it can be added
    }

    int quantityInCart = currentCart!.lineItems[indexOfProduct].quantity;

    // Condition 1: Add only if the total quantity in cart and to be added is less than available
    if (quantityInCart + quantityToBeAdded <= availableQuantityOfVariant) {
      return true; // Product can be added
    }

    // Condition 2: Check if trying to add same quantity as already in cart
    if (quantityToBeAdded == quantityInCart) {
      return false; // Product already added with same quantity
    }

    // Condition 3: Allow adding if available quantity is greater than or equal to requested quantity
    if (availableQuantityOfVariant >= (quantityInCart + quantityToBeAdded)) {
      return true; // Product can be added
    }

    return false; // Other conditions not met, product can't be added
  }
}
