import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tapify_admin/src/custom_widgets/custom_product_bottom_sheet.dart';

// import 'package:shopify_flutter/models/src/checkout/line_item/line_item.dart';
import 'package:tapify_admin/src/modules/cart/logic.dart';
import 'package:tapify_admin/src/modules/home/models/product_info_model.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:tapify_admin/src/utils/skeleton_loaders/shimmerLoader.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../api_services/shopify_flutter/models/src/checkout/line_item/line_item.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../custom_widgets/loader_pulse.dart';
import '../../../global_controllers/currency_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/quickViewBottomSheet.dart';
import '../../product_detail/view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({Key? key}) : super(key: key);


  shareItem(dynamic item) async {
    await Share.share("${item!.title}");
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartLogic>(builder: (cartLogic) {

      bool isStockUpdated = false;


      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(cartLogic.currentCart?.lineItems.length ?? 0,
                (index) {
              final item = cartLogic.currentCart?.lineItems[index];

              print("product variants at index => $index is => ${item!.variant!.product!.productVariants.length}");
              print("quantity available is ${item.variant?.quantityAvailable}");
              print("quantity available is ${item.variant?.quantityAvailable}");
              print("available is ${item.variant?.availableForSale}");
              print("id is ${item.variant?.id}");
              print("sku is ${item.variant?.sku}");
              print("discounted price is ${item.variant?.compareAtPrice?.formattedPrice}");

              // isStockUpdated = item.variant!.quantityAvailable >= 1 ? true : false;


              ///------ Implement the Cart Item Stock Update Function
              if(item.variant?.availableForSale == true && item.variant!.quantityAvailable > 0) {
                if(item.quantity > item.variant!.quantityAvailable){
                  cartLogic.updateProductQuantity(
                    context: context,
                    lineItem: LineItem(
                      id: item.id,
                      variantId: item.variantId,
                      quantity: item.variant!.quantityAvailable,
                      title: item.title,
                      discountAllocations: [],
                    ),
                  );
                  isStockUpdated = true;
                }

              }



              return GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  cartLogic.currentItemIndex.value = index;
                  ProductSheet.to.productDetailBottomSheet(context: context, fetchProductDetail: true,
                      fromCartPage: true,
                      productInfo: ProductInfo(id: item.variant!.product!.id, title: item.title, price: 0.0, availableForSale: false ,compareAtPrice: 0.0, webUrl: "",
                        image: item.variant?.image?.originalSrc
                            .isNotEmpty !=
                            null
                            ? item.variant!.image!.originalSrc
                            : "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                      )
                  );
                },
                child: Column(
                  children: [
                    Slidable(
                      closeOnScroll: true,
                      // startActionPane: ActionPane(
                      //   // A motion is a widget used to control how the pane animates.
                      //   motion: const ScrollMotion(),
                      //
                      //   // A pane can dismiss the Slidable.
                      //   dismissible: DismissiblePane(onDismissed: () {}),
                      //
                      //   // All actions are defined in the children parameter.
                      //   children: const [
                      //     // A SlidableAction can have an icon and/or a label.
                      //     SlidableAction(
                      //       onPressed: doNothing,
                      //       backgroundColor: Color(0xFFFE4A49),
                      //       foregroundColor: Colors.white,
                      //       icon: Icons.delete,
                      //       label: 'Delete',
                      //     ),
                      //     SlidableAction(
                      //       onPressed: doNothing,
                      //       backgroundColor: Color(0xFF21B7CA),
                      //       foregroundColor: Colors.white,
                      //       icon: Icons.share,
                      //       label: 'Share',
                      //     ),
                      //   ],
                      // ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane:  ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //
                          //     cartLogic.isProcessing.value = true;
                          //
                          //     cartLogic.removeFromCart(
                          //       lineItem: LineItem(
                          //         title: item!.title,
                          //         quantity: 0,
                          //         id: item.id,
                          //         discountAllocations: [],
                          //       ),
                          //     );
                          //   },
                          //   borderRadius:
                          //   BorderRadius.circular(100),
                          //   child: Container(
                          //     // height: 25,
                          //     width: 50,
                          //     padding: const EdgeInsets.all(4),
                          //     decoration: const BoxDecoration(
                          //       // shape: BoxShape.circle,
                          //       color: AppColors.textFieldBGColor
                          //     ),
                          //     child: SvgPicture.asset(
                          //         Assets.icons.deleteIcon,
                          //      color: AppColors.appPriceRedColor,
                          //     ),
                          //   ),
                          // ),


                          SlidableAction(
                            onPressed: (context) => {
                              cartLogic.isProcessing.value = true,
                              cartLogic.removeFromCart(
                                lineItem: LineItem(
                                  title: item!.title,
                                  quantity: 0,
                                  id: item.id,
                                  discountAllocations: [],
                                ),
                              )

                            },
                            backgroundColor: AppColors.textFieldBGColor,
                            foregroundColor: AppColors.appPriceRedColor,
                            icon: Icons.delete,
                            flex: 2,
                            // label: 'Archive',
                          ),

                        ],
                      ),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: pageMarginHorizontal,
                              vertical: pageMarginVertical / 1.5),
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 105.h,
                                    height: 105.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3.r),
                                      child: CachedNetworkImage(
                                          imageUrl: "${item.variant!.image!.originalSrc.split("?v=")[0]}?width=300}",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              productShimmer(),
                                          errorWidget:
                                              (context, url, error) =>
                                              Center(
                                                child: SvgPicture.asset(Assets.icons.noImageIcon,
                                                  height: 24.h,
                                                ),
                                              )
                                      ),
                                    ),
                                  ),
                                  13.widthBox,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.variant?.product?.vendor ?? "",
                                          style: context.text.bodySmall?.copyWith(
                                              color: AppColors.appHintColor,
                                              fontSize: 10.sp
                                          ),
                                        ),
                                        2.heightBox,

                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    // "hi how are you this is dummy text with multi line",
                                                      item.title,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: context.text.bodyMedium?.copyWith(
                                                          height: 1.2
                                                      )),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),











                                        2.heightBox,
                                        item.variant?.title != "Default Title"
                                            ? Text(
                                          item.variant?.title ?? "",
                                          style: context.text.bodySmall!
                                              .copyWith(
                                              fontSize: 13.sp,
                                              color:
                                              AppColors.appHintColor),
                                        )
                                            : const SizedBox(),
                                        8.heightBox,

                                        Row(
                                          children: [
                                            Text(
                                              item.variant!.priceV2!.amount == 0 ? "FREE" : CurrencyController.to.getConvertedPrice(
                                                  priceAmount: item.variant!.priceV2!.amount),
                                              maxLines: 1,
                                              // overflow: TextOverflow.ellipsis,
                                              style: context.text.bodyMedium?.copyWith(
                                                  color: item.variant?.compareAtPrice?.amount != null
                                                      ? AppColors.appPriceRedColor
                                                      : AppColors.appTextColor,
                                                  letterSpacing: .01,
                                                  height: .5),
                                            ),
                                            item.variant?.compareAtPrice?.amount != null
                                                ? Row(
                                              children: [
                                                4.widthBox,
                                                Text(
                                                  CurrencyController.to.getConvertedPrice(
                                                      priceAmount: item
                                                          .variant
                                                          ?.compareAtPrice
                                                          ?.amount ??
                                                          0,
                                                      includeSign: false),
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  style: context.text.bodySmall?.copyWith(
                                                      color: AppColors.appHintColor,
                                                      fontSize: 11.sp,
                                                      height: .5,
                                                      decoration:
                                                      TextDecoration.lineThrough),
                                                ),
                                              ],
                                            )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  3.widthBox,

                                  InkWell(
                                    onTap: () {

                                      cartLogic.isProcessing.value = true;

                                      cartLogic.removeFromCart(
                                        lineItem: LineItem(
                                          title: item.title,
                                          quantity: 0,
                                          id: item.id,
                                          discountAllocations: [],
                                        ),
                                      );
                                    },
                                    borderRadius:
                                    BorderRadius.circular(100),
                                    child: Container(
                                      height: 24,
                                      width: 24,
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          Assets.icons.deleteIcon),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: item.variant?.availableForSale == false ? Container(
                                  padding: EdgeInsets.only(
                                      top: 6.h,
                                      bottom: 4.h,
                                      left: 8.w,
                                      right: 8.w
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(.15),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                  child: Text("Out of Stock",
                                    style: context.text.bodySmall?.copyWith(
                                        color: Colors.red,
                                        height: 1
                                      // fontSize: 11.sp
                                    ),
                                  ),
                                ) :
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    isStockUpdated ?    Container(
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
                                      child: Text("Stock Updated",
                                        style: context.text.bodySmall?.copyWith(
                                            color: Colors.blue,
                                            height: 1
                                          // fontSize: 11.sp
                                        ),
                                      ),
                                    ) : const SizedBox.shrink(),
                                    20.widthBox,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            if (item.quantity > 1) {
                                              if (cartLogic.isProcessing.value ==
                                                  false) {
                                                cartLogic.isProcessing.value = true;

                                                cartLogic.updateProductQuantity(
                                                  context: context,
                                                  lineItem: LineItem(
                                                    id: item.id,
                                                    variantId: item.variantId,
                                                    quantity: item.quantity - 1,
                                                    title: item.title,
                                                    discountAllocations: [],
                                                  ),
                                                );
                                              }
                                            } else {
                                              cartLogic.isProcessing.value = true;

                                              cartLogic.removeFromCart(
                                                lineItem: LineItem(
                                                  title: item.title,
                                                  quantity: 0,
                                                  id: item.id,
                                                  discountAllocations: [],
                                                ),
                                              );


                                            }
                                          },
                                          borderRadius: BorderRadius.circular(100.r),
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Icon(
                                              Icons.remove,
                                              color: AppColors.appHintColor,
                                              size: 22.sp,
                                            ),
                                          ),
                                        ),
                                        6.widthBox,
                                        SizedBox(
                                          width: pageMarginHorizontal * 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(3),
                                                color: AppColors.textFieldBGColor),
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Text(
                                                item.quantity.toString(),
                                                textAlign: TextAlign.center,
                                                style: context.text.bodyLarge
                                                    ?.copyWith(fontSize: 18.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        6.widthBox,
                                        InkWell(
                                          onTap: () {

                                            print("current item quantity is ${item.quantity} :: and available quantity is ${item.variant!.quantityAvailable}");


                                            HapticFeedback.lightImpact();
                                            if (cartLogic.isProcessing.value ==
                                                false) {
                                              cartLogic.isProcessing.value = true;
                                              if(item.variant?.availableForSale == true) {
                                                if(item.variant!.quantityAvailable > 0) {
                                                  if(item.quantity < item.variant!.quantityAvailable) {
                                                    cartLogic.updateProductQuantity(
                                                      context: context,
                                                      lineItem: LineItem(
                                                        id: item.id,
                                                        variantId: item.variantId,
                                                        quantity: item.quantity + 1,
                                                        title: item.title,
                                                        discountAllocations: [],
                                                      ),
                                                    );
                                                  } else {
                                                    showToastMessage(message: "Whoa! Currently ${item.variant!.quantityAvailable} available.");
                                                    cartLogic.isProcessing.value = false;
                                                  }
                                                } else {
                                                  cartLogic.updateProductQuantity(
                                                    context: context,
                                                    lineItem: LineItem(
                                                      id: item.id,
                                                      variantId: item.variantId,
                                                      quantity: item.quantity + 1,
                                                      title: item.title,
                                                      discountAllocations: [],
                                                    ),
                                                  );
                                                }
                                              }
                                            }
                                          },
                                          borderRadius: BorderRadius.circular(100.r),
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.appHintColor,
                                              size: 22.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.appBordersColor,
                      thickness: .5,
                    ),
                  ],
                ),
              );
            }),
      );
    });
  }
}