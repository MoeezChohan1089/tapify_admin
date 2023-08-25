import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_instance;

import '../../utils/extensions.dart';
import '../../utils/tapday_api_srvices/api_services.dart';
import '../database_controller.dart';
import 'model_reviews.dart';

class ReviewsListController extends GetxController {
  static ReviewsListController get to => Get.find();
  final dio = dio_instance.Dio();
  // var requestedProductReviews = [];
  // var filteredReviews = [];
  // dynamic totalRating = 0;
  // int count = 0;
  ModelReviewsList modelReviewsList = ModelReviewsList();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    ///----- implement API logic here
    getProductReviews();
  }

  getProductReviews() async {
    try {
      dio_instance.Response response;
      response = await dio.get(
        '${TapDay.judgeMeReviewURL}',
        queryParameters: {
          'per_page': 1000,
          'api_token': '${TapDay.apiTokenJudgeMe}',
          'shop_domain': '${LocalDatabase.to.box.read('domainShop')}'
        },
      );
      // log("Response of Reviews List API is ==> ${response.data}");
      modelReviewsList = ModelReviewsList.fromJson(response.data);
      update();
    } catch (e) {
      log("== Error in Reviews List API $e ==");
    }
  }

  getProductReviewsList(var productId) {
    var requestedProductReviews = [];
    var filteredReviews = [];
    dynamic totalRating = 0;
    int count = 0;
    for (Reviews reviewJson in modelReviewsList.reviews ?? []) {
      if (reviewJson.productExternalId == productId) {
        filteredReviews.add(reviewJson.toJson());
        totalRating += reviewJson.rating;
        count++;
      }
    }
    requestedProductReviews.add({
      'review_count': count,
      'avg_rating': count > 0 ? totalRating / count : 0,
      'reviews_list': filteredReviews
    });

    if (requestedProductReviews[0]["reviews_list"].isNotEmpty) {
      log("=== length of filtered Reviews ${filteredReviews.length}  &  from the list is ${requestedProductReviews[0]["reviews_list"][0]["reviewer"]["name"]}  ===");
    }

    return requestedProductReviews;
  }


  ///---- check if current user has reviewed this item
  double checkUserReview(var productId, var orderNoOffical) {
    double reviewValue = 0.0;
    dynamic userinfoList = LocalDatabase.to.box.read('userInfo');

    if (userinfoList == null || userinfoList.isEmpty) {
      return reviewValue;
    }

    for (Reviews reviewJson in modelReviewsList.reviews ?? []) {
      if (reviewJson.productExternalId == null || reviewJson.reviewer?.email == null) {
        continue;
      }

      if(reviewJson.title!.contains("/order")){
        var splitvalue = reviewJson.title!.split('/order');
        print("split order no1: ${splitvalue[1].runtimeType}");
        print("split order no: ${orderNoOffical.runtimeType}");
        if (int.parse(splitvalue[1]) == orderNoOffical && reviewJson.productExternalId == int.parse(productId) && reviewJson.reviewer!.email == userinfoList[0]["email"]) {
          // filteredReviews.add(reviewJson.toJson());
          // totalRating += reviewJson.rating;
          reviewValue = convertToDouble(reviewJson.rating);
          return reviewValue;
        }
      }
    }
    return reviewValue;
  }

}