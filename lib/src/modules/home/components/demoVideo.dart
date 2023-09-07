import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:tapify_admin/src/utils/skeleton_loaders/shimmerLoader.dart';
import 'package:video_player/video_player.dart';

import '../../../custom_widgets/product_viewer_web.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../logic.dart';
import '../models/product_info_model.dart';

class SingleVideoView extends StatefulWidget {
  final dynamic settings;

  const SingleVideoView({super.key, required this.settings});

  @override
  SingleVideoViewState createState() => SingleVideoViewState();
}

class SingleVideoViewState extends State<SingleVideoView> {

  final logic = Get.put(HomeLogic());


  @override
  void initState() {
    super.initState();
    print("ffsfsfsd");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // logic.initializeValueOfVideo(widget.settings);
    });
  }


  // @override
  // void dispose() {
  //   logic.controller.dispose();
  //   super.dispose();
  // }

  Widget getPlayPauseButton() {
    // When loop is true and autoplay is true, we never show the button
    if (widget.settings['loop'] && widget.settings['autoPlay']) {
      print("== fucking error is here :: ${logic.videoEnded.value} ");
      return SizedBox.shrink();
    }

    // When loop is false
    if (widget.settings['autoPlay'] && !widget.settings['loop'] &&
        logic.videoEnded.value) {
      return _ControlsOverlay(
        controller: logic.controller,
        videoEnded: logic.videoEnded.value,
        isClicked: logic.isClicked.value,
        isFirstTime: logic.isFirstTime.value,
        onPlayPauseClicked: () {
          logic.isClicked.value = true;
          logic.isFirstTime.value = false;
        },
      );
    }

    if (!widget.settings['autoPlay'] && !widget.settings['loop']) {
      return _ControlsOverlay(
        controller: logic.controller,
        videoEnded: logic.videoEnded.value,
        isClicked: logic.isClicked.value,
        isFirstTime: logic.isFirstTime.value,
        onPlayPauseClicked: () {
          logic.isClicked.value = !logic.isClicked.value;
          if (logic.isFirstTime.value) {
            logic.isFirstTime.value = false;
          }
        },
      );
    }

    // When loop is true but autoplay is false, we show it only at the start
    if (widget.settings['loop'] && !widget.settings['autoPlay']) {
      // Either it's the first time the video is loaded or the video is paused
      return _ControlsOverlay(
        controller: logic.controller,
        videoEnded: logic.videoEnded.value,
        isClicked: logic.isClicked.value,
        isFirstTime: logic.isFirstTime.value,
        onPlayPauseClicked: () {
          logic.isClicked.value =
          !logic.isClicked.value; // Toggle the value of isClicked every time
          if (logic.isFirstTime.value) {
            logic.isFirstTime.value = false;
          }
        },
      );
    }


    return SizedBox.shrink();
  }


  @override
  Widget build(BuildContext context) {
    // logic.initializeValueOfVideo(widget.settings);
    print("fffsfsfsss");
    // if (widget.settings['autoPlay'] == true) {
    //   logic.controller.play();
    // }
    // else if(logic.controller.value.position == logic.controller.value.duration && widget.settings['loop'] == false){
    //   videoEnded = true;
    //   logic.controller.pause();
    // }
    return Obx((){
      return appConfig.innerLoader.value == true
          ? Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        height: 400.h,
        width: double.infinity,
        child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: logic.enabled.value,
            child: Container(
              color: AppColors.customWhiteTextColor,
            )),
      ): SingleChildScrollView(
        child:
        Column(
          children: <Widget>[
            widget.settings['isTitleHidden'] == false ? Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 6),
              child: Container(
                margin: widget.settings['titleAlignment'] != 'center'
                    ? EdgeInsets.symmetric(
                    horizontal: pageMarginHorizontal / 1.5)
                    : EdgeInsets.symmetric(horizontal: 0,),
                width: double.maxFinite,
                child: Text('${widget.settings["title"]}',
                  textAlign: widget.settings['titleAlignment'] == 'left'
                      ? TextAlign.left
                      : widget.settings['titleAlignment'] == 'center'
                      ? TextAlign.center
                      : TextAlign.right,
                  style: widget.settings['titleSize'] == 'small' ? context.text
                      .titleSmall : widget.settings['titleSize'] == 'medium'
                      ? context.text.titleMedium
                      : context.text.titleLarge,
                ),
              ),
            ) : SizedBox(),

            (widget.settings["video"] != null &&
                widget.settings["metadata"]["data"].isEmpty)
                ? singleImageVariant() ?? SizedBox.shrink()
                : customImageVariant(context) ?? SizedBox.shrink(),
          ],
        ),
      );
    });
  }

  double videoContainerRatio = 0.5;

  double getScale() {
    double videoRatio = logic.controller.value.aspectRatio;

    if (videoRatio > videoContainerRatio) {
      ///for tall videos, we just return the inverse of the controller aspect ratio
      return videoContainerRatio / videoRatio;
    } else {
      ///for wide videos, divide the video AR by the fixed container AR
      ///so that the video does not over scale

      return videoRatio / videoContainerRatio;
    }
  }

  singleImageVariant() {
    return Obx(() {
      print("auto adjustment: ${logic.enabled.value}");
      return GestureDetector(
        onTap: () {
          if (widget.settings["web_url"] != null) {
            Get.to(() =>
                WebViewProduct(
                  productUrl: widget.settings["web_url"],
                ), opaque: false, transition: Transition.native);
          }
        },
        child: Padding(
            padding: widget.settings["margin"] == true
                ? EdgeInsets.symmetric(
                horizontal: pageMarginHorizontal / 1.5,
                vertical: pageMarginVertical / 1.5)
                : EdgeInsets.all(0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: widget.settings["margin"] == true ? BorderRadius
                      .circular(3.r) : BorderRadius.zero,
                  child: AspectRatio(
                      aspectRatio: logic.controller.value.aspectRatio,
                      child: VideoPlayer(logic.controller)),
                )
                // logic.heightCheck.value > 0.0 ? ClipRRect(
                //   borderRadius: widget.settings["margin"] == true ? BorderRadius
                //       .circular(3.r) : BorderRadius.zero,
                //   child: AspectRatio(
                //       aspectRatio: logic.heightCheck.value,
                //       child: VideoPlayer(logic.controller)),
                // ) : Container(
                //   width: double.maxFinite,
                //   height: logic.heightCheck1.value,
                //   child: productShimmer(),),
                // ),
                // logic.heightCheck.value > 0.0 ? AspectRatio(
                //     aspectRatio: logic.heightCheck.value,
                //     // height: widget.settings["displayType"] == "normal"
                //     //     ? 300.h
                //     //     : widget.settings["displayType"] == "vertical"
                //     //     ? 400.h
                //     //     : widget.settings["displayType"] == "auto"
                //     //     ? Get.height
                //     //     : 230.h,
                //     child: getPlayPauseButton()) : Container(
                //   width: double.maxFinite,
                //   height: logic.heightCheck1.value,
                //   child: productShimmer(),),
              ],
            )

        ),
      );
    });
  }


  final appConfig = AppConfig.to;

  customImageVariant(BuildContext context) {
    if (widget.settings["metadata"]['data'].isNotEmpty) {
      ProductInfo? productInfo = appConfig.getProductById(
        id: widget.settings["metadata"]["data"][0]["id"],
        dataType: widget.settings["metadata"]['dataType'],
      );

      return Obx(() {
        return GestureDetector(
          onTap: () {
            if (widget.settings['metadata']['data'].isNotEmpty) {
              HomeLogic.to.productDetailNavigator(
                  context: context,
                  info: productInfo!,
                  dataType: widget.settings["metadata"]['dataType']);
            }
          },
          child: Padding(
              padding: widget.settings["margin"] == true
                  ? EdgeInsets.symmetric(
                  horizontal: pageMarginHorizontal / 1.5,
                  vertical: pageMarginVertical / 1.5)
                  : EdgeInsets.all(0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // SizedBox(
                  //   height: widget.settings["displayType"] == "normal"
                  //       ? 300.h
                  //       : widget.settings["displayType"] == "vertical"
                  //       ? 400.h
                  //       : widget.settings["displayType"] == "auto"
                  //       ? Get.height
                  //       : 230.h,
                  //   width: double.maxFinite,
                  //   child: ClipRect(
                  //     child: FittedBox(
                  //       fit: BoxFit.cover,
                  //       child: SizedBox(
                  //         width: Get.height * 2 * logic.controller.value.aspectRatio,
                  //         height: widget.settings["displayType"] == "normal"
                  //             ? (widget.settings["autoPlay"] == true && widget.settings['loop'] == true) ? Get.height * 4: Get.height * 2.5
                  //             : widget.settings["displayType"] == "vertical"
                  //             ? (widget.settings["autoPlay"] == true && widget.settings['loop'] == true) ? Get.height * 4: Get.height * 2.5
                  //             : widget.settings["displayType"] == "auto"
                  //             ? (widget.settings["autoPlay"] == true && widget.settings['loop'] == true) ? Get.height * 4: Get.height * 2.5
                  //             : (widget.settings["autoPlay"] == true && widget.settings['loop'] == true) ? Get.height * 4: Get.height * 2.5,
                  //         child: VideoPlayer(logic.controller),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //     width: MediaQuery.of(context).size.width,
                  //     height: MediaQuery.of(context).size.height,
                  //     child:

                  ClipRRect(
                    borderRadius: widget.settings["margin"] == true ? BorderRadius
                        .circular(3.r) : BorderRadius.zero,
                    child: AspectRatio(
                        aspectRatio: logic.controller.value.aspectRatio,
                        child: VideoPlayer(logic.controller)),
                  )

                  // logic.heightCheck.value > 0.0 ? AspectRatio(
                  //     aspectRatio: logic.heightCheck.value,
                  //     child: VideoPlayer(logic.controller)) : Container(
                  //   width: double.maxFinite,
                  //   height: logic.heightCheck1.value,
                  //   child: productShimmer(),),
                  // ),
                  // logic.heightCheck.value > 0.0 ? AspectRatio(
                  //     aspectRatio: logic.heightCheck.value,
                  //     // height: widget.settings["displayType"] == "normal"
                  //     //     ? 300.h
                  //     //     : widget.settings["displayType"] == "vertical"
                  //     //     ? 400.h
                  //     //     : widget.settings["displayType"] == "auto"
                  //     //     ? Get.height
                  //     //     : 230.h,
                  //     child: getPlayPauseButton()) : Container(
                  //   width: double.maxFinite,
                  //   height: logic.heightCheck1.value,
                  //   child: productShimmer(),),
                ],
              )

          ),
        );
      });
    }
  }
}


class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({
    required this.controller,
    required this.videoEnded,
    required this.isClicked,
    required this.isFirstTime,
    required this.onPlayPauseClicked,
  });

  final VideoPlayerController controller;
  final bool videoEnded;
  final bool isClicked;
  final bool isFirstTime;
  final VoidCallback onPlayPauseClicked;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: (controller.value.isPlaying && !videoEnded &&
              (!isFirstTime || isClicked))
              ? SizedBox.shrink()
              : Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),

            ),
            child: Center(
              child:
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.appHintColor
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 60.0,
                  semanticLabel: 'Play',
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
            onPlayPauseClicked();
          },
        ),
      ],
    );
  }
}