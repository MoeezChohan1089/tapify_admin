
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';

class CustomHeadingImage extends StatefulWidget {
   CustomHeadingImage({Key? key}) : super(key: key);

  @override
  State<CustomHeadingImage> createState() => _CustomHeadingImageState();
}

class _CustomHeadingImageState extends State<CustomHeadingImage> {
  bool showImage = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showImage == true? InkWell(
            onTap:(){
              setState(() {
                showImage = false;
              });
            },
            child: Image.asset('assets/images/fillinx.png', width: 100, height: 100,)):
        InkWell(
            onTap:(){
              setState(() {
                showImage = true;
              });
            },
            child: Image.asset('assets/images/NoPath.png', )),
        10.heightBox,
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black),
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              elevation: 0,// Set the text color of the button
              padding: const EdgeInsets.symmetric(horizontal: 30,), // Set the padding around the button content
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // Set the border radius of the button
              ),
            ),
            onPressed: (){}, child: Text("Tap To Explore", style: context.text.bodyMedium!.copyWith(fontSize: 16.sp),))
      ],
    );
  }
}
