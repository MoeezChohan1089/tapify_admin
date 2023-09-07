import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tapify_admin/src/modules/search/components/sort_options_sheet.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../api_services/shopify_flutter/models/models.dart';
import '../../../custom_widgets/customPopupDialogue.dart';
import '../../../custom_widgets/custom_product_Card.dart';
import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/assets.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../../utils/home_widgets_stylings.dart';
import '../../../utils/quickViewBottomSheet.dart';
import '../../../utils/skeleton_loaders/shimmerLoader.dart';
import '../../cart/components/discountCodeDialogue.dart';
import '../../cart/logic.dart';
import '../../product_detail/logic.dart';
import '../../product_detail/view.dart';
import '../../wishlist/logic.dart';
import '../logic.dart';

class SearchedResult extends StatefulWidget {
  const SearchedResult({Key? key}) : super(key: key);

  @override
  State<SearchedResult> createState() => _SearchedResultState();
}

class _SearchedResultState extends State<SearchedResult> {
  final searchLogic = SearchLogic.to;

  // ScrollController for the GridView
  // ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     searchLogic.getPaginatedSearchProducts();
    //   }
    // });
  }

  @override
  void dispose() {
    // scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return GetBuilder<SearchLogic>(builder: (logic) {
      return Expanded(
        child: SafeArea(
          child: Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  sortingBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.appBordersColor,
                          width: .5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.icons.sortIcon,
                          color: AppColors.appHintColor
                      ),
                      8.widthBox,
                      Text(
                        'Sort',
                        textAlign: TextAlign.center,
                        style: context.text.bodyMedium?.copyWith(
                            color: AppColors.appHintColor
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.heightBox,
              Expanded(
                child: SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  footer: CustomFooter(
                      builder: (BuildContext context,LoadStatus? mode){
                        Widget body ;
                        if(mode==LoadStatus.idle){
                          body =  (logic.searchResultProducts.value.length != logic.searchResultProducts.value.length) ? Text("Pull Up to Load More"):Text("No more products");

                        }
                        else if(mode==LoadStatus.loading){
                          body =  Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 2,
                              ),
                            ),
                              10.widthBox,
                              Text("Loading...", style: context.text.titleMedium?.copyWith(fontSize: 16.sp, color: AppColors.customBlackTextColor),)],
                          );
                        }
                        else if(mode == LoadStatus.failed){
                          body = Text("Load Failed Click retry!", style: context.text.titleMedium?.copyWith(fontSize: 16.sp, color: AppColors.customBlackTextColor));
                        }
                        else if(mode == LoadStatus.canLoading){
                          body = Text("Pull Up to Load More",style: context.text.titleMedium?.copyWith(fontSize: 16.sp, color: AppColors.customBlackTextColor));
                        }
                        else{
                          body = Text("No more Data", style: context.text.titleMedium?.copyWith(fontSize: 16.sp, color: AppColors.customBlackTextColor));
                        }
                        return SizedBox(
                          height: 55.0,
                          child: Center(child:body),
                        );
                      }),
                  controller: logic.loadMoreController,
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 2000));
                    log("== calling on refresh =====");

                    logic.loadMoreController.refreshCompleted();
                  },
                  onLoading: () async {
                    // await Future.delayed(const Duration(milliseconds: 1000));
                    log("== calling on load =====");
                    await searchLogic.getPaginatedSearchProducts();
                    logic.loadMoreController.loadComplete();
                  },
                  child: GridView(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.only(
                        bottom: pageMarginVertical * 2,
                        right: pageMarginHorizontal,
                        left: pageMarginHorizontal,
                        // vertical: pageMarginVertical * 1.5,
                      ),
                      // itemCount: searchLogic.searchedProducts.length,
                    physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: AppConfig.to.customizationProductImage["chooseImage"] == "square" ?  0.80 : 0.55,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 25.h,
                      ),

                    children: List.generate(searchLogic.searchedProducts.length, (index) {
                      return CustomProductCard(
                        product: searchLogic.searchedProducts[index],
                      );

                    }),

                      // itemBuilder: (context, index) {
                      //   return CustomProductCard(
                      //     product: searchLogic
                      //         .searchedProducts[index],
                      //   );
                      //
                      // }
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    });
    // });
  }
}