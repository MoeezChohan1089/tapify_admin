import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import '../../api_services/shopify_flutter/models/models.dart';
import '../../custom_widgets/custom_app_bar.dart';
import 'components/billingAddress.dart';
import 'components/orderDetails.dart';
import 'components/orderNote.dart';
import 'components/orders.dart';
import 'components/paymentGateway.dart';
import 'components/shippingAddress.dart';
import 'logic.dart';


class OrderDetialPage extends StatefulWidget {
  Order? orderDetailsMain;
  dynamic trackingStatusValue;
  dynamic trackingStatusURLValue;
  OrderDetialPage({Key? key, this.orderDetailsMain, this.trackingStatusValue, this.trackingStatusURLValue}) : super(key: key);

  @override
  State<OrderDetialPage> createState() => _OrderDetialPageState();
}

class _OrderDetialPageState extends State<OrderDetialPage> {
  final logic = Get.put(OrderLogic());

  final state = Get.find<OrderLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'order detail',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: pageMarginHorizontal
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OrderDetailsScreen(orderDetails: widget.orderDetailsMain!, trackingStatus: widget.trackingStatusValue, trackingStatusURL: widget.trackingStatusURLValue,),
            shippingAddressScreen(orderDetailsShipping: widget.orderDetailsMain,),
            billingAddressScreen(orderDetailsBilling: widget.orderDetailsMain,),
            paymentInformationScreen(orderDetailsPayment: widget.orderDetailsMain,)
          ],
        ),
      ),
    );
  }
}