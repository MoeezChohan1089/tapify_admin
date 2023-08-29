import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tapify_admin/src/modules/category/view_category_products.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../../utils/global_instances.dart';
import '../home/logic.dart';

class SubCategoriesPage extends StatefulWidget {
  final int categoryIndex;

  SubCategoriesPage({super.key, required this.categoryIndex});

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage>
    with TickerProviderStateMixin {
  final logic = Get.put(HomeLogic());

  final appConfig = AppConfig.to;

  late AnimationController _scaleController;

  // late AnimationController _footerController;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scaleController =
        AnimationController(value: 0.0, vsync: this, upperBound: 1.0);

    _refreshController.headerMode?.addListener(() {
      if (_refreshController.headerStatus == RefreshStatus.idle) {
        _scaleController.value = 0.0;
        // _anicontroller.reset();
      } else if (_refreshController.headerStatus == RefreshStatus.refreshing) {
        // _anicontroller.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'sub collections',
        showBack: true,
        // showMenuIcon: true,
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
            logic.resetCarosal();
            _refreshController.refreshCompleted();
          },
          onLoading: () async {},
          child: SingleChildScrollView(
            child: Column(
              children: [
                12.heightBox,
                Padding(
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBGColor,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                      width: double.maxFinite,
                      height: appConfig.collectionsWidgetsList
                          .value[widget.categoryIndex]["customImage"] !=
                          null
                          ? 85
                          : null,
                      child: (appConfig.collectionsWidgetsList
                          .value[widget.categoryIndex]["customImage"] !=
                          null)
                          ? FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        imageErrorBuilder: (context, url, error) =>
                            Container(
                              color: Colors.grey.shade200,
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.icons.noImageIcon,
                                  height: 25.h,
                                ),
                              ),
                            ),
                        fit: BoxFit.cover,
                        image: appConfig.collectionsWidgetsList
                            .value[widget.categoryIndex]["customImage"],
                      )
                          : Row(
                        children: [
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            imageErrorBuilder: (context, url, error) =>
                                Container(
                                  color: Colors.grey.shade200,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.icons.noImageIcon,
                                      height: 25.h,
                                    ),
                                  ),
                                ),
                            fit: BoxFit.cover,
                            width: 85.h,
                            height: 85.h,
                            image: appConfig.collectionsWidgetsList
                                .value[widget.categoryIndex]
                            ["defaultImage"],
                          ),
                          40.widthBox,
                          Expanded(
                              child: Text(
                                  appConfig.collectionsWidgetsList
                                      .value[widget.categoryIndex]
                                  ["name"] ??
                                      "Un-named Category",
                                  style: context.text.bodyMedium
                                      ?.copyWith(fontSize: 16.sp)))
                        ],
                      ),
                    ),
                  ),
                ),
                20.heightBox,
                const Divider(
                  color: AppColors.appBordersColor,
                  height: 0,
                  thickness: .5,
                ),
                Column(
                  children: List.generate(
                      appConfig
                          .collectionsWidgetsList
                          .value[widget.categoryIndex]["items"]
                          .length, (index) {
                    final subCategoryItem = appConfig.collectionsWidgetsList
                        .value[widget.categoryIndex]["items"][index];

                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Get.to(
                                () => CategoryProducts(
                              categoryName: subCategoryItem["name"] ??
                                  "Un-named Category",
                              collectionID:
                              "${subCategoryItem["admin_graphql_api_id"]}",
                            ),
                            transition: Transition.rightToLeft);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.appBordersColor,
                                width: 0.5,
                              ),
                            )),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: pageMarginVertical + 2),
                          margin: EdgeInsets.symmetric(
                              horizontal: pageMarginHorizontal),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                subCategoryItem["name"] ?? "Un-named Category",
                                style: context.text.bodyMedium
                                    ?.copyWith(height: .05),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.black,
                                size: 16.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
