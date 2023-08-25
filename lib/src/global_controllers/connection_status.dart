import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import '../custom_widgets/custom_elevated_button.dart';
import '../utils/constants/assets.dart';
import '../utils/constants/colors.dart';


class NetworkConnection extends GetxController {
  static NetworkConnection get instance => Get.find();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription?.cancel();
    super.onClose();
  }


  void updateConnectionStatus(ConnectivityResult connectivityResult) async {
    final hasInternet = await checkInternetAccess();

    if (hasInternet) {
      if (isDialogVisible) {
        Get.back(); // Dismiss the dialog
        isDialogVisible = false;
      }
    } else {
      if (!isDialogVisible) {
        showNoInternetDialog();
        isDialogVisible = true;
      }
    }
  }

  bool isDialogVisible = false;


  void showNoInternetDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      title: " ",
      titleStyle: const TextStyle(
        fontSize: .1
      ),
      content: Container(
        decoration: BoxDecoration(
          color: AppColors.customWhiteTextColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.images.connectionImage,
              // width: 100,
            ),
            14.heightBox,
            Text('No Internet Connection!', textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Sofia Pro Semi Bold',
                  fontSize: 16.sp, color: AppColors.appTextColor,
                )),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Please check your internet connection and try again...', textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Sofia Pro Medium',
                    fontSize: 14.sp, color: AppColors.customGreyPriceColor),),
            ),
            30.heightBox,
            GlobalElevatedButton(
              text: "Try Again",
              onPressed: () {
                // _connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
              },
              isLoading: false,
              applyHorizontalPadding: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkInternetAccess() async {
    log("in the function");
    try {
      final response = await Dio().head('https://www.google.com');
      return response.statusCode == 200; // Internet access is available
    } catch (e) {
      return false; // Unable to access the internet
    }
  }

}