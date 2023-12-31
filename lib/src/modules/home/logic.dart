import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/custom_widgets/product_viewer_web.dart';
import 'package:tapify_admin/src/modules/home/models/product_info_model.dart';
import 'package:video_player/video_player.dart';

// import 'package:shopify_flutter/models/src/product/product.dart';
// import 'package:shopify_flutter/shopify/src/shopify_store.dart';

import '../../api_services/shopify_flutter/models/src/product/product.dart';
import '../../custom_widgets/DateDuration.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/database_controller.dart';
import '../../utils/global_instances.dart';
import '../category/view_category_products.dart';
import '../product_detail/view.dart';
import '../product_detail/view_product_detail.dart';
import 'components/circle_product_list.dart';
import 'components/custom_divider.dart';
import 'components/marquee_text.dart';
import 'components/search_bar.dart';
import 'models/model_home_ui_settings.dart';
import 'state.dart';
import 'package:timezone/timezone.dart' as tz;

class HomeLogic extends GetxController with GetSingleTickerProviderStateMixin {
  static HomeLogic get to => Get.find();
  final HomeState state = HomeState();
  Rx<int> currentImageIndex = 0.obs;
  final bool applyMargin = false;

  Timer? timer;
  Timer? timer1;
  Rx<Duration> duration1 = (Duration(seconds: 10)).obs;
  RxInt upDayscountdown = 0.obs;
  RxInt updateMonthcountdown = 0.obs;
  RxBool isTimerRunning = false.obs;
  RxBool countDown1 = true.obs;
  Rx<Duration> countdownDuration1 = (Duration()).obs;
  DateDuration? nextBirthday;
  DateDuration? duration;
  var weekDay;
  DateTime nextBirthdayDate = DateTime.now();
  var Months;
  var dateTime;
  var cdate;
  DateTime startSelectedDate = DateTime.now();
  // List selectedVideos = [];
  late VideoPlayerController controller;
  RxBool videoEnded = false.obs;
  RxBool isFirstTime = true.obs;
  RxBool isClicked = false.obs;
  //
  // List<VideoPlayerController> controllers = [];
  // RxBool videoEnded = false.obs;
  // RxBool isFirstTime = true.obs;
  // RxBool isClicked = false.obs;

  // RxDouble heightCheck = 0.0.obs;
  // RxDouble heightCheck1 = 0.0.obs;
  bool isImageLoaded = false;

  RxBool enabled = true.obs;
  RxBool enabledShow = false.obs;



  final ScrollController circleProductScroll = ScrollController();

  ///-------- Discount Widget Codes
  // RxString widgetShopifyCode = "".obs;
  // RxString widgetCustomerCode = "".obs;
  RxList codesDiscountWidget = RxList([]);

  void resetCarosal(){
    currentImageIndex.value = 0;
  }

 // void initializeValueOfVideo(settings){
 //    // print("value of state of loop: ${settings['loop']}");
 //
 //   String videoUrl = settings['video'] ?? "";
 //   print("video URL=====$videoUrl");
 //   controller = VideoPlayerController.networkUrl(Uri.parse(settings['video'] ?? ""), )
 //    // selectedVideos.add(videoUrl);
 //      ..addListener(() {
 //        // This condition checks if the video has reached its end
 //        if (controller.value.position == controller.value.duration && settings['loop'] == false) {
 //          if (!videoEnded.value) { // This check ensures setState is only called once at the video's end.
 //            videoEnded.value = true;
 //            controller.pause();
 //          }
 //        } else if (controller.value.isPlaying) {
 //          if (videoEnded.value) { // If video started playing again, update videoEnded
 //            videoEnded.value = false;
 //          }
 //        }else if (isFirstTime.value && controller.value.isPlaying) {
 //          isFirstTime.value = false;
 //        }
 //      })
 //      ..initialize().then((_) {
 //        update();
 //        if (controller.value.isInitialized) {
 //          // selectedVideos.add(videoUrl);
 //          // heightCheck.value = controller.value.size.aspectRatio;
 //          // heightCheck1.value = controller.value.size.height;
 //          // print("Video height: ${heightCheck.value}");
 //        }
 //        // This will refresh the UI once the video is initialized
 //        // if (settings['autoPlay'] == true) {
 //        //   controller.play();
 //        //   update();
 //        // }
 //        controller.setVolume(0);
 //        controller.play();
 //        update();
 //        controller.videoPlayerOptions!.webOptions!.controls;
 //        // Auto play the video if required
 //        update();
 //      });
 //    if (settings['loop'] == true) {
 //      controller.setLooping(true);
 //      update();
 //    } else {
 //      controller.setLooping(false);
 //      update();
 //    }
 //  }

