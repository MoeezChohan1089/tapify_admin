import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../global_controllers/database_controller.dart';
import '../../../utils/tapday_api_srvices/api_services.dart';

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
