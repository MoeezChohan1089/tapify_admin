import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../global_controllers/database_controller.dart';
import '../../../utils/tapday_api_srvices/api_services.dart';

staticUserAPI({required String email, required String password}) async {
  try {
    Dio dio = Dio();
    final data = {
      'email': email,
      'password': password,
    };
    final response = await dio.post(TapDay.adminLoginURL1, data: data);
    Map<String, dynamic> responseData = response.data;
    log("new response is $responseData");

    if (response.statusCode == 200 &&
        responseData["data"]["access_token"] != null) {
      log("==>> SIGN IN :: response data is here 2 -> $responseData =====${responseData['data']['access_token']}");
      LocalDatabase.to.box.write("sessionActive", true);
      // LocalDatabase.to.box
      //     .write("storeAdminToken", responseData["data"]["access_token"]);
      LocalDatabase.to.box
          .write("staticAdminAuthToken", responseData["data"]["token"]);
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