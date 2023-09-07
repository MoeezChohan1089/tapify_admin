import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';

class AdminWebView extends StatefulWidget {
  final String pageURL;

  const AdminWebView({Key? key, required this.pageURL}) : super(key: key);

  @override
  State<AdminWebView> createState() => _AdminWebViewState();
}

class _AdminWebViewState extends State<AdminWebView> {
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
          onWebResourceError: (WebResourceError error) {},
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
      ..loadRequest(Uri.parse(widget.pageURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.to.appbarBGColor.value,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: SizedBox(
          height: 35.h,
          child: SvgPicture.asset(Assets.icons.layerIconLogo),
        ),
        leading: IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppConfig.to.iconCollectionColor.value,
              size: 22.sp,
            )),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
