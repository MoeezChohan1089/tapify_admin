import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tapify_admin/src/modules/home/components/search_bar.dart';
import 'package:tapify_admin/src/modules/home/logic.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../global_controllers/notification_service.dart';
import '../../utils/constants/colors.dart';
import '../../utils/global_instances.dart';
import '../bottom_nav_bar/logic.dart';
import '../product_detail/logic.dart';
import 'components/circle_product_list.dart';
import 'components/count_down_timer.dart';
import 'components/custom_divider.dart';
import 'components/demoVideo.dart';
import 'components/discount_widget.dart';
import 'components/grid_view_by_category.dart';
import 'components/grid_view_simple.dart';
import 'components/marquee_text.dart';
import 'components/product_slider.dart';
import 'components/products_carousel.dart';
import 'components/products_gallery.dart';
import 'components/products_slide_show.dart';
import 'components/single_image.dart';
import 'components/title_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<HomePage> {
  final logic = Get.put(HomeLogic());
  final productDetail = Get.put(ProductDetailLogic());
  final bottomNav = Get.find<BottomNavBarLogic>();

  // final _advancedDrawerController = AdvancedDrawerController();
  PanelController controller = PanelController();


  // int sideDrawerType = 1;
  //---- 1 for fancy 2 for simple
  // final RefreshController _refreshController =
  // RefreshController(initialRefresh: false);
  late AnimationController _scaleController;

  // late AnimationController _footerController;
  RefreshController _refreshController = RefreshController();

  // void _handleMenuButtonPressed()

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //--------------
    // TODO: implement initState
    // _anicontroller = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 2000));
    _scaleController =
        AnimationController(value: 0.0, vsync: this, upperBound: 1.0);
    // _footerController = AnimationController(
    //     vsync: this, duration: Duration(milliseconds: 2000));
    _refreshController.headerMode?.addListener(() {
      if (_refreshController.headerStatus == RefreshStatus.idle) {
        _scaleController.value = 0.0;
        // _anicontroller.reset();
      } else if (_refreshController.headerStatus == RefreshStatus.refreshing) {
        // _anicontroller.repeat();
      }
    });


    ///---- old
    requestPermission();
    loadFCM();
    listenFCM();
  }

  @override
  void dispose() {
    print("Dispose called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppBar(
        isHome: true, title: 'tapify',
        showMenuIcon: true,
      ),

      ///----- Implement Home UI dynamic here
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
            AppConfig.to.update();
            logic.resetCarosal();
            _refreshController.refreshCompleted();
          },
          onLoading: () async {},

          ///----- Listview
          child:
          SingleChildScrollView(
            child: Column(
              // padding: EdgeInsets.only(bottom: 50.h),
              children:
              List.generate(
                AppConfig.to.homeWidgetsList.value.length,
                    (index) =>
                    _buildWidget(AppConfig.to.homeWidgetsList.value[index]),
              ),
              // [
              //   for (int index = 0; index < AppConfig.to.homeWidgetsList.value.length; index++)
              //     _buildWidget(AppConfig.to.homeWidgetsList.value[index]),
              // ],
            ),
          ),
        );
      }),
    );
  }


  Widget _buildWidget(Map<String, dynamic> widgetData) {
    final settings = widgetData["settings"];
    final widgetMap = {
      'search': () => SearchBarContainer(settings: settings),
      'marquee': () => AnimatedMarqueeText(settings: settings),
      'title': () => TitleText(settings: settings),
      'divider': () => CustomDivider(divider: settings),
      'timer': () => CountDownTimer(settings: settings),
      'product': () =>
      (settings["metadata"]["data"] as List).isEmpty
          ? const SizedBox.shrink()
          : CircularProductList(settings: settings),
      'gallery': () =>
      (settings["metadata"]["data"] as List).isEmpty
          ? const SizedBox.shrink()
          : ProductsGallery(settings: settings),
      'carousel': () {
        if ((settings["metadata"]["data"] as List).isNotEmpty) {
          HomeLogic.to.currentCarouselIndex.value =
          settings["metadata"]["data"].length > 1 ? 1 : 0;
        }

        return (settings["metadata"]["data"] as List).isEmpty ? const SizedBox
            .shrink() : ProductsCarousel(settings: settings);
      },


      'image': () {
        return ((settings["metadata"]["data"] as List).isEmpty &&
            settings["image"] == null)
            ? const SizedBox.shrink()
            : SingleImageWidget(settings: settings);
      },
      'slideShow': () =>
      (settings["metadata"]["data"] as List).isEmpty
          ? const SizedBox.shrink()
          : ProductsSlideShow(settings: settings),
      'video': () =>
          GetBuilder<HomeLogic>(
              builder: (logic) {
                logic.initializeValueOfVideo(settings);
                return SingleVideoView(settings: settings,);
              }),
      // 'video': () => VideoPlayerScreen(),
      'discount': () {
        logic.widgetCustomerCode.value = settings["customerCode"] ?? "";
        logic.widgetShopifyCode.value = settings["shopifyCode"] ?? "";

        return DiscountWidget(settings: settings);
      },
      'slider': () =>
      (settings["metadata"]["data"] as List).isEmpty
          ? const SizedBox.shrink()
          : ProductSlider(settings: settings),
      'grid': () =>
      (settings["metadata"]["data"] as List).isEmpty
          ? const SizedBox.shrink()
          : ProductGridViewSimple(settings: settings),
      'productByTags': () {
        logic.catProdSettings = settings;
        logic.getProducts();
        return (settings["metadata"]["data"] as List).isEmpty ? const SizedBox
            .shrink() : ProductGridViewByCategory(settings: settings);
      },
    };
    final widgetType = widgetData["type"];
    final widgetBuilder = widgetMap[widgetType] ?? () => Container();
    return widgetBuilder();
  }

}
