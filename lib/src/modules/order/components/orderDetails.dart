import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/modules/order/components/showBottom.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../custom_widgets/product_viewer_web.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../global_controllers/reviews/reviews_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../product_detail/logic.dart';
import '../logic.dart';
import 'customtimeLine.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order orderDetails;
  dynamic trackingStatus;
  dynamic trackingStatusURL;

  OrderDetailsScreen({Key? key, required this.orderDetails, this.trackingStatus, this.trackingStatusURL}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final ordersListLogic1 = OrderLogic.to;
  final logicRating = Get.put(ProductDetailLogic());




  @override
  Widget build(BuildContext context) {
    List<String> proceedDate = widget.orderDetails.processedAt!.split('T');

    // print("value of TrackingID: ${widget.orderDetails.successfulFulfillments?[0].trackingInfo?[0].number ?? 0}");
    // print("value of TrackingID: ${widget.orderDetails.successfulFulfillments?[0].trackingCompany ?? 0}");
    String proceedDateSplit = proceedDate[0];

    DateTime parsedDate = DateTime.parse(proceedDateSplit);
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: pageMarginVertical / 3),
      // padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children:
            List.generate(
                widget.orderDetails.lineItems!.lineItemOrderList.length, (
                index) {
              return Container(
                padding: EdgeInsets.symmetric(
                    vertical: pageMarginVertical / 1.5),
                decoration: const BoxDecoration(
                    color: AppColors.customWhiteTextColor,
                    border: Border(
                        bottom: BorderSide(color: AppColors.textFieldBGColor))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 85.h,
                      height: 85.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child:
                        ExtendedImage.network(
                          widget.orderDetails.lineItems!
                              .lineItemOrderList[index].variant?.image
                              ?.originalSrc != null
                              ? "${widget.orderDetails
                              .lineItems!.lineItemOrderList[index].variant?.image
                              ?.originalSrc.split("?v=")[0]}?width=300"
                              : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                          fit: BoxFit.cover,
                          cache: true,
                          loadStateChanged: (ExtendedImageState state) {
                            switch (state.extendedImageLoadState) {
                              case LoadState.loading:
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 85.h,
                                    height: 85.h,
                                    color: Colors.grey[300],
                                  ),
                                );
                              case LoadState.completed:
                                return null; //return null, so it continues to display the loaded image
                              case LoadState.failed:
                                return Container(
                            // color: Colors.,
                            color: Colors.grey.shade200,
                            child: Center(
                            child: SvgPicture.asset(Assets.icons.noImageIcon,
                            height: 25.h,
                            ),
                            ),
                            );
                              default:
                                return null;
                            }
                          },
                        )
                      ),
                    ),
                    16.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [


                          SizedBox(
                            // width: 150.w,
                            child: Text(widget.orderDetails.lineItems!
                                .lineItemOrderList[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.text.bodyMedium),
                          ),

                          Text(
                            CurrencyController.to.getConvertedPrice(
                                priceAmount: widget.orderDetails.lineItems!
                                    .lineItemOrderList[index].originalTotalPrice
                                    .amount ?? 0
                            ),
                            style: context.text.labelMedium?.copyWith(
                                fontSize: 14.sp),),

                          2.heightBox,

                          widget.orderDetails.lineItems!.lineItemOrderList[index]
                              .variant!.title == null
                              ? Container()
                              : widget.orderDetails.lineItems!
                              .lineItemOrderList[index].variant!.title ==
                              "Default Title"
                              ? Container()
                              : SizedBox(
                            // width: 150,
                            child: Text(
                              widget.orderDetails.lineItems!
                                  .lineItemOrderList[index].variant!.title!,
                              style: context.text.bodySmall?.copyWith(
                                  color: AppColors.customBlackTextColor,
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),
2.heightBox,
                          Row(
                            children: [
                              Text("Quantity: ${widget.orderDetails
                                  .lineItems!.lineItemOrderList[index].quantity}",
                                style: context.text.titleMedium?.copyWith(
                                  color: AppColors.appHintColor, fontSize: 12.sp,),),
                              const Spacer(),
                              SizedBox(
                                // height: 85,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // 20.heightBox,
                                    // // Icon(Icons.arrow_forward_ios, size: 18,),
                                    // 16.heightBox,
                                    GetBuilder<ReviewsListController>(
                                      builder: (reviewsLogic) {
                                        List<String> idSplitReview = widget.orderDetails.lineItems!.lineItemOrderList[index].variant!.product!.id.split('/');
                                        String productId = idSplitReview.last;

                                        double productReview = reviewsLogic.checkUserReview(productId, widget.orderDetails.orderNumber);

                                        print("value of item rating: ${logicRating.productReviews
                                            .value['review_count']}");
                                        return productReview != 0.0 ? RatingBar.builder(
                                          ignoreGestures: true,
                                          itemSize: 18.sp,
                                          initialRating: productReview,
                                          // initialRating: double.parse(reviewsLogic.filteredReviews[0]['rating'].toString()),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0,
                                          ),
                                          itemBuilder: (context, _) =>
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              // _rating = rating;
                                            });
                                          },
                                        ) : GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            double rating = 0.0;
                                            List<String> idSplit = widget.orderDetails.lineItems!.lineItemOrderList[index].variant!.id!.split('/');
                                            List<String> idSplitProduct = widget.orderDetails.lineItems!.lineItemOrderList[index].variant!.product!.id.split('/');
                                            productRatingBottomSheet(context, rating, idSplitProduct.last, widget.orderDetails.orderNumber!, widget.orderDetails.email!);
                                          },
                                          child: Text(
                                            "Rate this item",
                                            style: context.text.titleMedium?.copyWith(
                                              color: AppColors.customTimeLineColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      },
                                    )

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            }

            ),
          ),
          10.heightBox,
          Text("Order Status",
            style: context.text.labelMedium?.copyWith(
                fontSize: 14.5.sp),),
          20.heightBox,
          // FixedTimeline.tileBuilder(
          //   theme: TimelineThemeData(color: Color(0xff53A653), connectorTheme: ConnectorThemeData(color: Color(0xff53A653)), indicatorTheme: IndicatorThemeData(color: Color(0xff53A653))),
          //   builder: TimelineTileBuilder.connectedFromStyle(
          //     contentsAlign: ContentsAlign.basic,
          //     contentsBuilder: (context, index) => Padding(
          //       padding: const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 20),
          //       child: index == 0? Text('Order Placed'): index == 1? Text('In Progress'): index == 3? Text('Shipped'): Text('Delivered'),
          //     ),
          //
          //     connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
          //     indicatorStyleBuilder: (context, index) => index == 0? IndicatorStyle.dot:IndicatorStyle.outlined,
          //     itemCount: 4,
          //   ),
          // )
          SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(child: PackageDeliveryTrackingPage(indexState: widget.orderDetails.fulfillmentStatus,)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Order Date: ",
                            style: context.text.titleMedium?.copyWith(
                              color: AppColors.appHintColor,
                              fontSize: 12.sp,),),
                          Text("${formattedDate}",
                            style: context.text.titleMedium?.copyWith(
                              color: AppColors.appTextColor,
                              fontSize: 12.sp,),),

                        ],
                      ),
                      10.heightBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Order No: ",
                            style: context.text.titleMedium?.copyWith(
                              color: AppColors.appHintColor,
                              fontSize: 12.sp,),),
                          Text("#${widget.orderDetails.orderNumber}",
                            style: context.text.titleMedium?.copyWith(
                              color: AppColors.appTextColor,
                              fontSize: 12.sp,),),

                        ],
                      ),
                      10.heightBox,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Amount:  ",
                            style: context.text.titleMedium?.copyWith(
                              color: AppColors.appHintColor,
                              fontSize: 12.sp,),),
                          Text(
                            CurrencyController.to.getConvertedPrice(
                                priceAmount: widget.orderDetails.totalPriceV2
                                    .amount ?? 0
                            ),
                            style: context.text.titleMedium?.copyWith(
                              color: AppColors.appTextColor,
                              fontSize: 12.sp,),),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          15.heightBox,
        widget.orderDetails.fulfillmentStatus == "FULFILLED" && widget.trackingStatus != null && widget.trackingStatusURL != null?  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Tracking Order",
                style: context.text.labelMedium?.copyWith(
                    fontSize: 14.5.sp,),),
              // 20.heightBox,
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                          Text("Tracking ID: ${widget.trackingStatus}",
                    style: context.text.titleMedium?.copyWith(fontSize: 14.sp),),
                   GestureDetector(
                    onTap: (){
                      // launch(widget.trackingStatusURL);
                      Get.to(() => WebViewProduct(
                        productUrl: widget.trackingStatusURL,
                      ), opaque: false, transition: Transition.native);
                    },
                    child: Container(
                      margin:  EdgeInsets.only(bottom: 4.h),
                      padding: EdgeInsets.only(
                          top: 6.h,
                          bottom: 4.h,
                          left: 8.w,
                          right: 8.w
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.15),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      child: Text("Track Order",
                        style: context.text.bodySmall?.copyWith(
                            color: Colors.blue,
                            height: 1
                          // fontSize: 11.sp
                        ),
                      ),
                    ),
                  )
                ],
              ),
              20.heightBox,
            ],
          ):const SizedBox.shrink(),
          Text("Order confirmation sent to",
            style: context.text.labelMedium?.copyWith(
                fontSize: 14.5.sp,),),
          Text("${widget.orderDetails.email}",
            style: context.text.titleMedium?.copyWith(
                color: AppColors.customEmailColor, fontSize: 14.sp),),

        ],
      ),
    );
  }


}