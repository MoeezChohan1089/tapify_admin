import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify/src/utils/constants/margins_spacnings.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../api_services/shopify_flutter/models/src/order/line_item_order/line_item_order.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';

class paymentInformationScreen extends StatefulWidget {
  final Order? orderDetailsPayment;
  paymentInformationScreen({Key? key, this.orderDetailsPayment}) : super(key: key);

  @override
  State<paymentInformationScreen> createState() => _shippingAddressScreenState();
}

class _shippingAddressScreenState extends State<paymentInformationScreen> {

  double calculateTotalDiscount(List<LineItemOrder> lineItems) {
    double totalDiscount = 0.0;
    for (var lineItem in lineItems) {
      totalDiscount += lineItem.discountedTotalPrice.amount ?? 0.0;
    }
    return totalDiscount;
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: pageMarginVertical/1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Payment Information:",
              style: context.text.labelMedium?.copyWith(fontSize: 14.5.sp,),),
            14.heightBox,
            Row(
              children: [
                Text("Subtotal",
                  style: context.text.bodyMedium),
                const Spacer(),
                Text(
                  CurrencyController.to.getConvertedPrice(
                      priceAmount: calculateTotalDiscount(widget.orderDetailsPayment!.lineItems!.lineItemOrderList) ?? 0
                  ),
                  style: context.text.bodyMedium),
              ],
            ),
            8.heightBox,
            Row(
              children: [
                Text("Tax",
                  style: context.text.bodyMedium),
                const Spacer(),
                Text(
                  CurrencyController.to.getConvertedPrice(
                      priceAmount: widget.orderDetailsPayment?.totalTaxV2.amount.toDouble() ?? 0
                  ),
                  style: context.text.bodyMedium),
              ],
            ),
            12.heightBox,
            Container(
              color: Colors.grey.shade100,
              padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal/2,vertical: pageMarginVertical/1.5),
              child: Row(
                children: [
                  Text("Total",
                    style: context.text.labelMedium?.copyWith(fontSize: 16.sp),),
                  const Spacer(),
                  Text(
                    CurrencyController.to.getConvertedPrice(
                        priceAmount: widget.orderDetailsPayment!.totalPriceV2.amount
                    ),
                    style: context.text.labelMedium?.copyWith(fontSize: 16.sp),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}