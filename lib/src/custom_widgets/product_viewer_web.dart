import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'custom_app_bar.dart';

class WebViewProduct extends StatefulWidget {
  final String productUrl;

  const WebViewProduct({Key? key, required this.productUrl}) : super(key: key);

  @override
  State<WebViewProduct> createState() => _WebViewProductState();
}

class _WebViewProductState extends State<WebViewProduct> {

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // setState(() {
            //   _showProgressIndicator = (progress < 100);
            // });
            // log("==== current progress is $progress ====");

          },

          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            //
            // log("==== page loading finished $url ====");
            //
            // CartLogic.to.resetCart();
            // Future.delayed(const Duration(seconds: 6)).then((_) {
            //   if (mounted) {
            //     // controller.goBack();
            //     // Navigator.of(context).popUntil((route) => route.isFirst);
            //   }
            // });
          },
          onWebResourceError: (WebResourceError error) {

          },
          onNavigationRequest: (NavigationRequest request) async {
            // if (request.url.endsWith('/thank_you')) {
            //   CartLogic.to.resetCart();
            //   log("====> User Successfully Done with installed <==== ");
            //
            //
            //   await Future.delayed(const Duration(seconds: 10));
            //   log("===== 10 seconds done ========");
            //   // if(mounted) Navigator.pop(context);
            //
            //
            //
            //   // return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.productUrl));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "tapify",
        showCart: false,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}