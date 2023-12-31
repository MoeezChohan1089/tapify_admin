import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/modules/category/view_2.dart';
import 'package:tapify_admin/src/modules/category/view_category_products.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:extended_image/extended_image.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../../utils/global_instances.dart';
import '../home/logic.dart';
import 'logic.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin
    , AutomaticKeepAliveClientMixin<CategoryPage>
{
  final logic = Get.put(CategoryLogic());

  final state = Get.find<CategoryLogic>().state;

  final appConfig = AppConfig.to;
  late AnimationController _scaleController;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scaleController =
        AnimationController(value: 0.0, vsync: this, upperBound: 1.0);
    _refreshController.headerMode?.addListener(() {
      if (_refreshController.headerStatus == RefreshStatus.idle) {
        _scaleController.value = 0.0;
      } else if (_refreshController.headerStatus == RefreshStatus.refreshing) {}
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'categories',
        showBack: false,
        showMenuIcon: true,
      ),
      body: Obx(() {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: CustomHeader(
            refreshStyle: RefreshStyle.Behind,
            onOffsetChange: (offset) {
              if (_refreshController.headerMode?.value !=
                  RefreshStatus.refreshing) {
                _scaleController.value = offset / 80.0;
              }
            },
            builder: (c, m) {
              return Container(
                color: AppColors.appBordersColor.withOpacity(.5),
                alignment: Alignment.center,
                child: SpinKitThreeBounce(
                  color: AppConfig.to.primaryColor.value,
                  size: 23.0,
                ),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: () async {
            HapticFeedback.lightImpact();
            await resetShopify();
            await AppConfig.to.jsonApiCall();
            await AppConfig.to.setupConfigData(isRefreshing: true);
            HomeLogic.to.resetCarosal();
            _refreshController.refreshCompleted();
          },
          onLoading: () async {},
          child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 12.h),
              child: Column(
                children: List.generate(
                    appConfig.collectionsWidgetsList.value.length, (index) {
                  final categoryItem =
                  appConfig.collectionsWidgetsList.value[index];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: pageMarginHorizontal,
                        vertical: pageMarginVertical / 2.2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3.r),
                        bottomLeft: Radius.circular(3.r),
                        bottomRight: Radius.circular(3.r),
                        topRight: Radius.circular(3.r),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();

                          if (categoryItem["items"].isEmpty) {
                            //---- Move to Category Products
                            // CategoryProducts
                            Get.to(
                                    () => CategoryProducts(
                                  categoryName: categoryItem["name"] ??
                                      "Un-named Category",
                                  collectionID:
                                  "gid://shopify/Collection/${categoryItem["collectionId"]}",
                                ),
                                transition: Transition.rightToLeft,
                                // fullscreenDialog: true,
                                // gestureWidth: (_) => 100.0,
                                opaque: false
                            );
                          } else {
                            //----- Move to Sub Collection Page
                            Get.to(
                                    () => SubCategoriesPage(categoryIndex: index),
                                transition: Transition.rightToLeft, opaque: false,);
                            // log("else one is running");
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.textFieldBGColor,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          width: double.maxFinite,
                          height:
                          (categoryItem["customImage"] != null) ? 85 : null,
                          child: (categoryItem["customImage"] != null)
                              ?

                          ExtendedImage.network(
                            "${categoryItem["customImage"]}",
                            fit: BoxFit.cover,
                            cache: true,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 300,
                                      height: 200,
                                      color: Colors.grey[300],
                                    ),
                                  );
                                case LoadState.completed:
                                  return null; //return null, so it continues to display the loaded image
                                case LoadState.failed:
                                  return Container(
                                      color: Colors.grey.shade200,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          Assets.icons.noImageIcon,
                                          height: 25.h,
                                        ),
                                      ));
                                default:
                                  return null;
                              }
                            },
                          )

                          ///-------- simple image network
                          // Image.network(
                          //   categoryItem["customImage"],
                          //   fit: BoxFit.cover,
                          //     errorBuilder: (context, url, error) =>
                          //         Container(
                          //             color: Colors.grey.shade200,
                          //             child: Center(
                          //               child: SvgPicture.asset(
                          //                 Assets.icons.noImageIcon,
                          //                 height: 25.h,
                          //               ),
                          //             )),
                          // )


                          ///----- fade in image
                          // FadeInImage.memoryNetwork(
                          //   placeholder: kTransparentImage,
                          //   imageErrorBuilder: (context, url, error) =>
                          //       Container(
                          //           color: Colors.grey.shade200,
                          //           child: Center(
                          //             child: SvgPicture.asset(
                          //               Assets.icons.noImageIcon,
                          //               height: 25.h,
                          //             ),
                          //           )),
                          //   fit: BoxFit.cover,
                          //   image: categoryItem["customImage"],
                          // )
                              : Row(
                            children: [
                              ExtendedImage.network(
                                categoryItem["defaultImage"] ?? "",
                                fit: BoxFit.cover,
                                cache: true,
                                height: 85.h,
                                width: 85.h,
                                loadStateChanged: (ExtendedImageState state) {
                                  switch (state.extendedImageLoadState) {
                                    case LoadState.loading:
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 300,
                                          height: 200,
                                          color: Colors.grey[300],
                                        ),
                                      );
                                    case LoadState.completed:
                                      return null; //return null, so it continues to display the loaded image
                                    case LoadState.failed:
                                      return Container(
                                          color: Colors.grey.shade200,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              Assets.icons.noImageIcon,
                                              height: 25.h,
                                            ),
                                          ));
                                    default:
                                      return null;
                                  }
                                },
                              ),

                              // FadeInImage.memoryNetwork(
                              //   placeholder: kTransparentImage,
                              //   imageErrorBuilder:
                              //       (context, url, error) => Container(
                              //     height: 85.h,
                              //     width: 85.h,
                              //     color: Colors.grey.shade200,
                              //     child: Center(
                              //       child: SvgPicture.asset(
                              //         Assets.icons.noImageIcon,
                              //         height: 25.h,
                              //         width: 25.h,
                              //       ),
                              //     ),
                              //   ),
                              //   fit: BoxFit.cover,
                              //   image: categoryItem["defaultImage"] ?? "",
                              //   width: 85.h,
                              //   height: 85.h,
                              // ),
                              40.widthBox,
                              Expanded(
                                  child: Text(
                                      categoryItem["name"] ??
                                          "Un-named Category",
                                      // textAlign: TextAlign.center,
                                      style: context.text.bodyMedium
                                          ?.copyWith(fontSize: 16.sp)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )),
        );
      }),
    );
  }
}