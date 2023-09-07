// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:tapify_admin/src/custom_widgets/custom_product_bottom_sheet.dart';
// import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
// import 'package:tapify_admin/src/utils/extensions.dart';
// import 'package:vibration/vibration.dart';
//
// import '../../api_services/shopify_flutter/models/models.dart';
// import '../../custom_widgets/customPopupDialogue.dart';
// import '../../custom_widgets/custom_app_bar.dart';
// import '../../custom_widgets/custom_elevated_button.dart';
// import '../../custom_widgets/custom_snackbar.dart';
// import '../../global_controllers/app_config/config_controller.dart';
// import '../../global_controllers/database_controller.dart';
// import '../../utils/constants/assets.dart';
// import '../../utils/global_instances.dart';
// import '../auth/components/custom_button.dart';
// import '../cart/logic.dart';
// import '../cart/view.dart';
// import 'components/addtocartButton.dart';
// import 'components/containerDivider.dart';
// import 'components/free_shipping_box.dart';
// import 'components/notify_me.dart';
// import 'components/products_images_carousel.dart';
// import 'components/quantity_control.dart';
// import 'components/recently_view.dart';
// import 'components/recommended_products.dart';
// import 'components/reviews.dart';
// import 'components/selectColor.dart';
// import 'components/variants_selector.dart';
// import 'components/size_and_color_dropdown.dart';
// import 'components/title_and_price.dart';
// import 'logic.dart';
//
// class ProductDetailPage extends StatefulWidget {
//   final String productId;
//   String? collectionIDFromProduct;
//   final bool isFromCart;
//
//   ProductDetailPage({Key? key,
//     required this.productId,
//     this.collectionIDFromProduct,
//     this.isFromCart = false})
//       : super(key: key);
//
//   @override
//   State<ProductDetailPage> createState() => _ProductDetailPageState();
// }
//
// class _ProductDetailPageState extends State<ProductDetailPage> {
//   // PanelController controller = PanelController();
//   final logic = Get.put(ProductDetailLogic());
//   final state = Get
//       .find<ProductDetailLogic>()
//       .state;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       logic.getProductDetailAPICall(
//           context: context,
//           productId: widget.productId,
//           isCartProductId: widget.isFromCart,
//          isViewingDetails: true
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'product detail',
//         showBack: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ProductImagesCarousel(),
//             TitleAndPrice(),
//             const VariantsSelector(),
//             QuantityControl(),
//             NotifyMeSection(),
//             // CartButton(title: "ADD TO CART",),
//
//             // Padding(
//             //   padding: EdgeInsets.symmetric(
//             //       horizontal: pageMarginHorizontal,
//             //     vertical: pageMarginVertical / 4
//             //   ),
//             //   child: AuthBlackButton(
//             //     buttonTitle: "ADD TO CART",
//             //     onPressed: () {
//             //       Vibration.vibrate(duration: 100);
//             //
//             //       ProductDetailLogic.to.addProductToCart();
//             //       if(ProductDetailLogic.to.product?.productVariants[ProductDetailLogic.to.selectedVariantIndex.value].id != null){
//             //         addToCartDialogue(context: context);
//             //       }
//             //     },
//             //   ),
//             // ),
//
//             const ContainerDivider(),
//             ReviewList(),
//             // 22.heightBox,
//             // EnjoyFreeShipping(),
//             25.heightBox,
//             RecommendedProducts(),
//             25.heightBox,
//             RecentlyViewProduct(),
//             // RecommendedProducts(collectionID: widget.collectionIDFromProduct ?? "",),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Obx(() {
//         return logic.product == null ? const SizedBox.shrink() : SafeArea(
//           child: SizedBox(
//             height: 60.h,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: pageMarginHorizontal,
//                   vertical: pageMarginVertical / 2),
//               child: GlobalElevatedButton(
//                   text: logic.product?.productVariants[logic.selectedVariantIndex
//                       .value].availableForSale == true
//                       ? (AppConfig.to.appSettingsCartAndCheckout["navigationCustomers"] == true) ? "Buy Now" : "add to cart"
//                       : "Out of Stock"
//                   ,
//                   onPressed: () {
//                     HapticFeedback.lightImpact();
//
//
//                     if(logic.product!.productVariants[logic.selectedVariantIndex.value].availableForSale == true) {
//                       if(logic.product!.productVariants[logic.selectedVariantIndex.value].quantityAvailable > 0) {
//
//
//
//
//
//
//
//                         if(logic.productQuantity.value < logic.product!.productVariants[logic.selectedVariantIndex.value].quantityAvailable) {
//                           if(CartLogic.to.checkFromCart(logic.product!.productVariants[logic.selectedVariantIndex.value].quantityAvailable ,logic.productQuantity.value, logic.product!.productVariants[logic.selectedVariantIndex.value].id)) {
//                             logic.quickBottomSheet.value = 'details';
//                             ProductDetailLogic.to.isProcessing.value = true;
//                             ProductDetailLogic.to.addProductToCart(context);
//                           } else {
//                             showToastMessage(message:
//                             "You have already added the max available in cart"
//                             );
//                           }
//                         } else {
//                           showToastMessage(message:
//                           "Whoa there! Maximum quantity reached. Try fewer items or save some for others! 😊"
//                           );
//                         }
//                       } else {
//                           logic.quickBottomSheet.value = 'details';
//                           ProductDetailLogic.to.isProcessing.value = true;
//                           ProductDetailLogic.to.addProductToCart(context);
//                       }
//                     }
//
//
//
//
//
//
//
//                   },
//                   isLoading: ProductDetailLogic.to.isProcessing.value,
//                   isDisable:
//                   logic.product?.productVariants[logic.selectedVariantIndex
//                       .value].availableForSale == true ? false : true
//                   ,
//                 )
//
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
// // _settingModalBottomSheet(context) {
// //   // TextEditingController _controller = new TextEditingController();
// //   showModalBottomSheet(
// //       backgroundColor: Colors.transparent,
// //       elevation: 0.0,
// //       context: context,
// //       builder: (BuildContext bc) {
// //         return StatefulBuilder(
// //             builder: (context, setState){
// //               return SingleChildScrollView(
// //                 child: Column(
// //                   children:  [
// //                     ProductImagesCarousel(),
// //                     TitleAndPrice(),
// //                     SizeDropDown(),
// //                     SelectColor(),
// //                     CartButton(),
// //                     QuantityControl(),
// //                     ContainerDivider(),
// //                     ReviewList(),
// //                     22.heightBox,
// //                     EnjoyShipping(),
// //                     RecommendedProducts(),
// //                   ],
// //                 ),
// //               );
// //             });
// //       });
// // }
// }