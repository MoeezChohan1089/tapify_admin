import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/assets.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInImage(
            placeholder: AssetImage(Assets.images.simpleWhiteContainer),
            image: AssetImage(Assets.images.sanaSafinazLogo),
            fadeInDuration: const Duration(milliseconds: 300),
            fadeInCurve: Curves.easeIn,
            height: 260.h,
            width: 260.w,
          ),
        ],
      ),
    );
  }
}
