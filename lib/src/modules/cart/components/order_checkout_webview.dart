import 'dart:async';
import 'dart:developer';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../global_controllers/database_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../bottom_nav_bar/view.dart';
import '../../order/logic.dart';
import '../../order/view.dart';
import '../logic.dart';

///-------------- CheckOut Web View

class CheckoutWebView extends StatefulWidget {
  final String checkoutUrl;
  final bool checkoutAsGuest;

  const CheckoutWebView({Key? key, required this.checkoutUrl, this.checkoutAsGuest = false}) : super(key: key);

  @override
  State<CheckoutWebView> createState() => _CheckoutWebViewState();
}

class _CheckoutWebViewState extends State<CheckoutWebView> {

  // final Completer<WebViewController> _controller =
  // Completer<WebViewController>();

  late final WebViewController controller;
   bool _showProgressIndicator = true;
  final logic = Get.put(CartLogic());
  final ordersListLogic = Get.put(OrderLogic());

  final InAppReview inAppReview = InAppReview.instance;
  bool hasShownReview = false;

  void _checkAndShowInAppReview() async {
    bool isAvailable = await inAppReview.isAvailable();
    if (isAvailable) {
      //Delay by 2 or 3 seconds before showing the review
      Future.delayed(Duration(seconds: 2), () {
        inAppReview.requestReview();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _showProgressIndicator = (progress < 100);
            });
            log("==== current progress is $progress ====");

          },

          onPageStarted: (String url) {},
          onPageFinished: (String url) {

            log("==== page loading finished $url ====");

              // CartLogic.to.resetCart();
              Future.delayed(const Duration(seconds: 6)).then((_) {
                if (mounted) {
                  // controller.goBack();
                  // Navigator.of(context).popUntil((route) => route.isFirst);
                }
              });
            },
          onWebResourceError: (WebResourceError error) {

          },
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.endsWith('/thank_you')) {
              CartLogic.to.resetCart();
              Future.delayed(const Duration(seconds: 6),() {
                // Navigator.pop(context);

                if(widget.checkoutAsGuest){
                  Navigator.pop(context);
                } else {
                  if (widget.checkoutAsGuest) {
                    Navigator.pop(context);
                  } else {
                    if (LocalDatabase.to.box.read('customerAccessToken') !=
                        null) {
                      Get.off(() => OrderPage(navigateToNext: true,));
                      ordersListLogic.getOrdersService();
                      // _checkAndShowInAppReview();
                    } else {
                      Get.off(() => BottomNavBarPage());
                      // _checkAndShowInAppReview();
                    }
                    if (!hasShownReview) {
                      _checkAndShowInAppReview();
                      hasShownReview = true;
                    }
                  }
                }

              });
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
      // ..loadRequest(Uri.parse('https://flutter.dev'));

    // #enddocregion webview_controller
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.customWhiteTextColor,
          leading: IconButton(
              onPressed: (){
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppConfig.to.iconCollectionColor.value,
                size: 22.sp,
              )),
          title: Text(
            'checkout'.toUpperCase(),
            style: context.text.titleSmall?.copyWith(
                fontSize: 16.sp,
                color: Colors.black),
          )
          // Obx((){
          //   return AppConfig.to.homeAppBarLogo.value == ''
          //       ? Text(
          //     'checkout'.toUpperCase(),
          //     style: context.text.titleSmall?.copyWith(
          //         fontSize: 16.sp,
          //         color: AppConfig.to.iconCollectionColor.value),
          //   )
          //       : SizedBox(
          //     height: 35.h,
          //     // color: Colors.red,
          //     child: ExtendedImage.network(
          //       AppConfig.to.homeAppBarLogo.value,
          //       fit: BoxFit.cover,
          //       // ensures that the image scales down if necessary, but not up
          //       // width: double.infinity,
          //       cache: true,
          //       loadStateChanged: (ExtendedImageState state) {
          //         switch (state.extendedImageLoadState) {
          //           case LoadState.loading:
          //             return Shimmer.fromColors(
          //               baseColor: Colors.grey[300]!,
          //               highlightColor: Colors.grey[100]!,
          //               child: Container(
          //                 width: 100,
          //                 height: 70,
          //                 color: Colors.grey[300],
          //               ),
          //             );
          //           case LoadState.completed:
          //             return null; //return null, so it continues to display the loaded image
          //           case LoadState.failed:
          //             return SvgPicture.asset(
          //               Assets.icons.noImageIcon,
          //               height: 20,
          //               width: 50,
          //             );
          //           default:
          //             return null;
          //         }
          //       },
          //     ),
          //   );
          // })
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}