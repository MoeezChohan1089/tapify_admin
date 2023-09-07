import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';

class CustomLoaderWidget {
  static CustomLoaderWidget? _customLoader;

  CustomLoaderWidget._createObject();

  factory CustomLoaderWidget() {
    if (_customLoader != null) {
      return _customLoader!;
    } else {
      _customLoader = CustomLoaderWidget._createObject();
      return _customLoader!;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState? _overlayState; //= new OverlayState();
  OverlayEntry? _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return SizedBox(height: 30, width: 30, child: buildLoader(context));
      },
    );
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState!.insert(_overlayEntry!);
  }

  hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {
      if (kDebugMode) {
        print("Exception:: $e");
      }
    }
  }

  buildLoader(BuildContext context, {Color? backgroundColor}) {
    backgroundColor ??= const Color(0xffa8a8a8).withOpacity(.5);

    return CustomScreenLoader(
      height: 20,
      width: 20,
      backgroundColor: backgroundColor,
    );
  }
}

class CustomScreenLoader extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  const CustomScreenLoader(
      {Key? key,
        this.backgroundColor = const Color(0xfff8f8f8),
        this.height = 30,
        this.width = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.horizontalRotatingDots(
          color: Colors.black,
          size: 50,
        ));
  }
}