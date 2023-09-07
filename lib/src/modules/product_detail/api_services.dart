import 'dart:convert';

import 'package:dio/dio.dart' as dio_instance;
import 'package:tapify_admin/src/global_controllers/database_controller.dart';

import '../../utils/tapday_api_srvices/api_services.dart';
// import 'package:dio/dio.dart';

Future<Map<String, dynamic>> createCheckOut({String variantId = "gid://shopify/ProductVariant/45352467497272", int quantity = 2}) async {
  const String mutation = r'''
    mutation checkoutCreate($input: CheckoutCreateInput!) {
      checkoutCreate(input: $input) {
        checkout {
          id
          webUrl
        }
        checkoutUserErrors {
          code
          field
          message
        }
      }
    }
  ''';

  dio_instance.Dio dio = dio_instance.Dio();


  // rest of the function remains the same
  final response = await dio.post(
      'https://${LocalDatabase.to.box.read('domainShop')}/api/2023-01/graphql.json',
      options: dio_instance.Options(headers: {'Content-Type': 'application/json', 'X-Shopify-Storefront-Access-Token': '${TapDay.storeFrontAccessToken}'}),
      data: jsonEncode({
        'query': mutation,
        'variables': {
          'input': {
            'lineItems': [
              {
                'variantId': variantId,
                'quantity': quantity,
              },
            ],
          },
        },
      }),
    );

  final body = response.data;

  print("create checkout response is $body");


  // Handle potential errors
  if (body['errors'] != null) {
    throw Exception(body['errors']);
  }

  if (body['data']['checkoutCreate']['checkoutUserErrors'].isNotEmpty) {
    throw Exception(body['data']['checkoutCreate']['checkoutUserErrors']);
  }

  return body['data']['checkoutCreate']['checkout'];








  // final response = await dio.post (
  //   Uri.parse('$_shopifyStore/api/2023-01/graphql.json'),
  //   headers: {
  //     'X-Shopify-Storefront-Access-Token': _storefrontAccessToken,
  //     'Content-Type': 'application/json',
  //   },
  //   body: json.encode({
  //     'query': query,
  //     'variables': {
  //       'checkoutId': checkoutId,
  //     },
  //   }),
  // );
  //
  // final body = json.decode(response.body);
  //
  // // Handle potential errors
  // if (body['errors'] != null) {
  //   throw Exception(body['errors']);
  // }
  //
  // return body['data']['node'];
}

getProductDetails({String productId = "gid://shopify/Product/8367105507640"}) async {

  print("in the new function Hurraayyyy......");

  const query = '''
    query GetProductById(\$productId: ID!) {
      product(id: \$productId) {
          title
          handle
             variants(first: 1) {
              edges {
                node {
                  title
                  quantityAvailable
                  availableForSale
                  currentlyNotInStock
              }
            }
          }
      }
    }
  ''';


  dio_instance.Dio dio = dio_instance.Dio();

  final variables = {'productId': productId};

  final data = {'query': query, 'variables': variables};
  // rest of the function remains the same
  final response = await dio.post(
    'https://${LocalDatabase.to.box.read('domainShop')}/api/2023-01/graphql.json',
    options: dio_instance.Options(headers: {'Content-Type': 'application/json', 'X-Shopify-Storefront-Access-Token': '${TapDay.storeFrontAccessToken}'}),
    data: data,
  );

  final body = response.data;

  print("create checkout response is $body");

}