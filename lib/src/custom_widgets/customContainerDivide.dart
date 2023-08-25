import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/margins_spacnings.dart';

class ExpandState {
  bool expand = false;
}

class CustomContainerDivide extends StatefulWidget {
  final String heading;
  final String description;

  CustomContainerDivide({required this.heading, required this.description});

  @override
  _CustomContainerDivideState createState() => _CustomContainerDivideState();
}

class _CustomContainerDivideState extends State<CustomContainerDivide> {
  late ExpandState expandState;


  @override
  void initState() {
    super.initState();
    expandState = ExpandState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal, vertical: pageMarginVertical),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expandState.expand = !expandState.expand;
              });
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            widget.heading,
                            style: context.text.headlineLarge?.copyWith(fontSize: 18.sp),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColors.customBlackTextColor,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: expandState.expand ? 10 : 0),
                  expandState.expand
                      ? Builder(builder: (context) {
                    return Text(
                      widget.description,
                      style: context.text.bodyLarge?.copyWith(fontSize: 16.sp),
                    );
                  })
                      : Container(),
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
