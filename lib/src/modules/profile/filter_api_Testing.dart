import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';

import '../../utils/tapday_api_srvices/api_services.dart';

testFilterApi() async {
  Dio dio = Dio();
  String apiUrl =
      "https://${LocalDatabase.to.box.read('domainShop')}/api/graphql";

  String graphqlQuery = r'''
  query Facets {
    collection(handle: "exquisite-car-conclave") {
      handle
      products(first: 250) {
        filters {
          id
          label
          type
          values {
            id
            label
            count
            input
          }
        }
      }
    }
  }
''';

  try {
    dio.options.headers["X-Shopify-Storefront-Access-Token"] =
        "${TapDay.storeFrontAccessToken}";
    dio.options.headers["Content-Type"] = "application/graphql";

    final response = await dio.post(apiUrl, data: graphqlQuery);

    // Response response = await dio.post(
    //   apiUrl,
    //   data: {'query': graphqlQuery},
    // );

    if (response.statusCode == 200) {
      // Handle the successful response here
      var responseData = response.data;
      // Process the responseData as needed
      log("===> Here is the response $responseData <====");
    } else {
      // Handle other status codes or errors
      log("===> Error in Status Code ${response.statusCode} <====");
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    log("===> Exception Caught $error <====");
  }
}
