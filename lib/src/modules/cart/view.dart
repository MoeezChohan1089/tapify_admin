import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

// import 'package:shopify_flutter/shopify/src/shopify_checkout.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_dialogue_cart.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/local_notification_service.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/colors.dart';
import '../auth/components/custom_button.dart';
import '../auth/view.dart';
import '../bottom_nav_bar/view.dart';
import 'components/cart_bottom_checkout_and_price.dart';
import 'components/cart_list_products.dart';
import 'components/customDiscountCode.dart';
import 'components/order_checkout_webview.dart';
import 'logic.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final logic = Get.put(CartLogic());

  final state = Get
      .find<CartLogic>()
      .state;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (logic.currentCart != null &&
          logic.currentCart!.lineItems.isNotEmpty) {
        logic.loadAnimation();
        print(
            "Value of cart length is: ${logic.currentCart!.lineItems.length}");
      } else {
        print("Value of cart length is: 0");
      }
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'cart',
        backIcon: Icons.close,
        trailingButton: GetBuilder<CartLogic>(
            builder: (logic) {
              return
                (logic.currentCart != null &&
                    logic.currentCart!.lineItems.isNotEmpty) ?
                TextButton(
                  onPressed: () async {
                    customDialogueBox(context);
                  },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.red
                  ),
                  child: Text('Clear Cart',
                    style: context.text.bodyMedium?.copyWith(
                        color: AppConfig.to.appbarBGColor.value ==
                            const Color(0xffFF0000) ? AppConfig.to.iconCollectionColor
                            .value : Colors.red
                    ),
                  ),
                ) : const SizedBox.shrink()
              ;
            }),
      ),
      body: GetBuilder<CartLogic>(builder: (cartLogic) {
        print("fffggfghfhfghfgh: ${AppConfig.to.appbarBGColor.value}" );
        return (cartLogic.currentCart != null &&
            cartLogic.currentCart!.lineItems.isNotEmpty)
            ? cartLogic.loadingAnimation.isTrue ? Center(
          child: SpinKitThreeBounce(
            color: AppColors.appTextColor,
            size: 30.sp,
          ),
        ) : Column(
          children: [
            DiscountCodeAndGiftCardFields(),
            Expanded(
                child: FadeIn(
                    // delay: const Duration(milliseconds: 250),
                    duration: const Duration(milliseconds: 500),
                    child: const SingleChildScrollView(
                        child: CartProductList()))),
          ],
        )
            : Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.images.emptyCartImage,
                width: 100,
              ),
              30.heightBox,
              Text(
                "Your cart is empty!",
                style:
                context.text.labelMedium?.copyWith(fontSize: 17.sp),
              ),
              8.heightBox,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: Text(
                  "Looks like you haven't added any product to your cart yet!",
                  textAlign: TextAlign.center,
                  style: context.text.bodyMedium?.copyWith(
                    color: AppColors.customGreyPriceColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 58, vertical: 38),
                child: GlobalElevatedButton(
                  text: "Start Shopping", onPressed: () {
                  Get.to(() => BottomNavBarPage(), opaque: false, transition: Transition.native);
                },
                  isLoading: false,
                ),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: GetBuilder<CartLogic>(builder: (cartLogic) {
        return  cartLogic.loadingAnimation.isTrue  ? const SizedBox.shrink() : SlideInUp(
            duration: const Duration(milliseconds: 500),
            child: CartBottomPriceSheet());
      }),
    );
  }
}