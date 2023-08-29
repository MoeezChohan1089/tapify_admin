import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../custom_widgets/product_viewer_web.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class CountDownTimer extends StatefulWidget {
  final dynamic settings;

  const CountDownTimer({Key? key, required this.settings}) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  final logic = Get.put(HomeLogic());

  final appConfig = AppConfig.to;

  // calculationFun() {
  //
  //   DateTime startDate = DateTime.parse(widget.settings['startDate']);
  //   DateTime endDate = DateTime.parse(widget.settings['endDate']);
  //
  //   final pacificTimeZone = tz.getLocation(widget.settings['timezone']);
  //
  //   var convertstartDate = tz.TZDateTime.from(startDate, pacificTimeZone);
  //
  //  DateTime now = DateTime.now();
  //
  //   if (convertstartDate.isBefore(now)) {
  //     convertstartDate = tz.TZDateTime.from(DateTime.now(), pacificTimeZone);
  //   }
  //   DateTime splitDate = DateTime(convertstartDate.year, convertstartDate.month, convertstartDate.day, convertstartDate.hour, convertstartDate.minute, convertstartDate.second);
  //
  //
  //   Duration difference1 = endDate.difference(splitDate);
  //
  //
  //   int days = difference1.inDays;
  //   int hours = difference1.inHours.remainder(24);
  //   int minutes = difference1.inMinutes.remainder(60);
  //   int seconds = difference1.inSeconds.remainder(60);
  //
  //   logic.countdownDuration1 = Duration(days: days, hours: hours, minutes: minutes, seconds: seconds);
  //
  //   reset1();
  //   startTimer1();
  // }
  //
  // void startTimer1() {
  //   if (!logic.isTimerRunning.value) {
  //     // LocalDatabase.to.box.read('seconds');
  //     // if (LocalDatabase.to.box.read('seconds') != null) {
  //     //   duration1 = Duration(seconds: int.parse(LocalDatabase.to.box.read('seconds').toString()));
  //     // }
  //     logic.timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime1());
  //     logic.isTimerRunning.value = true;
  //   }
  // }
  //
  // void reset1() {
  //   if (logic.timer != null) {
  //     logic.timer!.cancel();
  //   }
  //
  //   logic.isTimerRunning.value = false;
  //   if (logic.countDown1.isTrue) {
  //     logic.duration1 = logic.countdownDuration1;
  //   } else {
  //     logic.duration1 = const Duration(seconds: 0);
  //   }
  // }
  //
  // void addTime1() {
  //   const addSeconds = 1;
  //
  //   final seconds = logic.duration1.inSeconds - addSeconds;
  //   logic.duration1 = Duration(seconds: seconds);
  //   if (!mounted) {
  //     return;
  //   }
  //
  //   setState(() {
  //     if (seconds <= 0) {
  //       logic.timer!.cancel();
  //     } else {
  //       logic.duration1 = Duration(seconds: seconds);
  //     }
  //   });
  //   // storeSeconds(duration1);
  // }

  // storeSeconds(Duration duration){
  //   LocalDatabase.to.box.write('seconds', duration.inSeconds.toString());
  // }

  @override
  void initState() {
    super.initState();
    if (widget.settings['startDate'] != null &&
        widget.settings['startDate'] != 0) {
      HomeLogic.to.startSelectedDate =
          DateTime.parse(widget.settings['startDate'].toString());
    } else {
      // Handle the case when startDate is null or 0
      // Provide a default value or alternative behavior
      HomeLogic.to.startSelectedDate = DateTime
          .now(); // For example, use the current date as a default value
    }

    (widget.settings['startDate'] != 0 && widget.settings['endDate'] != 0 &&
        HomeLogic.to.startSelectedDate.isBefore(DateTime.now())) ? HomeLogic.to
        .calculationFun(widget.settings) : 0;
  }

  Widget timeCounter() {
    return Obx(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.settings['startDate'] != null &&
            widget.settings['startDate'] != 0) {
          HomeLogic.to.startSelectedDate =
              DateTime.parse(widget.settings['startDate'].toString());
        } else {
          // Handle the case when startDate is null or 0
          // Provide a default value or alternative behavior
          HomeLogic.to.startSelectedDate = DateTime
              .now(); // For example, use the current date as a default value
        }

        (widget.settings['startDate'] != 0 && widget.settings['endDate'] != 0 &&
            HomeLogic.to.startSelectedDate.isBefore(DateTime.now())) ? HomeLogic
            .to.calculationFun(widget.settings) : 0;
      });
      Color color = Color(
          int.parse(widget.settings["timerColor"].substring(1), radix: 16) +
              0xFF000000);

      // print(color); // Output: Color(0xFF000000)
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String days = '';
      String hours = '';
      String minutes = '';
      String seconds = '';

      if (logic.duration1.value.inDays > 0) {
        days = twoDigits(logic.duration1.value.inDays);
      } else {
        days = "00";
      }

      if (logic.duration1.value.inHours > 0) {
        hours = twoDigits(logic.duration1.value.inHours.remainder(24));
      } else {
        hours = "00";
      }

      if (logic.duration1.value.inMinutes > 0) {
        minutes = twoDigits(logic.duration1.value.inMinutes.remainder(60));
      } else {
        minutes = "00";
      }

      if (logic.duration1.value.inSeconds > 0) {
        seconds = twoDigits(logic.duration1.value.inSeconds.remainder(60));
      } else {
        seconds = "00";
      }

      if (logic.nextBirthday != null && logic.duration1.value.inHours < 24) {
        logic.upDayscountdown.value = logic.nextBirthday!.days - 1;
      }
      if (logic.nextBirthday != null && logic.nextBirthday!.days <= 0) {
        logic.upDayscountdown.value = 0;
      }
      if (logic.nextBirthday != null && logic.duration1.value.inDays < 1) {
        logic.updateMonthcountdown.value = logic.nextBirthday!.months;
      }
      if (logic.nextBirthday != null && logic.duration1.value.inDays < 0) {
        logic.updateMonthcountdown.value = 0;
      }

      double textHeight = 0.8;

      bool allZero =
          (days == "00") && (hours == "00") && (minutes == "00") &&
              (seconds == "00");

      // (duration1.inDays > 0 && duration1.inHours > 0 && duration1.inMinutes > 0 && duration1.inSeconds > 0) ?
      return (allZero) ? SizedBox() : GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (widget.settings['disableInteraction'] ==
              false && widget.settings["web_url"] != null) {
            ///------ Open the Web
            Get.to(() =>
                WebViewProduct(
                  productUrl: widget.settings["web_url"],
                ));
          }

          if (widget.settings["metadata"]["data"].isNotEmpty &&
              widget.settings["metadata"]["data"] != null) {
            ProductInfo? productInfo = appConfig.getProductById(
              id: widget.settings["metadata"]["data"][0]["id"],
              dataType: widget.settings["metadata"]['dataType'],
            );
            if (widget.settings['disableInteraction'] ==
                false && widget.settings['metadata']['data'].isNotEmpty) {
              HomeLogic.to.productDetailNavigator(
                  context: context,
                  info: productInfo!,
                  dataType: widget.settings["metadata"]['dataType']
              );
            }
          }
        },
        child: Padding(
          padding: widget.settings['margin'] == true
              ? EdgeInsets.all(18.0)
              : EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (widget.settings['isTitleHidden'] == false) ? Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 6, horizontal: pageMarginHorizontal / 1.5),
                child: Column(
                  children: [
                    (pageMarginVertical / 1.3).heightBox,
                    Container(
                      width: double.maxFinite,
                      child:
                      Text(
                        "${widget.settings['title']}", textAlign: widget
                          .settings['titleAlignment'] == 'left' ? TextAlign
                          .start : widget.settings['titleAlignment'] == "center"
                          ? TextAlign.center
                          : TextAlign.end, style: widget
                          .settings['titleSize'] == "small"
                          ? context.text.titleSmall!.copyWith(
                          color: AppColors.appTextColor)
                          : widget.settings['titleSize'] == "medium" ? context
                          .text.titleMedium!.copyWith(
                          color: AppColors.appTextColor) : context.text
                          .titleLarge!.copyWith(color: AppColors.appTextColor),
                      ),
                    ),
                    widget.settings['image'] != null ? (pageMarginVertical /
                        1.3).heightBox : (pageMarginVertical / 1.3).heightBox,
                  ],
                ),
              ) : const SizedBox(),

              (widget.settings["image"] != null &&
                  widget.settings["metadata"]["data"].isEmpty)
                  ? singleImageVariant() ?? const SizedBox.shrink()
                  : customImageVariant() ?? const SizedBox.shrink(),
              // widget.settings['image'] != null? Padding(
              //   padding: const EdgeInsets.only(top: 10, bottom: 4),
              //   child: Stack(
              //     children: [
              //       Shimmer.fromColors(
              //         baseColor: Colors.grey[300]!,
              //         highlightColor: Colors.grey[100]!,
              //         child: Container(
              //           color: Colors.grey[300],
              //           height: widget.settings['displayType'] == "normal"? 300: widget.settings['displayType'] == "vertical"? 600: widget.settings['displayType'] == "auto"? null:230,
              //           width: double.infinity,
              //         ),
              //       ),
              //       FadeInImage.memoryNetwork(
              //         image: widget.settings['image'].toString().startsWith('blob')? "https://st2.depositphotos.com/1002277/12135/i/950/depositphotos_121357882-stock-photo-word-demo-on-wood-planks.jpg":"${widget.settings['image']}",
              //         fit: BoxFit.cover,
              //         height: widget.settings['displayType'] == "normal"? 300: widget.settings['displayType'] == "vertical"? 600: widget.settings['displayType'] == "auto"? null:230,
              //         width: double.maxFinite,
              //         placeholder: kTransparentImage,
              //         // progressIndicatorBuilder:
              //         //     (context, url, downloadProgress) =>
              //         //     productShimmer(),
              //         // errorWidget: (context, url, error) =>
              //         // const Icon(Icons.error),
              //       ),
              //     ],
              //   ),
              // ):SizedBox(),
              Padding(
                padding: widget.settings['margin'] == true ? EdgeInsets.only(
                    left: 14.w, right: 14.w, bottom: 14.h) : EdgeInsets.only(
                    left: 6, top: 16, right: 6),
                child: Column(
                  children: [
                    // For the numerical values
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        10.widthBox,
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                days,
                                textAlign: TextAlign.center,
                                style: context.text.bodyLarge?.copyWith(
                                    fontSize: 35.sp,
                                    color: color,
                                    height: textHeight
                                ),
                              ),
                              4.heightBox,
                              Text(
                                "days",
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium!.copyWith(
                                    color: color, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child:
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  ":",
                                  style: context.text.bodyLarge?.copyWith(
                                      fontSize: 35.sp,
                                      color: color,
                                      height: textHeight
                                  ),
                                ),
                              ),
                              4.heightBox,
                              Text('')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                hours,
                                textAlign: TextAlign.center,
                                style: context.text.bodyLarge?.copyWith(
                                    fontSize: 35.sp,
                                    color: color,
                                    height: textHeight
                                ),
                              ),
                              4.heightBox,
                              Text(
                                "hours",
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium!.copyWith(
                                    color: color, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child:
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  ":",
                                  style: context.text.bodyLarge?.copyWith(
                                      fontSize: 35.sp,
                                      color: color,
                                      height: textHeight
                                  ),
                                ),
                              ),
                              4.heightBox,
                              Text('')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                minutes,
                                textAlign: TextAlign.center,
                                style: context.text.bodyLarge?.copyWith(
                                    fontSize: 35.sp,
                                    color: color,
                                    height: textHeight
                                ),
                              ),
                              4.heightBox,
                              Text(
                                "minutes",
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium!.copyWith(
                                    color: color, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child:
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  ":",
                                  style: context.text.bodyLarge?.copyWith(
                                      fontSize: 35.sp,
                                      color: color,
                                      height: textHeight
                                  ),
                                ),
                              ),
                              4.heightBox,
                              Text('')
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                seconds,
                                textAlign: TextAlign.center,
                                style: context.text.bodyLarge?.copyWith(
                                    fontSize: 35.sp,
                                    color: color,
                                    height: textHeight
                                ),
                              ),
                              4.heightBox,
                              Text(
                                "seconds",
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium!.copyWith(
                                    color: color, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                        15.widthBox
                      ],
                    ),
                  ],
                ),
              ),
              8.heightBox,
              (widget.settings['isSubTitleHidden'] == false) ? Padding(
                padding: EdgeInsets.only(
                    left: pageMarginHorizontal, right: pageMarginHorizontal,
                    bottom: pageMarginVertical / 2, top: pageMarginVertical + 10
                ),
                child: Container(
                  width: double.maxFinite,
                  child: Text(
                    "${widget.settings['subtitle']}",
                    textAlign: TextAlign.center,
                    style: context.text.bodyLarge!.copyWith(color: color),
                  ),
                ),
              ) : const SizedBox(),
            ],
          ),
        ),
      );
    });
  }

  singleImageVariant() {
    return GestureDetector(
      onTap: () {
        if (widget.settings['disableInteraction'] ==
            false && widget.settings["web_url"] != null) {
          ///------ Open the Web
          Get.to(() =>
              WebViewProduct(
                productUrl: widget.settings["web_url"],
              ));
        }
      },
      child: Column(
        children: [
          Padding(
            padding: widget.settings['margin'] == true ?
            EdgeInsets.only(
                left: pageMarginHorizontal / 1.5,
                right: pageMarginHorizontal / 1.5,
                bottom: widget.settings['contentMargin'] == true
                    ? pageMarginVertical
                    : 0,
                top: widget.settings['contentMargin'] == true
                    ? pageMarginVertical
                    : 0
            )
                : widget.settings['contentMargin'] == true ? EdgeInsets.only(
                top: pageMarginVertical,
                bottom: pageMarginVertical - 6
            ) : EdgeInsets.zero,
            child: Container(

              width: double.maxFinite,
              height: widget.settings['displayType'] == "normal" ? 300 : widget
                  .settings['displayType'] == "vertical" ? 600 : widget
                  .settings['displayType'] == "auto" ? null : 230,
              decoration: BoxDecoration(
                borderRadius: widget.settings['margin'] == true ? BorderRadius
                    .circular(5.r) : BorderRadius.circular(0),
              ),
              child: ClipRRect(
                borderRadius: widget.settings['margin'] == true ? BorderRadius
                    .circular(3.r) : BorderRadius.circular(0),
                child: widget.settings['image'] != null ? FadeInImage
                    .memoryNetwork(
                  image: widget.settings['image'],
                  // color: settings['titlePosition'] == "center" ?  Colors.black.withOpacity(0.4):null,
                  // colorBlendMode: settings['titlePosition'] == "center" ? BlendMode.darken:null,
                  fit: BoxFit.cover,
                  height: widget.settings['displayType'] == "normal"
                      ? 300
                      : widget.settings['displayType'] == "vertical"
                      ? 600
                      : widget.settings['displayType'] == "auto" ? null : 230,
                  width: double.infinity,
                  imageErrorBuilder: (context, url,
                      error) =>
                      Container(
                        color: Colors.grey.shade200,
                        // color: Colors.grey.shade200,
                        child: Center(
                          child: SvgPicture.asset(Assets.icons.noImageIcon,
                            height: 25.h,
                          ),
                        ),
                      ),

                  // progressIndicatorBuilder:
                  //     (context, url, downloadProgress) =>
                  //     productShimmer(),
                  // errorWidget: (context, url, error) =>
                  // const Icon(Icons.error),
                  placeholder: kTransparentImage,
                ) : Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: SvgPicture.asset(Assets.icons.noImageIcon,
                      height: 25.h,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  customImageVariant() {
    if (widget.settings["metadata"]["data"].isNotEmpty) {
      ProductInfo? productInfo = appConfig.getProductById(
        id: widget.settings["metadata"]["data"][0]["id"],
        dataType: widget.settings["metadata"]['dataType'],
      );
      return GestureDetector(
        onTap: () {
          if (widget.settings['disableInteraction'] ==
              false && widget.settings['metadata']['data'].isNotEmpty) {
            HomeLogic.to.productDetailNavigator(
                context: context,
                info: productInfo!,
                dataType: widget.settings["metadata"]['dataType']
            );
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: widget.settings['margin'] == true ?
                  EdgeInsets.only(
                      left: pageMarginHorizontal / 1.5,
                      right: pageMarginHorizontal / 1.5,
                      bottom: widget.settings['contentMargin'] == true
                          ? pageMarginVertical
                          : 0,
                      top: widget.settings['contentMargin'] == true
                          ? pageMarginVertical
                          : pageMarginHorizontal / 1.5
                  )
                      : widget.settings['contentMargin'] == true ? EdgeInsets
                      .only(
                      top: pageMarginVertical + 15,
                      bottom: pageMarginVertical - 5
                  ) : EdgeInsets.zero,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: widget.settings['displayType'] == "normal"
                            ? 330
                            : widget.settings['displayType'] == "vertical"
                            ? 600
                            : widget.settings['displayType'] == "auto"
                            ? null
                            : 230,
                        decoration: BoxDecoration(
                          borderRadius: widget.settings['margin'] == true
                              ? BorderRadius.circular(5.r)
                              : BorderRadius.circular(0),
                        ),
                        child: ClipRRect(
                          borderRadius: widget.settings['margin'] == true
                              ? BorderRadius.circular(3.r)
                              : BorderRadius.circular(0),
                          child: Stack(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300],
                                  height: widget.settings['displayType'] ==
                                      "normal" ? 330 : widget
                                      .settings['displayType'] == "vertical"
                                      ? 600
                                      : widget.settings['displayType'] ==
                                      "auto"
                                      ? null
                                      : 230,
                                  width: double.infinity,
                                ),
                              ),
                              widget.settings['image'] != null || (productInfo?.image.isNotEmpty ?? false)? FadeInImage.memoryNetwork(
                                image:
                                widget.settings['image'] ?? "${productInfo?.image.split(
                                    "?v=")[0]}?width=300",
                                fit: BoxFit.cover,
                                height: widget.settings['displayType'] ==
                                    "normal" ? 330 : widget
                                    .settings['displayType'] == "vertical"
                                    ? 600
                                    : widget.settings['displayType'] == "auto"
                                    ? null
                                    : 230,
                                width: double.infinity,
                                imageErrorBuilder: (context, url,
                                    error) =>
                                    Container(
                                      color: Colors.grey.shade200,
                                      // color: Colors.grey.shade200,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          Assets.icons.noImageIcon,
                                          height: 25.h,
                                        ),
                                      ),
                                    ),
                                // progressIndicatorBuilder:
                                //     (context, url, downloadProgress) =>
                                //     productShimmer(),
                                // errorWidget: (context, url, error) =>
                                // const Icon(Icons.error),
                                placeholder: kTransparentImage,
                              ):SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          width: double.maxFinite,
                          height: widget.settings['displayType'] == "normal"
                              ? 300
                              : widget.settings['displayType'] == "vertical"
                              ? 400
                              : widget.settings['displayType'] == "auto"
                              ? null
                              : 230,
                          // height: 400,
                          decoration: BoxDecoration(
                            color: widget.settings['titlePosition'] ==
                                "center"
                                ? Colors.black.withOpacity(0.4)
                                : null,
                            borderRadius: widget.settings['margin'] == true
                                ? BorderRadius.circular(5.r)
                                : BorderRadius.circular(0),
                            // colorBlendMode: settings['titlePosition'] == "center" ? BlendMode.darken:null,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: widget.settings['titlePosition'] == "center"
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        (widget.settings["metadata"]['dataType'] ==
                            "collection" ||
                            widget.settings["metadata"]['dataType'] ==
                                "web-url")
                            ? const SizedBox.shrink() : Column(
                          children: [
                            12.heightBox,
                            HomeProductsPrice(
                              price: productInfo!.price,
                              priceColor: AppColors.customWhiteTextColor,
                            ),
                          ],
                        )
                        ,
                        HomeProductsTitle(
                          title: productInfo!.title,
                          textColor: AppColors.customWhiteTextColor,
                        ),

                        //------ Price
                        // productInfo.price != 0.0 ?  Text.rich(
                        //   TextSpan(
                        //     children: <InlineSpan>[
                        //       WidgetSpan(
                        //         child: Padding(
                        //           padding: const EdgeInsets.only(right: 10), // Add the desired space here
                        //           child: Text(
                        //             ' \$80',
                        //             style: context.text.bodyLarge?.copyWith(
                        //               color: AppColors.customGreyTextColor,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       WidgetSpan(
                        //         child: Text(
                        //           '\$100',
                        //           style: context.text.bodyLarge?.copyWith(
                        //             color: AppColors.customGreyTextColor,
                        //             decoration: TextDecoration.lineThrough,
                        //           ),
                        //           // style: TextStyle(
                        //           //   color: AppColors.customIconColor,
                        //           //   fontFamily: "Sofia Pro Regular",
                        //           //   decoration: TextDecoration.lineThrough,
                        //           // ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ) : const SizedBox.shrink(),
                      ],
                    )
                        : const SizedBox())
              ],
            ),


            (widget.settings["metadata"]['dataType'] == "collection" ||
                widget.settings["metadata"]['dataType'] == "web-url")
                ? (pageMarginVertical).heightBox
                : (pageMarginVertical / 2).heightBox,
            widget.settings['titlePosition'] == "bottom" ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (widget.settings["metadata"]['dataType'] == "collection" ||
                    widget.settings["metadata"]['dataType'] == "web-url")
                    ? const SizedBox.shrink()
                    : Column(
                  children: [
                    12.heightBox,
                    HomeProductsPrice(
                      price: productInfo!.price,
                    ),
                  ],
                ),
                HomeProductsTitle(
                  title: productInfo!.title,
                ),
              ],
            ) : const SizedBox(),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.settings['startDate'] != null &&
        widget.settings['startDate'] != 0) {
      HomeLogic.to.startSelectedDate =
          DateTime.parse(widget.settings['startDate'].toString());
    }

    return (widget.settings['startDate'] != 0 &&
        widget.settings['endDate'] != 0 &&
        HomeLogic.to.startSelectedDate.isBefore(DateTime.now()))
        ? timeCounter()
        : SizedBox();
  }
}
