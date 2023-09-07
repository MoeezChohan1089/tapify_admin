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

class SingleVideoView2 extends StatefulWidget {
  final dynamic settings;

  const SingleVideoView2({super.key, required this.settings});

  @override
  SingleVideoView2State createState() => SingleVideoView2State();
}

class SingleVideoView2State extends State<SingleVideoView2> {

  final logic = Get.put(HomeLogic());
  List<VideoPlayerController> controllers = [];
  RxBool videoEnded = false.obs;
  RxBool isFirstTime = true.obs;
  RxBool isClicked = false.obs;

  @override
  void initState() {
    super.initState();
    print("ffsfsfsd");
    initializeFun();
  }

  @override
  void didUpdateWidget(covariant SingleVideoView2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("update now");
    // Check if the video URL has changed
    if (oldWidget.settings['video'] != widget.settings['video']) {
      // Dispose the old controller(s) to free up resources
      for (var controller in controllers) {
        controller.dispose();
      }
      controllers.clear();
      // Initialize a new controller with the new URL
      // You can potentially move the initialization logic into a separate method
      // to avoid duplicating code between initState and didUpdateWidget.
      initializeFun(); // Assuming you've moved the logic to this method
    }
  }

  initializeFun() async{


    print("hello world");
    VideoPlayerController controller = VideoPlayerController.network(widget.settings['video'] ?? "",   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),);

    // selectedVideos.add(videoUrl);
    controller.addListener(() {
      // This condition checks if the video has reached its end
      if (controller.value.position == controller.value.duration && widget.settings['loop'] == false) {
        if (!videoEnded.value) { // This check ensures setState is only called once at the video's end.
          videoEnded.value = true;
          controller.pause();
        }
      } else if (controller.value.isPlaying) {
        if (videoEnded.value) { // If video started playing again, update videoEnded
          videoEnded.value = false;
        }
      }else if (isFirstTime.value && controller.value.isPlaying) {
        isFirstTime.value = false;
      }
    });
      controller.initialize().then((_) {
        if (mounted) { // Ensure the widget is still in the tree.
          setState(() {});
        }
        if (controller.value.isInitialized) {
          print("abcdefgh");
          // selectedVideos.add(videoUrl);
          // heightCheck.value = controller.value.size.aspectRatio;
          // heightCheck1.value = controller.value.size.height;
          // print("Video height: ${heightCheck.value}");
        }
        // This will refresh the UI once the video is initialized
        // if (settings['autoPlay'] == true) {
        //   controller.play();
        //   update();
        // }
        controller.setVolume(0);
        controller.play();
        // controller.videoPlayerOptions!.webOptions!.controls;
        // Auto play the video if required
      }).catchError((error) {
        print('Error initializing video: $error');
      });

    controllers.add(controller);
    controller.setLooping(true);
    // if (widget.settings['loop'] == true) {
    //   for (var controller in controllers) {
    //     controller.setLooping(true);
    //   }
    // }else{
    //   for (var controller in controllers) {
    //    if(controller.value.position == controller.value.duration){
    //      controller.pause();
    //    }
    //   }
    // }
    // else {
    //   for (var controller in controllers) {
    //     controller.setLooping(false);
    //   }
    // }
  }

  // @override
  // void dispose() {
  //   logic.controller.dispose();
  //   super.dispose();
  // }

  // Widget getPlayPauseButton() {
  //   // When loop is true and autoplay is true, we never show the button
  //   if (widget.settings['loop'] && widget.settings['autoPlay']) {
  //     print("== fucking error is here :: ${logic.videoEnded.value} ");
  //     return SizedBox.shrink();
  //   }
  //
  //   // When loop is false
  //   if (widget.settings['autoPlay'] && !widget.settings['loop'] &&
  //       logic.videoEnded.value) {
  //     return _ControlsOverlay(
  //       controller: logic.controller,
  //       videoEnded: logic.videoEnded.value,
  //       isClicked: logic.isClicked.value,
  //       isFirstTime: logic.isFirstTime.value,
  //       onPlayPauseClicked: () {
  //         logic.isClicked.value = true;
  //         logic.isFirstTime.value = false;
  //       },
  //     );
  //   }
  //
  //   if (!widget.settings['autoPlay'] && !widget.settings['loop']) {
  //     return _ControlsOverlay(
  //       controller: logic.controller,
  //       videoEnded: logic.videoEnded.value,
  //       isClicked: logic.isClicked.value,
  //       isFirstTime: logic.isFirstTime.value,
  //       onPlayPauseClicked: () {
  //         logic.isClicked.value = !logic.isClicked.value;
  //         if (logic.isFirstTime.value) {
  //           logic.isFirstTime.value = false;
  //         }
  //       },
  //     );
  //   }
  //
  //   // When loop is true but autoplay is false, we show it only at the start
  //   if (widget.settings['loop'] && !widget.settings['autoPlay']) {
  //     // Either it's the first time the video is loaded or the video is paused
  //     return _ControlsOverlay(
  //       controller: logic.controller,
  //       videoEnded: logic.videoEnded.value,
  //       isClicked: logic.isClicked.value,
  //       isFirstTime: logic.isFirstTime.value,
  //       onPlayPauseClicked: () {
  //         logic.isClicked.value =
  //         !logic.isClicked.value; // Toggle the value of isClicked every time
  //         if (logic.isFirstTime.value) {
  //           logic.isFirstTime.value = false;
  //         }
  //       },
  //     );
  //   }
  //
  //
  //   return SizedBox.shrink();
  // }


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

  singleImageVariant() {
    return Obx(() {
      print("auto adjustment: ${logic.enabled.value}");
      return logic.enabledShow.value? Center(child: CircularProgressIndicator(),): RepaintBoundary(
        child: GestureDetector(
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
                  : EdgeInsets.zero,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    children: List.generate(controllers.length,
                            (index){
                      final controller = controllers[index];
                      if (controller.value.isInitialized) {
                        return ClipRRect(
                          borderRadius: widget.settings["margin"] == true ? BorderRadius
                              .circular(3.r) : BorderRadius.zero,
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          ),
                        );
                      } else {
                        return Container(
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
                        ); // Show loading while the video is being initialized
                      }
                    }),
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
        print("auto adjustment: ${logic.enabled.value}");
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
                  Column(
                    children: List.generate(controllers.length,
                            (index){
                          final controller = controllers[index];
                          if (controller.value.isInitialized) {
                            return ClipRRect(
                              borderRadius: widget.settings["margin"] == true ? BorderRadius
                                  .circular(3.r) : BorderRadius.zero,
                              child: AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: VideoPlayer(controller),
                              ),
                            );
                          } else {
                            return Container(
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
                            ); // Show loading while the video is being initialized
                          }
                        }),
                  )
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