  // initializedVideo(settings){
  //   VideoPlayerController controller = VideoPlayerController.networkUrl(Uri.parse(settings['video'] ?? ""), );
  //   // selectedVideos.add(videoUrl);
  //   controller..addListener(() {
  //     // This condition checks if the video has reached its end
  //     if (controller.value.position == controller.value.duration && settings['loop'] == false) {
  //       if (!videoEnded.value) { // This check ensures setState is only called once at the video's end.
  //         videoEnded.value = true;
  //         controller.pause();
  //       }
  //     } else if (controller.value.isPlaying) {
  //       if (videoEnded.value) { // If video started playing again, update videoEnded
  //         videoEnded.value = false;
  //       }
  //     }else if (isFirstTime.value && controller.value.isPlaying) {
  //       isFirstTime.value = false;
  //     }
  //   })
  //     ..initialize().then((_) {
  //       update();
  //       if (controller.value.isInitialized) {
  //         // selectedVideos.add(videoUrl);
  //         // heightCheck.value = controller.value.size.aspectRatio;
  //         // heightCheck1.value = controller.value.size.height;
  //         // print("Video height: ${heightCheck.value}");
  //       }
  //       // This will refresh the UI once the video is initialized
  //       // if (settings['autoPlay'] == true) {
  //       //   controller.play();
  //       //   update();
  //       // }
  //       controller.setVolume(0);
  //       controller.play();
  //       update();
  //       controller.videoPlayerOptions!.webOptions!.controls;
  //       // Auto play the video if required
  //       update();
  //     });
  //
  //   // controllers.add(controller);
  //   if (settings['loop'] == true) {
  //     controller.setLooping(true);
  //     update();
  //   } else {
  //     controller.setLooping(false);
  //     update();
  //   }
  // }


  addUpdateCodesList(dynamic settings) { //---- JSON settings of discount widget
    final customerCode = settings["customerCode"] ?? "";
    final shopifyCode = settings["shopifyCode"] ?? "";

    // Check if the pair already exists in the list
    bool pairExists = codesDiscountWidget.any((codePair) =>
    codePair["customer_code"] == customerCode &&
        codePair["shopify_code"] == shopifyCode
    );

    // If the pair doesn't exist, add it to the list
    if (!pairExists) {
      codesDiscountWidget.add({
        "customer_code": customerCode,
        "shopify_code": shopifyCode,
      });
    }
  }

  //---- save the tapped discount card index
  tappedOnDiscountWidget(dynamic settings) {
    final customerCode = settings["customerCode"] ?? "";
    final shopifyCode = settings["shopifyCode"] ?? "";

    // Find the index in the list where the pair matches
    final index = codesDiscountWidget.indexWhere((codePair) =>
    codePair["customer_code"] == customerCode &&
        codePair["shopify_code"] == shopifyCode);

    if (index != -1) {
      // Save the tapped discount card index to LocalDatabase
      LocalDatabase.to.box.write("tappedDiscountIndex", index);
      LocalDatabase.to.box.write("tappedOnDiscount", true);
      showToastMessage(message: "Discount added, start shopping now");
    } else {
      showToastMessage(message: "Discount not found"); // Handle case where the pair is not in the list
    }
  }

  void togglePlayPause() {
    if (controller.value.isPlaying) {
      controller.pause();
      isClicked.value = false;  // Considering it's an RxBool from GetX or similar
    } else {
      controller.play();
      isClicked.value = true;
    }
  }

