import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';

class billingAddressScreen extends StatefulWidget {
  final Order? orderDetailsBilling;
  billingAddressScreen({Key? key, this.orderDetailsBilling}) : super(key: key);

  @override
  State<billingAddressScreen> createState() => _shippingAddressScreenState();
}

class _shippingAddressScreenState extends State<billingAddressScreen> {
  final shippingAddressText = OrderLogic.to;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: pageMarginVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Billing address",
            style: context.text.labelMedium?.copyWith(fontSize: 14.5.sp),),
          8.heightBox,
          widget.orderDetailsBilling!.shippingAddress != null? Text("${widget.orderDetailsBilling?.shippingAddress.address1}",
            style: context.text.bodyMedium?.copyWith(height: 1.2,),):const SizedBox()
        ],
      ),
    );
  }
}