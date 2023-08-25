import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';

class AuthBlackButton extends StatefulWidget {
  final String buttonTitle;
  final Function onPressed;

  const AuthBlackButton({Key? key, required this.buttonTitle, required this.onPressed}) : super(key: key);

  @override
  State<AuthBlackButton> createState() => _AuthBlackButtonState();
}

class _AuthBlackButtonState extends State<AuthBlackButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
          onPressed: () => widget.onPressed(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,// Set the text color of the button
              padding: const EdgeInsets.all(8), // Set the padding around the button content
              shape: const BeveledRectangleBorder()
          ),
          child: Text(
              widget.buttonTitle.capitalize!,
              style: context.text.bodyLarge?.copyWith(
                  color: Colors.white
              )
          )),
    );
  }
}