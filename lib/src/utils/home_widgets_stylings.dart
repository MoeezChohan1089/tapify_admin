import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../global_controllers/currency_controller.dart';
import 'constants/colors.dart';
import 'constants/margins_spacnings.dart';


///----
///------------ Home Widget's Title Style -----------///
///----
class HomeProductsTitle extends StatelessWidget {
  final String title;
  final Color textColor;
  final double titleHeight, textSize;

  const HomeProductsTitle({Key? key, required this.title, this.textColor = Colors.black, this.titleHeight = 28, this.textSize = 14}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: titleHeight.h,
      // color: Colors.yellow,
      child: Text(
          title.capitalize!,
          maxLines: titleHeight < 36 ? 1 : 2,
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          style: context.text.bodyMedium?.copyWith(
              height: 1.1,
              color: textColor,
            fontSize: textSize.sp
          )
      ),
    );
  }
}


///----
///------------ Home Widget's Price Style -----------///
///----
class HomeProductsPrice extends StatelessWidget {
  final double price;
  final Color priceColor;

  const HomeProductsPrice({Key? key, required this.price, this.priceColor = AppColors
      .customGreyTextColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        price == 0 ?  "FREE" :  CurrencyController.to.getConvertedPrice(
          priceAmount: price
      ),
      style: context.text.bodyMedium
          ?.copyWith(
          height: 1.0,
          color: priceColor),
    );
  }
}


///----
///------------ Home Widget's Quick View Button -----------///
///----
class AppQuickViewButton extends StatelessWidget {
  final Function onPress;
  const AppQuickViewButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        6.heightBox,
        GestureDetector(
          onTap: () => onPress(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: pageMarginVertical / 1.5),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                )),
            child: Text(
              'Quick View',
              textAlign: TextAlign.center,
              style: context.text.bodySmall?.copyWith(height: .5),
            ),
          ),
        ),
      ],
    );
  }
}