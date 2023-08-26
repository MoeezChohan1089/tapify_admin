import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
              Future.delayed( Duration(seconds: LocalDatabase.to.box.read('customerAccessToken') != null ? 6:12),(){
                // Navigator.pop(context);

                if(widget.checkoutAsGuest){
                  Navigator.pop(context);
                } else {
                 if(LocalDatabase.to.box.read('customerAccessToken') != null){
                   Get.off(()=>  OrderPage(navigateToNext: true,));
                   ordersListLogic.getOrdersService();
                 }else{
                   Get.off(()=>  BottomNavBarPage());
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
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          "Checkout".toUpperCase(),
          style: TextStyle(fontFamily: 'Sofia Pro Regular', fontSize: 18.sp),
        ),
        leading: IconButton(
          onPressed: () async{
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}