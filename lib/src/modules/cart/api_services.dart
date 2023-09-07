import 'package:dio/dio.dart';
import 'package:tapify_admin/src/global_controllers/database_controller.dart';
import 'package:tapify_admin/src/utils/tapday_api_srvices/api_services.dart';

addOrderNoteToCheckout(String checkoutId, String note) async {


// Replace 'your_access_token' with your actual Shopify Storefront access token
  const String shopifyStorefrontAccessToken = '${TapDay.storeFrontAccessToken}';
  String shopifyStorefrontAPIEndpoint = 'https://${LocalDatabase.to.box.read('domainShop')}/api/graphql';

  final dio = Dio();

  const query = '''
    mutation addNoteToCheckout(\$checkoutId: ID!, \$note: String!) {
      checkoutAttributesUpdateV2(
        checkoutId: \$checkoutId
        input: { note: \$note }
      ) {
        checkout {
          id
        }
        userErrors {
          field
          message
        }
      }
    }
  ''';

  final variables = {
    'checkoutId': checkoutId,
    'note': note,
  };

  final options = Options(headers: {
    'X-Shopify-Storefront-Access-Token': shopifyStorefrontAccessToken,
    'Content-Type': 'application/json',
  });

  try {
    final response = await dio.post(
      shopifyStorefrontAPIEndpoint,
      data: {
        'query': query,
        'variables': variables,
      },
      options: options,
    );

    if (response.statusCode == 200) {
      print('Note added successfully!');
    } else {
      print('Failed to add note to checkout. Status code: ${response.statusCode}');
      print('Response: ${response.data}');
    }
  } catch (e) {
    print('Error occurred while adding note to checkout: $e');
  }
  // }


}