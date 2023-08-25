import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/global_controllers/reviews/reviews_controller.dart';
import 'package:tapify_admin/src/utils/tapday_api_srvices/api_services.dart';

// import 'package:shopify_flutter/shopify_flutter.dart';

// import '../api_services/shopify_flutter/shopify_flutter.dart';
// import '../global_controllers/database_controller.dart';
// import '../utils/global_instances.dart';
import '../../api_services/shopify_flutter/shopify_flutter.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/database_controller.dart';
import '../../utils/global_instances.dart';
import 'state.dart';

class OrderLogic extends GetxController {
  static OrderLogic get to => Get.find();
  final OrderState state = OrderState();

  Rx<bool> loadingOrders = false.obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  Rx<double> ratingvalueBar = 0.0.obs;
  RxBool removeRateButton = false.obs;
  final orderKey = GlobalKey<FormState>();
  RxBool loadingAnimation = false.obs;

  @override
  void onInit() {
    super.onInit();
    LocalDatabase.to.box.read("customerAccessToken") != null
        ? getOrdersService()
        : debugPrint("Not Signed In");
  }

  bool areFieldsFilled() {
    return titleController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        reviewController.text.isNotEmpty;
  }

  final Rx<List<Order>> userOrders = Rx<List<Order>>([]);
  List<Order> get userOrdersList =>
      userOrders.value.isNotEmpty ? userOrders.value : [];

  getOrdersService() async {
    try {
      loadingOrders.value = true;
      final userInfoResponse = await shopifyCheckout
          .getAllOrders(LocalDatabase.to.box.read("customerAccessToken"));
      userOrders.value = userInfoResponse ?? [];
      loadingOrders.value = false;
    } catch (e) {
      loadingOrders.value = false;
      debugPrint("====> ERROR : in getting user orders $e  <=====");
    }
  }

  Map? appointData;

  createReview({
    required BuildContext context,
    String? id,
    String? name,
    String? emailId,
    String? title,
    String? comment,
    double? rating,
  }) async {
    loadingAnimation.value = true;
    Dio dio = Dio();

    print("value of sending id is $id");

    Map data = {
      "platform": "shopify",
      "id": int.parse(id.toString()),
      "name": name,
      "email": emailId,
      "title": title,
      "body": comment,
      "rating": rating
    };

    final response = await dio.post('${TapDay.judgeMeReviewURL}',
        queryParameters: {
          // 'per_page': 1000,
          'api_token': '${TapDay.apiTokenJudgeMe}',
          'shop_domain': '${LocalDatabase.to.box.read('domainShop')}'
        },
        data: data);
    // print("value of actin: ${response.statusCode}");
    if (response.statusCode == 201) {
      ReviewsListController.to.getProductReviews();
      appointData = response.data;
      // map.decoder.toString();
      print("response Data: ${appointData}");
      //   print("after response: ${}");
      loadingAnimation.value = false;
      Navigator.pop(context);
      fullNameController.clear();
      titleController.clear();
      reviewController.clear();
      showToastMessage(message: "Review has been submitted successfully.");
      // // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // //   content: Text(
      // //     "${appointData!['message']}",
      // //     textAlign: TextAlign.center,
      // //     style: TextStyle(
      // //       color: Colors.white,
      // //     ),
      // //   ),
      //   behavior: SnackBarBehavior.floating,
      //   elevation: 0,
      //   backgroundColor: Color(0xff666666),
      //   duration: Duration(milliseconds: 1000),
      // ));
    } else {
      print("Response error");
      loadingAnimation.value = false;
      showToastMessage(message: "Something went wrong.");
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(
      //     "Something went wrong.",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   behavior: SnackBarBehavior.floating,
      //   elevation: 0,
      //   backgroundColor: Color(0xff666666),
      //   duration: Duration(milliseconds: 1000),
      // ));
    }
  }
}
