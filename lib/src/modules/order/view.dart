import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'components/orders.dart';
import 'logic.dart';


class OrderPage extends StatelessWidget {
  final bool navigateToNext;
  OrderPage({Key? key, this.navigateToNext = false}) : super(key: key);


  final logic = Get.put(OrderLogic());
  final state = Get
      .find<OrderLogic>()
      .state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'my orders',
      ),
      body: Obx((){
        return logic.loadingOrders.value
            ? ShimerListviewPage()
            : OrderPageComponent(navigateToNext: navigateToNext,);
      }),
    );
  }
}