  calculationFun(dynamic settings) {

    DateTime startDate = DateTime.parse(settings['startDate']);
    DateTime endDate = DateTime.parse(settings['endDate']);

    final pacificTimeZone = tz.getLocation(settings['timezone']);

    var convertstartDate = tz.TZDateTime.from(startDate, pacificTimeZone);

    DateTime now = DateTime.now();

    if (convertstartDate.isBefore(now)) {
      convertstartDate = tz.TZDateTime.from(DateTime.now(), pacificTimeZone);
    }
    DateTime splitDate = DateTime(convertstartDate.year, convertstartDate.month, convertstartDate.day, convertstartDate.hour, convertstartDate.minute, convertstartDate.second);


    Duration difference1 = endDate.difference(splitDate);


    int days = difference1.inDays;
    int hours = difference1.inHours.remainder(24);
    int minutes = difference1.inMinutes.remainder(60);
    int seconds = difference1.inSeconds.remainder(60);

    countdownDuration1.value = Duration(days: days, hours: hours, minutes: minutes, seconds: seconds);

    reset1();
    startTimer1();
  }

  void startTimer1() {
    if (!isTimerRunning.value) {
      // LocalDatabase.to.box.read('seconds');
      // if (LocalDatabase.to.box.read('seconds') != null) {
      //   duration1 = Duration(seconds: int.parse(LocalDatabase.to.box.read('seconds').toString()));
      // }
      timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime1());
      isTimerRunning.value = true;
    }
  }

  void reset1() {
    if (timer != null) {
      timer!.cancel();
    }

    isTimerRunning.value = false;
    if (countDown1.isTrue) {
      duration1.value = countdownDuration1.value;
    } else {
      duration1.value = const Duration(seconds: 0);
    }
  }

  void addTime1() {
    const addSeconds = 1;

    final seconds = duration1.value.inSeconds - addSeconds;
    duration1.value = Duration(seconds: seconds);
    if (seconds <= 0) {
      timer?.cancel();
    } else {
      duration1.value = Duration(seconds: seconds);
    }
    // storeSeconds(duration1);
  }


  resetTheScrolls(){
    circleProductScroll.jumpTo(0);
  }




  ///---------- Product On Tap Navigator
  productDetailNavigator(
      {required BuildContext context,
        required ProductInfo info,
        required String dataType}) {
    if (dataType == "product") {
      //------ If dataType is Product then Product Detail
      print("value of ID: ${info.id}");
      Get.to(() => NewProductDetails(
        productId: info.id.toString(),
      ), opaque: false, transition: Transition.native);

    } else if (dataType == "collection") {
      //---------- if dataType is Collection then Products by Collection
      Get.to(() => CategoryProducts(
          collectionID: info.id,
          categoryName: info.title), opaque: false, transition: Transition.native);




    } else {
      //-------- if Web URL then open web
      if(info.webUrl != "") {
        Get.to(() => WebViewProduct(
          productUrl: info.webUrl,
        ), opaque: false, transition: Transition.native);
      }



    }
  }

  ///------- product carousel
  RxInt currentCarouselIndex = 1.obs;



  ///--------- Products by Tags Logic
  RxInt selectedCollectionIndex = 0.obs;
  RxBool isLoading = true.obs;
  dynamic catProdSettings;
  final Rx<List<Product>> productsByTagsList = Rx<List<Product>>([]);

  getProducts({bool isChangingCategory = true, bool isFromHome = false}) async {
    log("====> Build Method of - Get Products Called <====");

    if(isFromHome && productsByTagsList.value.isNotEmpty){
      //--- do nothing
      log("==> callign method doign nothing <====");
    } else {
      // if(isChangingCategory || productsByTagsList.value.isEmpty) {
      isLoading.value = true;
      productsByTagsList.value = [];
      // }

      // isLoading.value = productsList.value.isNotEmpty ? false : true;
      // if(productsList.value.isNotEmpty) {
      //
      // }
      // productsList.value = [];
      String collectionId =
          "gid://shopify/Collection/${catProdSettings["metadata"]["data"][selectedCollectionIndex.value]['id']}";
      int limit = catProdSettings["viewType"] == "small"
          ? 8
          : (catProdSettings["viewType"] == "medium" ? 6 : 4);
      try {
        final products = await shopifyStore
            .getXProductsAfterCursorWithinCollection(collectionId, limit);
        for (var element in products ?? []) {
          productsByTagsList.value.add(element);
        }
        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        debugPrint(" Error in fetching collection products $e");
      }
    }



  }

  void initializeAndPlayVideo(settings) {

  }

