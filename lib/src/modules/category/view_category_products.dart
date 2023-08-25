import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tapify_admin/src/modules/category/logic.dart';
import 'package:tapify_admin/src/modules/home/logic.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_product_Card.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../../utils/global_instances.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'components/sortBottomSheet.dart';
import 'components/view_filters.dart';

class CategoryProducts extends StatefulWidget {
  final String collectionID;
  final String categoryName;

  const CategoryProducts(
      {Key? key, required this.collectionID, required this.categoryName})
      : super(key: key);

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  bool showMoreButton = false;
  final categoryLogic = CategoryLogic.to;
  final reset = Get.find<CategoryLogic>().resetValues();
  final logic1 = Get.put(HomeLogic());
  final RefreshController loadMoreController =
      RefreshController(initialRefresh: false);
  late AnimationController _scaleController;

  // late AnimationController _footerController;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(value: 0.0, vsync: this, upperBound: 1.0);

    loadMoreController.headerMode?.addListener(() {
      if (loadMoreController.headerStatus == RefreshStatus.idle) {
        _scaleController.value = 0.0;
        // _anicontroller.reset();
      } else if (loadMoreController.headerStatus == RefreshStatus.refreshing) {
        // _anicontroller.repeat();
      }
    });
    _scrollController.addListener(() {
      const threshold = 200.0; // Adjust this threshold value as needed

      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - threshold) {
        _loadMoreProducts();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryLogic.resetFilters();
      categoryLogic.productFetchService(
          context: context, id: widget.collectionID, isNewId: true);
    });
  }

  void _loadMoreProducts() async {
    if (categoryLogic.showFilteredProducts.isTrue) {
      categoryLogic.fetchProductBasedOnFilters(context: context);
    } else {
      await categoryLogic.productFetchService(
          context: context, id: widget.collectionID);
    }
    // You might need to handle updating the UI state here if required
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryLogic>(builder: (logic) {
      return Scaffold(
        appBar: CustomAppBar(
          title: widget.categoryName,
        ),
        body: Obx(() {
          return SafeArea(
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(
                    // right: pageMarginHorizontal,
                    // left: pageMarginHorizontal,
                    bottom: pageMarginVertical / 2,
                    // top: pageMarginVertical / 2
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Get.to(() => const CollectionFiltersView(),
                                transition: Transition.downToUp,
                                fullscreenDialog: true,
                                duration: const Duration(milliseconds: 250));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                border: Border(
                              // left: BorderSide(
                              //     color: AppColors.appBordersColor, width: .5),
                              // top: BorderSide(
                              //     color: AppColors.appBordersColor, width: .5),
                              bottom: BorderSide(
                                  color: AppColors.appBordersColor, width: .5),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                logic.selectedFilters.isNotEmpty
                                    ? Row(
                                        children: [
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    AppColors.textFieldBGColor),
                                            child: Center(
                                                child: Text(
                                                    "${logic.selectedFilters.length}")),
                                          ),
                                          15.widthBox,
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                                SvgPicture.asset(Assets.icons.filterIcon,
                                    color: AppColors.appHintColor),
                                8.widthBox,
                                Text(
                                  'Filter',
                                  textAlign: TextAlign.center,
                                  style: context.text.bodyMedium
                                      ?.copyWith(color: AppColors.appHintColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            sortingBottomSheetCollection(
                                context: context, idColl: widget.collectionID);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                              // left: BorderSide(
                              //     color: AppColors.appBordersColor, width: .5),
                              // top: BorderSide(
                              //     color: AppColors.appBordersColor, width: .5),
                              left: BorderSide(
                                  color: AppColors.appBordersColor, width: .5),
                              bottom: BorderSide(
                                  color: AppColors.appBordersColor, width: .5),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.icons.sortIcon,
                                  color: AppColors.appHintColor,
                                ),
                                8.widthBox,
                                Text(
                                  'Sort',
                                  textAlign: TextAlign.center,
                                  style: context.text.bodyMedium?.copyWith(
                                    color: AppColors.appHintColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
              logic.loadingValue.value == true
                  ? Expanded(child: LoadingListPage())
                  : logic.productsFetch.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Assets.images.noResult,
                                  width: 100,
                                ),
                                30.heightBox,
                                Text(
                                  "No Result Found!",
                                  style: context.text.bodyMedium?.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.appTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                8.heightBox,
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 70.w),
                                  child: Text(
                                    "Looks like you haven't added any product to your cart yet!",
                                    textAlign: TextAlign.center,
                                    style: context.text.bodyMedium?.copyWith(
                                      fontSize: 14.sp,
                                      color: AppColors.appHintColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            controller: loadMoreController,
                            header: CustomHeader(
                              refreshStyle: RefreshStyle.Behind,
                              onOffsetChange: (offset) {
                                if (loadMoreController.headerMode?.value !=
                                    RefreshStatus.refreshing) {
                                  _scaleController.value = offset / 80.0;
                                }
                              },
                              builder: (c, m) {
                                return Container(
                                  color:
                                      AppColors.appBordersColor.withOpacity(.5),
                                  alignment: Alignment.center,
                                  child: SpinKitThreeBounce(
                                    color: AppConfig.to.primaryColor.value,
                                    size: 23.0,
                                  ),
                                );
                              },
                            ),
                            footer: CustomFooter(builder:
                                (BuildContext context, LoadStatus? mode) {
                              Widget body;
                              if (mode == LoadStatus.idle) {
                                body = (logic.productsFetch.value.length !=
                                        logic.productsFetch.value.length)
                                    ? Text(logic.showFilteredProducts.isTrue
                                        ? ""
                                        : "Pull Up to Load More")
                                    : Text(logic.showFilteredProducts.isTrue
                                        ? ""
                                        : "No more products");
                              } else if (mode == LoadStatus.loading) {
                                body = Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    10.widthBox,
                                    Text(
                                      "Loading...",
                                      style: context.text.titleMedium?.copyWith(
                                          fontSize: 16.sp,
                                          color:
                                              AppColors.customBlackTextColor),
                                    )
                                  ],
                                );
                              } else if (mode == LoadStatus.failed) {
                                body = Text("Load Failed Click retry!",
                                    style: context.text.titleMedium?.copyWith(
                                        fontSize: 16.sp,
                                        color: AppColors.customBlackTextColor));
                              } else if (mode == LoadStatus.canLoading) {
                                body = Text("Pull Up to Load More",
                                    style: context.text.titleMedium?.copyWith(
                                        fontSize: 16.sp,
                                        color: AppColors.customBlackTextColor));
                              } else {
                                body = Text("No more Data",
                                    style: context.text.titleMedium?.copyWith(
                                        fontSize: 16.sp,
                                        color: AppColors.customBlackTextColor));
                              }
                              return SizedBox(
                                height: 55.0,
                                child: Center(child: body),
                              );
                            }),

                            onRefresh: () async {
                              HapticFeedback.lightImpact();
                              await resetShopify();
                              await AppConfig.to.jsonApiCall();
                              await AppConfig.to
                                  .setupConfigData(isRefreshing: true);
                              logic1.resetCarosal();
                              loadMoreController.refreshCompleted();
                              // await Future.delayed(const Duration(milliseconds: 2000));
                              // log("== calling on refresh =====");
                              //
                              // logic.loadMoreController.refreshCompleted();
                            },
                            onLoading: () async {
                              // await Future.delayed(const Duration(milliseconds: 1000));
                              log("== calling on load =====");

                              if (logic.showFilteredProducts.isTrue) {
                                logic.fetchProductBasedOnFilters(
                                    context: context);
                              } else {
                                await categoryLogic.productFetchService(
                                    context: context, id: widget.collectionID);
                              }

                              loadMoreController.loadComplete();
                            },
                            child: GridView(
                              // controller: _scrollController, // Attach the ScrollController
                              padding: EdgeInsets.only(
                                bottom: pageMarginVertical * 2,
                                right: pageMarginHorizontal,
                                left: pageMarginHorizontal,
                              ),
                              // itemCount: categoryLogic.productsFetch.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: 0.55,
                                childAspectRatio:
                                    AppConfig.to.customizationProductImage[
                                                "chooseImage"] ==
                                            "square"
                                        ? 0.80
                                        : 0.55,
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 25.h,
                              ),
                              children: List.generate(
                                  categoryLogic.productsFetch.length, (index) {
                                return CustomProductCard(
                                  product: categoryLogic.productsFetch[index],
                                );
                              }),
                              // itemBuilder: (context, index) {
                              //   return CustomProductCard(
                              //     product: categoryLogic.productsFetch[index],
                              //   );
                              // }
                            ),
                            // ),
                          ),
                        ),
            ]),
          );
        }),
      );
    });
  }
}
