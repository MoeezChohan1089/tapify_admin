import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../global_controllers/currency_controller.dart';
import '../../../global_controllers/database_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../auth/view.dart';
import '../logic.dart';
import '../view2.dart';

class OrderPageComponent extends StatefulWidget {
  final bool navigateToNext;

  OrderPageComponent({Key? key, required this.navigateToNext})
      : super(key: key);

  @override
  State<OrderPageComponent> createState() => _OrderPageComponentState();
}

class _OrderPageComponentState extends State<OrderPageComponent> {
  final ordersListLogic = Get.put(OrderLogic());
  final logic = Get.find<OrderLogic>();
  bool _initialized = false;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    print("bool value detail: ${widget.navigateToNext}");
    if (widget.navigateToNext == true) {
      Future.delayed(Duration(milliseconds: 250), () {
        Get.to(() => OrderDetialPage(
              orderDetailsMain: logic.userOrdersList.first,
            ));
      });
    } else {
      null;
    }
    // });

    if (widget.navigateToNext == true) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (LocalDatabase.to.box.read("customerAccessToken") != null)
        ? GetBuilder<OrderLogic>(builder: (ordersListLogic) {
            return SingleChildScrollView(
              child: ordersListLogic.userOrdersList.isNotEmpty
                  ? Column(
                      children: List.generate(
                          ordersListLogic.userOrdersList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            var successfulFulfillments = ordersListLogic
                                .userOrdersList[index].successfulFulfillments;

                            if (successfulFulfillments != null &&
                                successfulFulfillments.isNotEmpty) {
                              var trackingStatus =
                                  successfulFulfillments[0].trackingInfo;
                              if (trackingStatus != null &&
                                  trackingStatus.isNotEmpty) {
                                var trackingStatusValue =
                                    trackingStatus[0].number;
                                var trackingStatusURLValue =
                                    trackingStatus[0].url;

                                print("tracking no: $trackingStatusValue");

                                ordersListLogic.getOrdersService();
                                Get.to(() => OrderDetialPage(
                                      orderDetailsMain:
                                          ordersListLogic.userOrdersList[index],
                                      trackingStatusValue: trackingStatusValue,
                                      trackingStatusURLValue:
                                          trackingStatusURLValue,
                                    ));
                              } else {
                                ordersListLogic.getOrdersService();
                                Get.to(() => OrderDetialPage(
                                      orderDetailsMain:
                                          ordersListLogic.userOrdersList[index],
                                    ));
                              }
                            } else {
                              ordersListLogic.getOrdersService();
                              Get.to(() => OrderDetialPage(
                                    orderDetailsMain:
                                        ordersListLogic.userOrdersList[index],
                                  ));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: pageMarginHorizontal / 1.5,
                                vertical: pageMarginVertical / 1.5),
                            decoration: const BoxDecoration(
                                color: AppColors.customWhiteTextColor,
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.textFieldBGColor,
                                        width: 1))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 90.h,
                                  height: 90.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.r),
                                    child: FadeInImage.memoryNetwork(
                                      image: ordersListLogic
                                                  .userOrdersList[index]
                                                  .lineItems!
                                                  .lineItemOrderList[0]
                                                  .variant
                                                  ?.image
                                                  ?.originalSrc !=
                                              null
                                          ? "${ordersListLogic.userOrdersList[index].lineItems!.lineItemOrderList[0].variant?.image?.originalSrc.split("?v=")[0]}?width=300"
                                          : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                                      fit: BoxFit.cover,
                                      placeholder: kTransparentImage,
                                      imageErrorBuilder:
                                          (context, url, error) => Container(
                                        // color: Colors.,
                                        color: Colors.grey.shade200,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            Assets.icons.noImageIcon,
                                            height: 25.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                16.widthBox,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "#${ordersListLogic.userOrdersList[index].orderNumber}",
                                      style: context.text.bodySmall?.copyWith(
                                          color: AppColors.appHintColor,
                                          fontSize: 12.sp),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                          ordersListLogic
                                              .userOrdersList[index]
                                              .lineItems!
                                              .lineItemOrderList[0]
                                              .title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.text.bodyMedium),
                                    ),
                                    Text(
                                      CurrencyController.to.getConvertedPrice(
                                          priceAmount: ordersListLogic
                                                  .userOrdersList[index]
                                                  .totalPriceV2
                                                  .amount ??
                                              0),
                                      style: context.text.labelMedium?.copyWith(
                                          color: AppColors.appTextColor,
                                          fontSize: 14.sp),
                                    ),
                                    Text(
                                      "Quantity: ${ordersListLogic.userOrdersList[index].lineItems!.lineItemOrderList[0].quantity}",
                                      style: context.text.bodySmall?.copyWith(
                                          color: AppColors.appHintColor),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    20.heightBox,
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 18,
                                    ),
                                    16.heightBox,
                                    Text(
                                        "${ordersListLogic.userOrdersList[index].financialStatus}",
                                        style: context.text.bodySmall),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  : SizedBox(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height - 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/no_order.png"),
                          20.heightBox,
                          Text(
                            "No Order Placed!",
                            style: context.text.labelMedium?.copyWith(
                                color: AppColors.appTextColor, fontSize: 16.sp),
                          ),
                          Text(
                            "Looks like you haven't place any order yet.",
                            style: context.text.bodyMedium?.copyWith(
                              color: AppColors.appHintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          })
        : Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Go to Sign in",
                style: context.text.labelMedium?.copyWith(fontSize: 16.sp),
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                    onPressed: () async {
                      // Vibration.vibrate(duration: 100);
                      HapticFeedback.lightImpact();
                      Get.to(() => const AuthPage(),
                          transition: Transition.downToUp,
                          fullscreenDialog: true,
                          duration: const Duration(milliseconds: 250));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      // Set the text color of the button
                      padding: const EdgeInsets.all(8),
                      // Set the padding around the button content
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            0), // Set the border radius of the button
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: context.text.bodyMedium!
                          .copyWith(color: Colors.white, height: 1.1),
                    )),
              ),
            ],
          ));
  }
}
