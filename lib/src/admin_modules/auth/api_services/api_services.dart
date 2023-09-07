import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_controllers/database_controller.dart';
import '../../../utils/tapday_api_srvices/api_services.dart';
import '../../home/logic.dart';

adminUserLogInService({required String email, required String password}) async {
  try {
    Dio dio = Dio();
    final data = {
      'email': email,
      'password': password,
    };
    final response = await dio.post(TapDay.loginURL, data: data);
    Map<String, dynamic> responseData = response.data;
    log("new response is $responseData");

    if (response.statusCode == 200) {
      log("==>> SIGN IN :: response data -> $responseData =====${responseData['data']['token']}");
      LocalDatabase.to.box
          .write("adminSignedInToken", responseData["data"]["token"]);
      // LocalDatabase.to.box
      //     .write("adminSignedInShopToken", responseData["data"]["sh"]["access_token"]);
      return true;
    } else {
      debugPrint("==>> SIGN IN ERROR2 : Not 200 --> ${response.data} =====");
      return false;
    }
  } catch (error) {
    debugPrint("==>> SIGN IN ERROR : $error =====");
    return false;
  }
}

getShopByQRCode({required String qrToken}) async {
  try {
    Dio dio = Dio();
    var headers = {'Authorization': 'Bearer $qrToken'};
    final response = await dio.get(TapDay.getShopListURL,
        options: Options(headers: headers));

    Map<String, dynamic> responseData = response.data;

    log("Shop API response is => $responseData");
    if (response.statusCode == 200) {
      final logic = Get.put(AdminHomeLogic(), permanent: true);
      logic.customerShopsList.value = response.data["data"];
      debugPrint(
          "==>> customerShopList from HomeLogic is => ${logic.customerShopsList} =====");
      return true;
    } else {
      debugPrint(
          "==>> ERROR in getting shop list API  : Not 200 --> ${response.data} =====");
      return false;
    }
  } catch (error) {
    debugPrint("==>> ERROR in getting shop list API : $error =====");
    return false;
  }
}
