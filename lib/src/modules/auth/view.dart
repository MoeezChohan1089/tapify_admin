import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify_admin/src/modules/auth/view_sign_in.dart';
import 'package:tapify_admin/src/modules/auth/view_sign_up.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../global_controllers/app_config/config_controller.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/margins_spacnings.dart';
import '../bottom_nav_bar/view.dart';
import '../cart/logic.dart';
import 'logic.dart';

class AuthPage extends StatefulWidget {
  final Function? onSuccess;
  final bool isShow;

  const AuthPage({Key? key, this.onSuccess, this.isShow = false})
      : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final logic = Get.put(AuthLogic());

  final logic1 = Get.put(CartLogic());

  final state = Get
      .find<AuthLogic>()
      .state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final logic = Get.put(AuthLogic());
    logic.onAuthSuccessUpdate(widget.onSuccess);
    logic.clearTextControllers();
  }


  @override
  Widget build(BuildContext context) {
    // final logic = Get.put(AuthLogic());

    print("here is the value of => ${CartLogic.to.getAccCreationSetting }");

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return AppConfig.to.homeAppBarLogo.value == '' ? Text(
            'tapify'.toUpperCase(),
            style:
            context.text.titleSmall?.copyWith(
                fontSize: 16.sp, color: AppConfig.to.iconCollectionColor.value),
          ) : SizedBox(
            height: 35.h,
            // color: Colors.red,
            child: ExtendedImage.network(
             AppConfig.to.homeAppBarLogo.value,
              fit: BoxFit.cover,  // ensures that the image scales down if necessary, but not up
              // width: double.infinity,
              cache: true,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 70,
                        color: Colors.grey[300],
                      ),
                    );
                  case LoadState.completed:
                    return null; //return null, so it continues to display the loaded image
                  case LoadState.failed:
                    return SvgPicture.asset(
                      Assets.icons.noImageIcon,
                      height: 20,
                      width: 50,
                    );
                  default:
                    return null;
                }
              },
            ),
          );
        }),
        centerTitle: true,
        backgroundColor: AppConfig.to.appbarBGColor.value,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close, color: AppConfig.to.iconCollectionColor.value,)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal + 4),
            child: SizedBox(),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 70.heightBox,
          // Row(
          //   children: [
          //     Expanded(child: Align(
          //         alignment: Alignment.bottomLeft,
          //         child: IconButton(
          //             onPressed: () {
          //               Get.back();
          //             },
          //             icon: const Icon(
          //               Icons.close, color: AppColors.customBlackTextColor,)))),
          //     Expanded(
          //         flex: 2,
          //         child:
          //         Obx(() {
          //           return SizedBox(
          //             height: 35.h,
          //             // color: Colors.red,
          //             child: CachedNetworkImage(
          //               imageUrl: AppConfig.to.homeAppBarLogo.value,
          //               fit: BoxFit.cover,
          //               placeholder: (context, url) =>
          //                   SizedBox(
          //                     height: 50.h,
          //                     width: 100.w,
          //                     child: Shimmer.fromColors(
          //                       baseColor: Colors.grey.shade300,
          //                       highlightColor: Colors.grey.shade100,
          //                       child: Container(
          //                         color: AppColors.customWhiteTextColor,
          //                       ),
          //                     ),
          //                   ),
          //               errorWidget: (context, url, error) =>
          //                   Text(
          //                     'tapday',
          //                     style: context.text.titleSmall
          //                         ?.copyWith(fontSize: 16.sp, height: 3),
          //                   ),
          //             ),
          //           );
          //         })
          //     ),
          //     const Expanded(child: SizedBox(),)
          //   ],
          // ),

          40.heightBox,


          Stack(
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                        color: Colors.grey.shade300, width: 1))
                ),
                child: TabBar(
                  controller: logic.tabController,
                  onTap: (int a) {
                    HapticFeedback.lightImpact();
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  indicatorColor: Colors.black,
                  // unselectedLabelStyle: Colors.black,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  labelStyle: context.text.labelSmall?.copyWith(
                      fontSize: 16.sp
                  ),
                  dividerColor: Colors.white,
                  // splashBorderRadius: BorderRadius.circular(8.r),
                  labelPadding: EdgeInsets.only(
                      bottom: 7.h,
                      right: 10,
                      left: 16
                  ),
                  // indicatorSize: TabBarIndicatorSize.tab,
                  // indicatorPadding: EdgeInsets.only(bottom: 25.h),
                  indicatorPadding: const EdgeInsets.only(
                      left: 5
                  ),
                  indicatorWeight: 1.4.h,

                  // padding: EdgeInsets.only(
                  //   left: 10.w,),
                  isScrollable: true,
                  splashFactory: null,
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.transparent;
                    }
                    // return Colors.green;
                  }),
                  // splashFactory: ,
                  tabs: const [
                    Text(
                      'Sign in',
                    ),
                    Text(
                      "I'm new here",
                    ),
                  ],
                ),
              ),

            ],
          ),


          Expanded(child: TabBarView(
            // physics: const NeverScrollableScrollPhysics(),
            controller: logic.tabController,
            children: [
              SignInPage(),
              SignUpPage(),

            ],

          ))


        ],
      ),
      bottomNavigationBar:

      widget.isShow == false ? SizedBox.shrink() : (CartLogic.to
          .getAccCreationSetting.contains("Required"))
          ? const SizedBox.shrink()
          :
      SafeArea(
        child: Wrap(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: pageMarginVertical
                ),
                child:
                Obx(() {
                  print("ffffsssfjshfksf: ${logic1.isloadingWebview.value}");
                  return logic1.isloadingWebview.value == true
                      ? SpinKitThreeBounce(
                    color: Colors.black,
                    size: 23.0,
                    // controller: AnimationController(
                    //     vsync: this, duration: const Duration(milliseconds: 1200)),
                  )
                      :  GestureDetector(
                    onTap: () {
                      // if(logic.isCheckoutContinue.value == true){
                      HapticFeedback.lightImpact();
                      logic1.isloadingWebview.value = true;
                      CartLogic.to.checkoutToWeb(
                        continueAsGuest: true,
                      );
                      // }else{
                      //   Get.offAll(() => BottomNavBarPage());
                      // }


                    },
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.appTextColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text("Continue As Guest",
                        style: context.text.bodyMedium
                            ?.copyWith(
                            color: AppColors.appTextColor,
                            fontSize: 14.sp
                        ),),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}