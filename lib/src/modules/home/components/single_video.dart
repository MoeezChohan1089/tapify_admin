// import 'package:chewie/chewie.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tapify/src/utils/extensions.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../utils/constants/colors.dart';
// import '../../../utils/constants/margins_spacnings.dart';
//
// class SingleVideoView extends StatefulWidget {
//   final dynamic settings;
//   const SingleVideoView({Key? key, required this.settings}) : super(key: key);
//
//   @override
//   State<SingleVideoView> createState() => _SingleVideoViewState();
// }
//
// class _SingleVideoViewState extends State<SingleVideoView> {
//
//   // final Map<String, dynamic> settings = {
//   // "isTitleHidden": true,
//   // "title": 'Your Title',
//   // "titleAlignment": 'left',
//   // "titleSize": 'small',
//   // "video": {},
//   // "thumbnail": {},
//   // "videoDisplayType": 'fit',
//   // "autoPlay": true,
//   // "controlBar": false,
//   // "mute": false,
//   // "restart": false,
//   // "loop": false,
//   // "margin": false
//   // };
//
//   // late VideoPlayerController videoController;
//   // late FlickManager _flickManager;
//   late VideoPlayerController videoPlayerController;
//   late ChewieController chewieController;
//
//   @override
//   void initState() async{
//     super.initState();
//
//     final videoPlayerController = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//
//     await videoPlayerController.initialize();
//
//     chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: true,
//       looping: true,
//     );
//
//     final playerWidget = Chewie(
//       controller: chewieController,
//     );
//
//     // _flickManager = FlickManager(
//     //   videoPlayerController: VideoPlayerController.network(
//     //       "https://drive.google.com/uc?id=1tWqigIjEQ4HUvFrbGf3A6mPiq6O7Ys3S"),
//     //   autoPlay: widget.settings['autoPlay'] == true? true:false,
//     // );
//
//
//     // _initializeVideoPlayer();
//     // videoController = VideoPlayerController.network(
//     //     "https://drive.google.com/uc?id=1tWqigIjEQ4HUvFrbGf3A6mPiq6O7Ys3S");
//     // videoController.initialize().then((value) {
//     //   videoController.play();
//     //   // videoController.setLooping(true);
//     //   setState(() {});
//     // });
//   }
//
//   // _initializeVideoPlayer() async {
//   //   videoController = VideoPlayerController.network(
//   //       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//   //
//   //   /// Initialize the video player
//   //   await videoController.initialize();
//   //   videoController.play();
//   //
//   //   /// The rest of your code
//   //   // final chewieController = ChewieController(
//   //   //   videoPlayerController: videoPlayerController,
//   //   //   autoPlay: true,
//   //   //   looping: true,
//   //   // );
//   // }
//
//   @override
//   void dispose() {
//     videoPlayerController.dispose();
//     chewieController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: widget.settings["margin"] == true ? EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical):EdgeInsets.all(0),
//       child: Column(
//         children: [
//           widget.settings['isTitleHidden'] == true? Container(
//             margin: widget.settings['titleAlignment'] != 'center'? EdgeInsets.symmetric(horizontal: pageMarginHorizontal):EdgeInsets.symmetric(horizontal: 0),
//             width: double.maxFinite,
//             child: Text('${widget.settings["title"]}',
//               textAlign: widget.settings['titleAlignment'] == 'left'? TextAlign.left: widget.settings['titleAlignment'] == 'center'?TextAlign.center:TextAlign.right,
//               style: widget.settings['titleSize'] == 'small'? context.text.titleSmall: widget.settings['titleSize'] == 'medium'? context.text.titleMedium:context.text.titleLarge,
//             ),
//           ):SizedBox(),
//           Container(
//             height: 200.h,
//             margin: EdgeInsets.symmetric(horizontal: pageMarginVertical, vertical: pageMarginVertical),
//             child: Stack(
//               children: [
//                 AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: FlickVideoPlayer(flickManager: _flickManager,
//                       flickVideoWithControls: FlickVideoWithControls(
//                         videoFit: widget.settings['videoDisplayType'] == 'fit'? BoxFit.cover:BoxFit.fill,
//                         controls: Stack(
//                           children: <Widget>[
//                             Positioned(
//                               top: 0,
//                               bottom: 0,
//                               left: 0,
//                               right: 0,
//                               child: Center(
//                                 child: CircleAvatar(
//                                   radius: 25,
//                                   backgroundColor: AppColors.customWhiteTextColor,
//                                   child: FlickPlayToggle(
//                                     playChild: widget.settings['controlBar'] == true ? Icon(Icons.play_arrow, color: Colors.white,) : null,
//                                     pauseChild: widget.settings['controlBar'] == true ? Icon(Icons.pause, color: Colors.white,):null,
//                                     replayChild: widget.settings['restart'] == true ? Icon(Icons.restart_alt, color: Colors.white,) : null,
//                                     // togglePlay: videoVal['controlBar'] == false
//                                     //     ? () => _flickManager.flickControlManager!.play()
//                                     //     : () => _flickManager.flickControlManager!.pause(),
//
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               right: 0,
//                               bottom: 0,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: FlickSoundToggle(
//                                   muteChild: widget.settings['mute'] == true ? Icon(Icons.volume_off, color: Colors.white,) : null,
//                                   unmuteChild: widget.settings['mute'] == true ? null : Icon(Icons.volume_up, color: Colors.white,),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//                       ),
//                     )),
//
//                 // Center(
//                 //     child: videoController.value.isInitialized
//                 //         ?
//                 //         : const CircularProgressIndicator(
//                 //             color: Colors.grey,
//                 //           )),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }