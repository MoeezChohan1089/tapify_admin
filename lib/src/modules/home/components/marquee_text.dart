import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';

class AnimatedMarqueeText extends StatelessWidget {
  final dynamic settings;


  const AnimatedMarqueeText({Key? key, required this.settings}) : super(key: key);

  // final Map settings = {
  //   "title": 'Marquee text show here',
  //   "titleAlignment": 'right',
  //   "titleSize": 'small',
  //   "textColor": '#ffffff',
  //   "backgroundColor": '#000',
  //   "margin": false,
  //   "contentMargin": false,
  //   "hideContentTitle": false,
  //   "disableInteraction": false
  // };


  @override
  Widget build(BuildContext context) {
    return Container(
      height: settings["titleSize"] == "small" ? 45.h : (settings["titleSize"] == "medium" ? 50.h : 55.h),
      margin: EdgeInsets.only(
          bottom: 0.h
          // bottom: 4.h
      ),
      color: settings["backgroundColor"].toString().toColor(),
      child: Align(
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: Marquee(
            text: settings["title"],
            style: settings["titleSize"] == "small" ? context.text.titleSmall?.copyWith(
                color: settings["textColor"].toString().toColor(),
                height: 3
            ) : settings["titleSize"] == "medium" ? context.text.titleMedium?.copyWith(
                color: settings["textColor"].toString().toColor(),
                height: 2.5

            ) : context.text.titleLarge?.copyWith(
                color: settings["textColor"].toString().toColor(),
                height: 2.1
            ),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            blankSpace: 100.w,
            // velocity: 50.0,
            velocity: settings["titleSpeed"] == "slow" ? 50.0 : settings["titleSpeed"] == "medium" ? 90.0 : 120.0,
            startPadding: 10.0,
            accelerationCurve: Curves.linear,
            decelerationCurve: Curves.linear,
          ),
        ),
      ),
    );
  }
}