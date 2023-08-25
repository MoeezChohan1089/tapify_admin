import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tapify/src/modules/auth/view_sign_in.dart';
import 'package:tapify/src/modules/auth/view_sign_up.dart';
import 'package:tapify/src/utils/extensions.dart';
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

  const AuthPage({Key? key, this.onSuccess}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final logic = Get.put(AuthLogic());

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
          return AppConfig.to.homeAppBarLogo.value == ''?Text(
            'tapify'.toUpperCase(),
            style:
            context.text.titleSmall?.copyWith(fontSize: 16.sp, color: AppConfig.to.iconCollectionColor.value),
          ): SizedBox(
            height: 35.h,
            // color: Colors.red,
            child: FadeInImage.memoryNetwork(
              image: AppConfig.to.homeAppBarLogo.value,
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              imageErrorBuilder: (context, url,
                  error) => Container(
                color: Colors.grey.shade200,
                // color: Colors.grey.shade200,
                child: Center(
                  child: SvgPicture.asset(Assets.icons.noImageIcon,
                    height: 25.h,
                  ),
                ),
              ),
              //     (context, url) => SizedBox(
              //   height: 50.h,
              //   width: 100.w,
              //   child: Shimmer.fromColors(
              //     baseColor: Colors.grey.shade300,
              //     highlightColor: Colors.grey.shade100,
              //     child: Container(
              //       color: AppColors.customWhiteTextColor,
              //     ),
              //   ),
              // ),
              // errorWidget: (context, url, error) => Text(
              //   title.toUpperCase(),
              //   style: context.text.titleSmall
              //       ?.copyWith(fontSize: 16.sp, height: 3),
              // ),
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
            padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal+4),
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

      (CartLogic.to.getAccCreationSetting.contains("Required")) ? const SizedBox.shrink() :
      SafeArea(
        child: Wrap(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: pageMarginVertical
                ),
                child:
                GestureDetector(
                  onTap: () {
                    // if(logic.isCheckoutContinue.value == true){
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}