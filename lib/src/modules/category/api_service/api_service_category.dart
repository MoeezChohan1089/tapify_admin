import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
// import 'package:shopify_flutter/models/src/product/products/products.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';
import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../utils/global_instances.dart';
import '../../../utils/tapday_api_srvices/api_services.dart';
import '../../home/view.dart';
import 'model_filters.dart';



categoryApiService({required List<Collection> store}) async{
  try {
    // final shopifyStore = ShopifyStore.instance;
    final categoryProducts = await shopifyStore.getAllCollections();
    store = categoryProducts;
    // LocalDatabase.to.box.remove("customerAccessToken");
    log("=== length of retrieved products collection: $store  ===");
    // // LocalDatabase.to.box.write("sessionActive", true);
    // List userInfo = [{
    //   "name": "${user.firstName} ${user.lastName}",
    //   "email": "${user.email}"
    // }
    // ];
    // LocalDatabase.to.box.write("userInfo", userInfo);
    // LocalDatabase.to.box.write("customerAccessToken", user.);

    return true;
  } catch (e) {
    debugPrint(" Error in fetching collection ${e.toString()}");
    return false;
  }
}

Future<List<Filter>> getCollectionFilters({required String collectHandle}) async {

  print("handle received is $collectHandle");

  Dio dio = Dio();
  String apiUrl = "https://${LocalDatabase.to.box.read('domainShop')}/api/graphql";

  String graphqlQuery = '''
  query Facets {
    collection(handle: "$collectHandle") {
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

    if (response.statusCode == 200) {
      // Handle the successful response here
      var responseData = response.data;
      // Process the responseData as needed
      log("===> Here is the response $responseData <====");




      // Parse the filters from the response
      final List<dynamic> filterData = responseData['data']['collection']['products']['filters'];

      log("length of filters under products is => ${filterData.length}");

// Convert the filter data into Filter objects
      final List<Filter> filters = filterData.map((filter) {
        List<dynamic> valuesData = filter['values'];
        List<FilterValue> values = valuesData.map((value) {
          return FilterValue(
            id: value['id'],
            label: value['label'],
            count: value['count'],
            input: value['input'],
          );
        }).toList();

        return Filter(
          id: filter['id'],
          label: filter['label'],
          type: filter['type'],
          values: values,
        );
      }).toList();

      log("Total filters we got ${filters.length}");


      return filters;

    }
    else {
      // Handle other status codes or errors
      log("===> Error in Status Code ${response.statusCode} <====");
      return [];
    }
  } catch (error) {
    // Handle any Dio errors or exceptions
    log("===> Exception Caught $error <====");
    rethrow;

  }
}