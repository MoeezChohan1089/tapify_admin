import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify/src/global_controllers/database_controller.dart';
import 'package:tapify/src/utils/tapday_api_srvices/api_services.dart';

import '../../../custom_widgets/custom_snackbar.dart';
import '../../../utils/global_instances.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';



signInUserApiService({required String email, required String password}) async {
  log(" in the sign in user function ");
  try {
    // final shopifyStore = ShopifyAuth.instance;
    final userInfoResponse = await shopifyAuth.signInWithEmailAndPassword(email: email, password: password,);
    log("====== user response data is $userInfoResponse ======");
    LocalDatabase.to.box.write("sessionActive", true);
    LocalDatabase.to.box.write("customerAccessToken", await shopifyAuth.currentCustomerAccessToken);

    log("=== Retrieved Customer Access Token ${LocalDatabase.to.box.read("customerAccessToken")}  ===");

    List userInfo = [{
      "firstname": "${userInfoResponse.firstName}",
      "lastname": "${userInfoResponse.lastName}",
      "email": "${userInfoResponse.email}",
      "id": "${userInfoResponse.id}"
    }
    ];
    LocalDatabase.to.box.write("userInfo", userInfo);
    // LocalDatabase.to.box.write("customerAccessToken", user.);

    return true;
  } catch (e) {
    debugPrint(" Error in fetching products ${e.toString()}");
    return false;
  }
}

createCustomerApiService({required  String firstName, lastName, email, password}) async {

  try {
    // final shopifyStore = ShopifyAuth.instance;
    final userInstance = await shopifyAuth.createUserWithEmailAndPassword(firstName: firstName, lastName: lastName, email: email, password: password,);

    debugPrint("=== SUCCESS :: Account created $userInstance  ===");

    List userInfo = [{
      "firstname": "${userInstance.firstName}",
      "lastname": "${userInstance.lastName}",
      "email": "${userInstance.email}",
      "id": "${userInstance.id}"
    }
    ];
    LocalDatabase.to.box.write("userInfo", userInfo);

    return true;
  } catch (e) {
    debugPrint("====> ERROR :: in creatig account ${e.toString()} <=====");
    return false;
  }
}

createClientService({required String firstName, required String lastName, required String email}) async {
  try {
    Dio dio = Dio();

    final data = {
      'shop': LocalDatabase.to.box.read('domainShop')?? '${TapDay.shopNameUrl}',
      'first_name': firstName,
      'last_name': lastName,
      'display_name': '$firstName $lastName',
      'email': email
    };

    print("barrer Token is: ===== ${LocalDatabase.to.box.read('staticUserAuthToken')}");

    var headers = {
      'Authorization': 'Bearer ${LocalDatabase.to.box.read('staticUserAuthToken')}'
    };

    final response = await dio.post(
      '${TapDay.adminCreateClientURL}',
      data: data,
      options: Options(headers: headers),
    );


    log("our server account creation $response");


    Map<String, dynamic> responseData = response.data;

    // Handle the response
    if (response.statusCode == 200 && responseData["success"] == true) {
      // Request succeeded

      // Process the response data as needed

      log("==>> Create client response data -> $responseData =====");

      LocalDatabase.to.box.write("sessionActive", true);
      LocalDatabase.to.box.write("customerDefaultAccessToken", responseData["access_token"]);
      LocalDatabase.to.box.write("adminToken", responseData["token"]);
      // showToastMessage(message: "User Created Successfully.");

      return true;




    } else {
      // Request failed
      return false;
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    showToastMessage(message: "$error");
    // Get.showSnackbar(
    //   GetSnackBar(
    //     isDismissible: true,
    //     message: '$error',
    //     duration: const Duration(seconds: 2),
    //     backgroundColor: Colors.black,
    //   ),
    // );
    return false;

  }

}

forgotPasswordApiService({required String email}) async{
  try {
    // final shopifyStore = ShopifyAuth.instance;
    await shopifyAuth.sendPasswordResetEmail(email: email);
    debugPrint("====> SUCCESS :: Password reset link has been sent successfully  <====");
    return true;
  } catch (e) {
    debugPrint("====> ERROR :: in sending reset link ${e.toString()} <=====");
    return false;
  }
}

staticUserAPI({required String email, required String password}) async {
  try {
    Dio dio = Dio();
    final data = {
      'email': email,
      'password': password,
    };
    final response = await dio.post(
        '${TapDay.adminLoginURL}',
        data: data
    );
    Map<String, dynamic> responseData = response.data;
    log("new response is $responseData");

    if (response.statusCode == 200 && responseData["data"]["access_token"] != null) {
      log("==>> SIGN IN :: response data is here 2 -> $responseData =====${responseData['data']['access_token']}");
      LocalDatabase.to.box.write("sessionActive", true);
      LocalDatabase.to.box.write("storeAdminToken", responseData["data"]["access_token"]);
      LocalDatabase.to.box.write("staticUserAuthToken", responseData["data"]["token"]);
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