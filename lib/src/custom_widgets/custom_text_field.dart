import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../utils/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final bool isEditable;
  final bool autoFocus;
  final double? fieldVerticalPadding;
  final double? fieldHorizontalPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final  TextAlign? textAlign;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormat;
  final int? maxLines;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator; // Input validator function

  const CustomTextField({super.key,
    required this.controller,
    required this.hint,
    this.isObscure = false,
    this.isEditable = true,
    this.autoFocus = false,
    this.prefixIcon,
    this.fieldVerticalPadding,
    this.fieldHorizontalPadding,
    this.textAlign,
    this.inputFormat,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.suffixIcon,
    this.onTap,
    this.keyBoardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyBoardType,
      enabled: isEditable,
      // onTap: onTap,
      validator: validator, // Set the validator function
      style: context.text.bodyLarge?.copyWith(
        color: AppColors.appTextColor
      ),
      textAlign: textAlign ?? TextAlign.left,
      autofocus: autoFocus,
      cursorColor: AppColors.appTextColor,
      maxLines: maxLines,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      inputFormatters: inputFormat,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.textFieldBGColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: fieldVerticalPadding != null ? fieldVerticalPadding! : suffixIcon != null ? 10 : 10
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.appPriceRedColor.withOpacity(.7),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.appPriceRedColor.withOpacity(.7),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(5.r),
        ),
        hintText: hint,
        hintStyle: context.text.bodyMedium?.copyWith(
          color: AppColors.appHintColor
        ),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 43,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 35,
        ),
        errorStyle: context.text.bodySmall?.copyWith(
          color: AppColors.appPriceRedColor,
          fontSize: 11.sp
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}