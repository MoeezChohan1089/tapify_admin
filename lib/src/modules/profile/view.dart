import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify_admin/src/utils/constants/assets.dart';
import 'package:tapify_admin/src/utils/constants/colors.dart';
import 'package:tapify_admin/src/utils/constants/margins_spacnings.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_elevated_button.dart';
import '../../global_controllers/database_controller.dart';
import '../order/view.dart';
import '../recently_viewed/view.dart';
import 'components/currency_selector_dropdown.dart';
import 'components/profile_page_tiles.dart';
import 'edit_profile/view.dart';
import 'logic.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final logic = Get.put(ProfileLogic());
  // final logic1 = Get.put(AuthLogic());

  final state = Get.find<ProfileLogic>().state;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      logic.getUserInfo();
      logic.infor.value = LocalDatabase.to.box.read('userInfo') ?? [];
      print("userInfo: ${LocalDatabase.to.box.read('userInfo')}");
      logic.infor.value = LocalDatabase.to.box.read('userInfo');
      print("value update file in flutter=====: ${logic.infor.value}=====");
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'Profile',
            showBack: false,
            showMenuIcon: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                30.heightBox,

                //------- Profile Picture & Name
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
                  child: Row(
                    children: [
                      Container(
                          height: 70.h,
                          width: 70.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.textFieldBGColor),
                          child: SvgPicture.asset(
                            Assets.icons.userProfileIcon,
                            color: AppColors.appBordersColor,
                          )),

                      // CircleAvatar(
                      //   radius: 37.r,
                      //   backgroundColor: Colors.white,
                      //   backgroundImage: const NetworkImage(
                      //       "https://th.bing.com/th/id/R.5d2640166fb9248ee7ae20cbc19a9141?rik=QcfC8%2ft8rnv%2foQ&pid=ImgRaw&r=0"),
                      // ),
                      18.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${logic.infor.value[0]['firstname']} ${logic.infor.value[0]['lastname']}",
                            style: context.text.labelMedium?.copyWith(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${logic.infor.value[0]['email']}",
                            style: context.text.bodyMedium?.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.appProfileColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                30.heightBox,

                ProfilePageTiles(
                  title: "My Profile",
                  iconPath: Assets.icons.userProfileIcon,
                  onPress: () {
                    Get.to(() => Edit_profilePage());
                  },
                ),

                ProfilePageTiles(
                  title: "My Orders",
                  iconPath: Assets.icons.shopOrders,
                  onPress: () {
                    Get.to(() => OrderPage());
                  },
                ),

                ProfilePageTiles(
                  title: "Recently Viewed",
                  iconPath: Assets.icons.shopBox,
                  onPress: () {
                    Get.to(() => RecentlyViewedPage());
                  },
                ),

                // ProfilePageTiles(
                //   title: "Return Policy",
                //   iconPath: Assets.icons.creditCard,
                //   onPress: () {},
                // ),
                // ProfilePageTiles(
                //   title: "Return & Exchange",
                //   iconPath: Assets.icons.deliveryVan,
                //   onPress: () {},
                // ),
                //
                // ProfilePageTiles(
                //   title: "Address Book",
                //   iconPath: Assets.icons.locationPin,
                //   onPress: () {},
                // ),
                //
                // ProfilePageTiles(
                //   title: "FAQs",
                //   iconPath: Assets.icons.shopBox,
                //   onPress: () {
                //     ///----- Filter API Testing
                //     testFilterApi();
                //   },
                // ),

                ///---------- Custom Dropdown For Currency
                const CurrencySelector(),

                40.heightBox,

                Obx(() {
                  return GlobalElevatedButton(
                    text: "Logout",
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      logic.signOutUser(context: context);
                    },
                    isLoading: logic.isProcessing.value,
                    applyHorizontalPadding: true,
                  );
                }),
              ],
            ),
          ));
    });
  }
}

// class ProfilePageTiles extends StatelessWidget {
//   final String title, iconPath;
//   final Function onPress;
//
//   const ProfilePageTiles({
//     super.key,
//     required this.iconPath,
//     required this.title,
//     required this.onPress
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => onPress(),
//       child: Container(
//         padding: EdgeInsets.symmetric(
//             vertical: pageMarginVertical
//         ),
//         margin: EdgeInsets.symmetric(
//             horizontal: pageMarginHorizontal
//         ),
//         decoration: const BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: Colors.black,
//                 width: 0.5,
//               ),
//             )
//         ),
//         child: Row(
//           children: [
//
//             SizedBox(
//               width: 45,
//               child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: SvgPicture.asset(iconPath)),
//             ),
//
//
//             Expanded(
//               child: Text(title,
//                 style: context.text.bodyLarge,
//               ),
//             ),
//
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: Colors.black,
//               size: 18.sp,
//             )
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
