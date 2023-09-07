import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../global_controllers/app_config/config_controller.dart';
import '../utils/constants/assets.dart';
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
        title: Obx((){
          return AppConfig.to.homeAppBarLogo.value == ''
              ? Text(
            'tapday'.toUpperCase(),
            style: context.text.titleSmall?.copyWith(
                fontSize: 16.sp,
                color: AppConfig.to.iconCollectionColor.value),
          )
              : SizedBox(
            height: 35.h,
            // color: Colors.red,
            child: ExtendedImage.network(
              AppConfig.to.homeAppBarLogo.value,
              fit: BoxFit.cover,
              // ensures that the image scales down if necessary, but not up
              // width: double.infinity,
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 70,
                        color: Colors.grey[300],
                      ),
                    );
                  case LoadState.completed:
                    return null; //return null, so it continues to display the loaded image
                  case LoadState.failed:
                    return SvgPicture.asset(
                      Assets.icons.noImageIcon,
                      height: 20,
                      width: 50,
                    );
                  default:
                    return null;
                }
              },
            ),
          );
        })
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}