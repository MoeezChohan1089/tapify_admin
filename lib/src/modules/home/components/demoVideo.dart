import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/extensions.dart';
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
    logic.initializeValueOfVideo(widget.settings);
  }


  @override
  void dispose() {
    logic.controller.dispose();
    super.dispose();
  }

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
          logic.isClicked.value = !logic.isClicked.value; // Toggle the value of isClicked every time
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
    print("fffsfsfsss");
    // if (widget.settings['autoPlay'] == true) {
    //   logic.controller.play();
    // }
    // else if(logic.controller.value.position == logic.controller.value.duration && widget.settings['loop'] == false){
    //   videoEnded = true;
    //   logic.controller.pause();
    // }
    return SingleChildScrollView(
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
              ? singleImageVariant()
              : customImageVariant(context),

          // Padding(
          //   padding: widget.settings["margin"] == true ? EdgeInsets.symmetric(horizontal: pageMarginHorizontal/1.5, vertical: pageMarginVertical/1.5):EdgeInsets.all(0),
          //   child: Container(
          //     // padding: const EdgeInsets.all(20),
          //     height: widget.settings["displayType"] == "normal" ? 350.h: widget.settings["displayType"] == "vertical"? 500.h: widget.settings["displayType"] == "auto"? null:200.h,
          //     width: double.maxFinite,
          //     child: AspectRatio(
          //       aspectRatio: _logic.controller.value.aspectRatio,
          //       child: Stack(
          //         alignment: Alignment.center,
          //         children: <Widget>[
          //
          //           VideoPlayer(_logic.controller),
          //           widget.settings['autoPlay'] == false?  _ControlsOverlay(logic.controller: _logic.controller):SizedBox.shrink(),
          //           // ValueListenableBuilder(
          //           //   valueListenable: _logic.controller,
          //           //   builder: (context, VideoPlayerValue value, child) {
          //           //     if (!value.isPlaying && !value.isBuffering) {
          //           //       return GestureDetector(
          //           //         onTap: () {
          //           //           if (!_logic.controller.value.isPlaying) {
          //           //             _logic.controller.play();
          //           //           } else {
          //           //             _logic.controller.pause();
          //           //           }
          //           //         },
          //           //         child: Icon(Icons.play_arrow, size: 64.0, color: Colors.white),
          //           //       );
          //           //     } else {
          //           //       return SizedBox.shrink(); // Returns an empty widget if the video is playing or buffering
          //           //     }
          //           //   },
          //           // ),
          //           // _ControlsOverlay(logic.controller: _logic.controller),
          //           // VideoProgressIndicator(_logic.controller, allowScrubbing: true),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
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
      return GestureDetector(
        onTap: () {
          if (widget.settings["web_url"] != null) {
            ///------ Open the Web
            Get.to(() =>
                WebViewProduct(
                  productUrl: widget.settings["web_url"],
                ));
          }
        },
        child: Padding(
          padding: widget.settings["margin"] == true ? EdgeInsets.symmetric(
              horizontal: pageMarginHorizontal / 1.5,
              vertical: pageMarginVertical / 1.5) : EdgeInsets.all(0),
          child: Container(
            // padding: const EdgeInsets.all(20),

            height: widget.settings["displayType"] == "normal" ? 300.h : widget
                .settings["displayType"] == "vertical" ? 400.h : widget
                .settings["displayType"] == "auto" ? null : 230.h,
            width: double.maxFinite,
            child: AspectRatio(
              aspectRatio: logic.controller.value.aspectRatio /2,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  VideoPlayer(logic.controller),
                  getPlayPauseButton(),
                  // ValueListenableBuilder(
                  //   valueListenable: _logic.controller,
                  //   builder: (context, VideoPlayerValue value, child) {
                  //     if (!value.isPlaying && !value.isBuffering) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           if (!_logic.controller.value.isPlaying) {
                  //             _logic.controller.play();
                  //           } else {
                  //             _logic.controller.pause();
                  //           }
                  //         },
                  //         child: Icon(Icons.play_arrow, size: 64.0, color: Colors.white),
                  //       );
                  //     } else {
                  //       return SizedBox.shrink(); // Returns an empty widget if the video is playing or buffering
                  //     }
                  //   },
                  // ),
                  // _ControlsOverlay(logic.controller: _logic.controller),
                  // VideoProgressIndicator(_logic.controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  final appConfig = AppConfig.to;

  customImageVariant(BuildContext context) {
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
          padding: widget.settings["margin"] == true ? EdgeInsets.symmetric(
              horizontal: pageMarginHorizontal / 1.5,
              vertical: pageMarginVertical / 1.5) : EdgeInsets.all(0),
          child: Container(
            // padding: const EdgeInsets.all(20),
            height: widget.settings["displayType"] == "normal" ? 300.h : widget
                .settings["displayType"] == "vertical" ? 400.h : widget
                .settings["displayType"] == "auto" ? null : 230.h,
            width: double.maxFinite,
            child: AspectRatio(
              aspectRatio: logic.controller.value.aspectRatio/2,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  VideoPlayer(logic.controller),
                  getPlayPauseButton(),
                  // ValueListenableBuilder(
                  //   valueListenable: _logic.controller,
                  //   builder: (context, VideoPlayerValue value, child) {
                  //     if (!value.isPlaying && !value.isBuffering) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           if (!_logic.controller.value.isPlaying) {
                  //             _logic.controller.play();
                  //           } else {
                  //             _logic.controller.pause();
                  //           }
                  //         },
                  //         child: Icon(Icons.play_arrow, size: 64.0, color: Colors.white),
                  //       );
                  //     } else {
                  //       return SizedBox.shrink(); // Returns an empty widget if the video is playing or buffering
                  //     }
                  //   },
                  // ),
                  // _ControlsOverlay(logic.controller: _logic.controller),
                  // VideoProgressIndicator(_logic.controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ),
      );
    });
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

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

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


// import 'dart:io';
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:video_player/video_player.dart';
//
// class ChewieDemo extends StatefulWidget {
//   const ChewieDemo({
//     Key? key,
//     this.title = 'Chewie Demo',
//   }) : super(key: key);
//
//   final String title;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _ChewieDemoState();
//   }
// }
//
// class _ChewieDemoState extends State<ChewieDemo> {
//   TargetPlatform? _platform;
//   late VideoPlayerController _videoPlayerController1;
//   late VideoPlayerController _videoPlayerController2;
//   ChewieController? _chewieController;
//   int? bufferDelay;
//
//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController1.dispose();
//     _videoPlayerController2.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
//
//   List<String> srcs = [
//     // "https://tapday.s3.ap-south-1.amazonaws.com/upload/images/media/xFybljQHiVfNlcvVqqocJxrtK4tgMPMYh2sbe3oo.mp4"
//     "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4"
//   ];
//
//   Future<void> initializePlayer() async {
//     _videoPlayerController1 =
//         VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
//     _videoPlayerController2 =
//         VideoPlayerController.networkUrl(Uri.parse(srcs[currPlayIndex]));
//     await Future.wait([
//       _videoPlayerController1.initialize(),
//       _videoPlayerController2.initialize()
//     ]);
//     _createChewieController();
//     setState(() {});
//   }
//
//   void _createChewieController() {
//     // final subtitles = [
//     //     Subtitle(
//     //       index: 0,
//     //       start: Duration.zero,
//     //       end: const Duration(seconds: 10),
//     //       text: 'Hello from subtitles',
//     //     ),
//     //     Subtitle(
//     //       index: 0,
//     //       start: const Duration(seconds: 10),
//     //       end: const Duration(seconds: 20),
//     //       text: 'Whats up? :)',
//     //     ),
//     //   ];
//
//
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1,
//       autoPlay: true,
//       looping: true,
//       showControls: false,
//       fullScreenByDefault: true,
//        progressIndicatorDelay:
//       bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
//       // additionalOptions: (context) {
//       //   return <OptionItem>[
//       //     OptionItem(
//       //       onTap: toggleVideo,
//       //       iconData: Icons.live_tv_sharp,
//       //       title: 'Toggle Video Src',
//       //     ),
//       //   ];
//       // },
//
//
//       // Try playing around with some of these other options:
//
//       // showControls: false,
//       // materialProgressColors: ChewieProgressColors(
//       //   playedColor: Colors.red,
//       //   handleColor: Colors.blue,
//       //   backgroundColor: Colors.grey,
//       //   bufferedColor: Colors.lightGreen,
//       // ),
//       // placeholder: Container(
//       //   color: Colors.grey,
//       // ),
//       // autoInitialize: true,
//     );
//   }
//
//   int currPlayIndex = 0;
//
//   Future<void> toggleVideo() async {
//     await _videoPlayerController1.pause();
//     currPlayIndex += 1;
//     if (currPlayIndex >= srcs.length) {
//       currPlayIndex = 0;
//     }
//     await initializePlayer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Center(
//           child: _chewieController != null &&
//               _chewieController!
//                   .videoPlayerController.value.isInitialized
//               ? AspectRatio(
//                 aspectRatio: _chewieController!.videoPlayerController.value.aspectRatio,
//                 child: FittedBox(
//                       fit: BoxFit.cover,
//                       child: Chewie(
//                         controller: _chewieController!,
//                       ),
//                     ),
//               )
//               : Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 20),
//               Text('Loading'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // class DelaySlider extends StatefulWidget {
// //   const DelaySlider({Key? key, required this.delay, required this.onSave})
// //       : super(key: key);
// //
// //   final int? delay;
// //   final void Function(int?) onSave;
// //   @override
// //   State<DelaySlider> createState() => _DelaySliderState();
// // }
// //
// // class _DelaySliderState extends State<DelaySlider> {
// //   int? delay;
// //   bool saved = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     delay = widget.delay;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     const int max = 1000;
// //     return
// //       ListTile(
// //       title: Text(
// //         "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
// //       ),
// //       // subtitle: Slider(
// //       //   value: delay != null ? (delay! / max) : 0,
// //       //   onChanged: (value) async {
// //       //     delay = (value * max).toInt();
// //       //     setState(() {
// //       //       saved = false;
// //       //     });
// //       //   },
// //       // ),
// //       // trailing: IconButton(
// //       //   icon: const Icon(Icons.save),
// //       //   onPressed: saved
// //       //       ? null
// //       //       : () {
// //       //     widget.onSave(delay);
// //       //     setState(() {
// //       //       saved = true;
// //       //     });
// //       //   },
// //       // ),
// //     );
// //   }
// // }