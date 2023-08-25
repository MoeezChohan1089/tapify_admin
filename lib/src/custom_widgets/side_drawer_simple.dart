import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/constants/assets.dart';
import 'package:tapify/src/utils/constants/colors.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../utils/constants/margins_spacnings.dart';
import '../modules/profile/logic.dart';

class SideDrawerSimple extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
   SideDrawerSimple({Key? key, required this.scaffoldKey})
      : super(key: key);

  final logic = Get.put(ProfileLogic());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      // width: MediaQuery.of(context).size.width * .65,
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----------Upper Logo

            90.heightBox,

            ///-------- Profile Details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Center(
                      child: Text(
                        'T',
                        style: context.text.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  5.heightBox,
                  Text(
                    'Tapify',
                    style: context.text.bodyLarge,
                  ),
                  Text(
                    'Tapify@gmail.com',
                    style: context.text.bodyMedium
                        ?.copyWith(color: AppColors.customGreyPriceColor),
                  ),
                ],
              ),
            ),

            40.heightBox,

            ///-----Menu Items
            Column(
              children: [
                MenuItemTile(
                  title: 'Home',
                  iconPath: Assets.icons.homeIcon,
                  onPress: () {},
                ),
                MenuItemTile(
                  title: 'Category',
                  iconPath: Assets.icons.categoriesIcon,
                  onPress: () {},
                ),
                MenuItemTile(
                  title: 'Wishlist',
                  iconPath: Assets.icons.wishlistIcon,
                  onPress: () {},
                ),
                MenuItemTile(
                  title: 'Account',
                  iconPath: Assets.icons.userProfileIcon,
                  onPress: () {},
                ),
                MenuItemTile(
                  title: 'My Orders',
                  iconPath: Assets.icons.orderBagIcon,
                  onPress: () {},
                ),
                MenuItemTile(
                  title: 'Logout',
                  iconPath: Assets.icons.logOutIcon,
                  isFlag: true,
                  onPress: () {
                    logic.signOutUser(context: context);
                  },
                ),
              ],
            ),

            ///-----Divider
            Divider(
              color: Colors.black,
              thickness: .5,
              indent: pageMarginHorizontal,
              endIndent: pageMarginHorizontal,
              height: 50.h,
            ),

            20.heightBox,

            ///------ Social Media Icons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 32,
                    width: 32,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: SvgPicture.asset(
                      Assets.icons.facebookIcon,
                    ),
                  ),
                ),
                14.widthBox,
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 32,
                    width: 32,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: SvgPicture.asset(Assets.icons.instaIcon),
                  ),
                ),
                14.widthBox,
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      height: 32,
                      width: 32,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      child: SvgPicture.asset(Assets.icons.linkedinIcon)),
                ),
                14.widthBox,
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    height: 32,
                    width: 32,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: SvgPicture.asset(Assets.icons.twitterIcon),
                  ),
                ),
              ],
            ),

            Expanded(child: Container()),

            ///------Bottom Close Drawer Button
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  scaffoldKey.currentState?.closeDrawer();
                },
                borderRadius: BorderRadius.circular(100),
                child: Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        )),
                    child: SvgPicture.asset(
                      Assets.icons.closeIcon,
                      // height: 25,
                    )),
              ),
            ),

            60.heightBox,
          ],
        ),
      ),
    );
  }
}

class MenuItemTile extends StatelessWidget {
  final String title, iconPath;
  final Function onPress;
  final bool isFlag;

  const MenuItemTile(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.onPress,
      this.isFlag = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        onTap: () => onPress(),
        splashColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 8.h, horizontal: pageMarginHorizontal),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                color: isFlag ? Colors.red : Colors.black,
              ),
              14.widthBox,
              Text(
                title,
                style: context.text.bodyLarge
                    ?.copyWith(color: isFlag ? Colors.red : Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}