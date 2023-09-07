import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpecificWebContent extends StatefulWidget {
  final String? url;

  SpecificWebContent({@required this.url});

  @override
  State<SpecificWebContent> createState() => _SpecificWebContentState();
}

class _SpecificWebContentState extends State<SpecificWebContent> {
  late final WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
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
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
