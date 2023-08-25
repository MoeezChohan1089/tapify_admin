

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../utils/constants/margins_spacnings.dart';
import '../../home/view.dart';

class SignInButton extends StatefulWidget {
  String? title;
  SignInButton({Key? key, this.title}) : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: pageMarginVertical* 2),
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
            onPressed: (){
              Get.to(() => HomePage());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,// Set the text color of the button
              padding: const EdgeInsets.all(16), // Set the padding around the button content
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // Set the border radius of the button
              ),
            ),
            child: Text("${widget.title}", style: context.text.bodyMedium!.copyWith(color: Colors.white, height: 1.1),)),
      ),
    );
  }
}