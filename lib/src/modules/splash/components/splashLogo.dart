import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/assets.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';

class SplashLogo extends StatelessWidget {
  final String imageUrl;

  const SplashLogo({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    /// Change system navigation bar color here
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.transparent, // Set the desired color here
    //   ),
    // );

    return Stack(
      fit: StackFit.expand,
      // alignment: Alignment.center,

      children: [
        imageUrl == "" ? Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInImage(
                placeholder:  AssetImage(Assets.images.simpleWhiteContainer),
                // image: NetworkImage(imageUrl),
                image: AssetImage(Assets.images.sanaSafinazLogo),
                fadeInDuration: const Duration(milliseconds: 100),
                fadeInCurve: Curves.easeIn,
                height: 260.h,
                width: 260.w,
              ),
              // SizedBox(
              //   height: 60.h,
              // ),
            ],
          ),
        ) :
        CachedNetworkImage(
            imageUrl: imageUrl,
            // imageUrl: productDetail.images.isNotEmpty ?  productDetail.images[0].originalSrc : "",
            // imageBuilder: (context,
            //     imageProvider) =>
            //     CircleAvatar(
            //       backgroundImage:
            //       imageProvider,
            //       backgroundColor: Colors.transparent,
            //     ),
            // placeholder: (context, url) =>
            //     productCircleShimmer(),
            fit: BoxFit.cover,
            errorWidget:
                (context, url, error) =>
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // color: Colors.grey.shade100,
                    // borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Center(
                    child: SvgPicture.asset(Assets.icons.noImageIcon,
                      height: 24.h,
                    ),
                  ),
                )
        ),

        // SplashLogic.to.currentState.value == "continue" ? SafeArea(
        //   child: Wrap(
        //     children:  const [
        //       SpinKitThreeBounce(
        //         color: AppColors.appTextColor,
        //         // color: Colors.black,
        //         size: 23.0,
        //       ),
        //     ],
        //   ),
        // ) : const SizedBox.shrink(),

      ],
    );
  }
}