// RxBool isLoading = true.obs;
// RxBool innerLoader = false.obs;
// // Rx<List<Product>> homeProductsList = [];
// final Rx<List<Product>> homeProductsList = Rx<List<Product>>([]);
//
//
// getHomePageProductsInfo() async {
//
//
//   log("======= in the function again ========");
//
//
//
//   ///------ New Enhanced Caching Implementation
//   // Future getCachedData() async {
//   // // Future<SomeData?> getCachedData() async {
//   //
//   //   log("before time is ${DateTime.now()}");
//   //   final query = Query(key: "My key 2", queryFn: () async {
//   //     return await shopifyStore.getProductsByIds(list);
//   //   });
//   //   final queryState = await query.result;
//   //
//   //   log("==== cached retrieved data is ==> ${queryState.data} ");
//   //   log("after time is ${DateTime.now()}");
//   //   homeProductsList.value = queryState.data ?? [];
//   //
//   //   // return queryState.data;
//   // }
//   // getCachedData();
//
//   ///------- Simple Old Implementation
//   dynamic list = extractIDs();
//
//   if (LocalDatabase.to.box.read("homeProductsData") != null) {
//     dynamic retrievedData = LocalDatabase.to.box.read("homeProductsData");
//     log("===>  Locally Saved Data is $retrievedData  <====");
//     if (retrievedData is List<dynamic>) {
//       List<Product> convertedData = retrievedData
//           .map((data) => Product.fromJson(data as Map<String, dynamic>))
//           .toList();
//       homeProductsList.value = convertedData;
//       isLoading.value = false;
//     } else {
//       debugPrint('Invalid data type: $retrievedData');
//     }
//   }
//
//
//   // if(LocalDatabase.to.box.read("homeProductsData") != null) {
//   //   List<dynamic> retrievedData = LocalDatabase.to.box.read("homeProductsData");
//   //   List<Product> convertedData = retrievedData.map((data) => Product.fromJson(data)).toList();
//   //   homeProductsList.value = convertedData;
//   //   isLoading.value = false;
//   // }
//
//   innerLoader.value = true;
//
//   try {
//     // ShopifyStore shopifyStore = ShopifyStore.instance;
//
//     final response = await shopifyStore.getProductsByIds(list);
//     homeProductsList.value = response ?? [];
//     innerLoader.value = false;
//     isLoading.value = false;
//
//     LocalDatabase.to.box.write("homeProductsData", response);
//
//     log("==== SUCCESS retrieved products ===> ${homeProductsList.value}  ====");
//   } catch (e) {
//     isLoading.value = false;
//     innerLoader.value = false;
//     log("==== ERROR in fetching home products ==> $e ====");
//   }
// }
//
// Product getProductById(String id) {
//   List<Product> matchingProducts = homeProductsList.value.where((product) => product.id == id).toList();
//     return matchingProducts.first;
// }
//
//
//
// List<String> extractIDs() {
//   Set<String> ids = {};
//
//   for (var widget in dummyHomeData) {
//     if (widget.listOfWidgetsSettings['settings'] != null) {
//       var metadata = widget.listOfWidgetsSettings['settings']['metadata'];
//       if (metadata != null && metadata.containsKey('data')) {
//         dynamic data = List<Map<String, dynamic>>.from(
//           metadata['data'],
//         );
//         for (var item in data) {
//           if (item.containsKey('id')) {
//             String id = item['id'].toString();
//             String concatenatedString = "gid://shopify/Product/$id";
//             ids.add(concatenatedString);
//           }
//         }
//       }
//     }
//   }
//   List<String> concatenatedIDs = ids.toList();
//   // print("=== Concatenated IDs are ${concatenatedIDs.join(',')} ===");
//   // print("=== list of IDs is $concatenatedIDs ===");
//   return concatenatedIDs;
// }
}