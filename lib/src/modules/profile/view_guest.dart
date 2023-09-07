import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// import 'package:shopify_flutter/models/src/product/products/products.dart';
// import 'package:shopify_flutter/shopify_flutter.dart';
import 'package:tapify_admin/src/modules/auth/components/custom_button.dart';
import 'package:tapify_admin/src/modules/auth/logic.dart';
import 'package:tapify_admin/src/modules/bottom_nav_bar/logic.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../global_controllers/app_config/config_controller.dart';
import '../../global_controllers/database_controller.dart';
import '../auth/view.dart';
import '../cart/logic.dart';
import '../cart/view.dart';
import '../recently_viewed/view.dart';
import 'api_service/profile_apis.dart';
import 'components/currency_selector_dropdown.dart';
import 'components/profile_page_tiles.dart';
import 'logic.dart';
import 'package:timezone/data/latest.dart' as tz;

class ProfileWithoutLoginPage extends StatefulWidget {
  const ProfileWithoutLoginPage({Key? key}) : super(key: key);

  @override
  State<ProfileWithoutLoginPage> createState() =>
      _ProfileWithoutLoginPageState();
}

class _ProfileWithoutLoginPageState extends State<ProfileWithoutLoginPage> {
  final logic = Get.put(ProfileLogic());
  final logic1 = Get.put(AuthLogic());

  final state = Get
      .find<ProfileLogic>()
      .state;

  // List infor = [];


  @override
  void initState() {
    super.initState();
    // logic.getDynamicHomeView();
  }

  void initializeTimezone() {
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Profile',
        showBack: false,
        isHome: true,
        showMenuIcon: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.heightBox,
            //------- Profile Picture & Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColors.textFieldBGColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal,
                    vertical: pageMarginVertical * 1.5),
                child: Text(
                  "Login To Access Order Details, Tracking, Purchase History And More",
                  textAlign: TextAlign.center,
                  style: context.text.bodyLarge?.copyWith(
                      height: 1.2, color: AppColors.appTextColor),),
              ),
            ),
            20.heightBox,

            // ProfilePageTiles(
            //   title: "Return Policy",
            //   iconPath: Assets.icons.creditCard,
            //   onPress: (){},
            //
            //
            // ),
            // ProfilePageTiles(
            //   title: "Return & Exchange",
            //   iconPath: Assets.icons.deliveryVan,
            //   onPress: (){},
            // ),
            // ProfilePageTiles(
            //   title: "Address Book",
            //   iconPath: Assets.icons.locationPin,
            //   onPress: (){},
            // ),
            // ProfilePageTiles(
            //   title: "FAQs",
            //   iconPath: Assets.icons.shopBox,
            //   onPress: (){},
            // ),

            ProfilePageTiles(
              title: "Recently Viewed",
              iconPath: Assets.icons.shopBox,
              onPress: () {
                Get.to(() => RecentlyViewedPage(), opaque: false, transition: Transition.native);
              },
            ),

            ///---------- Custom Dropdown For Currency
            const CurrencySelector(),

            40.heightBox,


            GlobalElevatedButton(
              text: "login / Register",

              onPressed: () {
                // showToastMessage(message: "Order note has been added successfully");
                //
                // Get.to(()=> const AuthPage());

                HapticFeedback.lightImpact();
                Get.to(() => const AuthPage(),
                    transition: Transition.downToUp,
                    fullscreenDialog: true,
                    duration:
                    const Duration(milliseconds: 250), opaque: false,);
              },
              isLoading: false,
              applyHorizontalPadding: true,
            ),


            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: pageMarginHorizontal
            //   ),
            //   child: AuthBlackButton(
            //     buttonTitle: "Login",
            //     onPressed: (){
            //       // LocalDatabase.to.box.remove("customerAccessToken");
            //       Get.to(()=> const AuthPage());
            //       // logic.signOutUser(context: context);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}