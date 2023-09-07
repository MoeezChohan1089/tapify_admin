import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:tapify_admin/src/utils/extensions.dart';

import '../../../global_controllers/app_config/config_controller.dart';
import '../../../utils/constants/colors.dart';
import '../logic.dart';

class ProductPhotoGallery extends StatelessWidget {
  final dynamic product;
  final CarouselController  carouselController;
  Rx<int> currentImageIndex;
  ProductPhotoGallery({Key? key, required this.product, required this.carouselController, required this.currentImageIndex}) : super(key: key);

  // final productDetailLogic = ProductDetailLogic.to;
  @override
  Widget build(BuildContext context) {
    final PageController pageController =
    PageController(initialPage: currentImageIndex.value);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PhotoViewGallery.builder(
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(
                    product.images[index].originalSrc),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale
                    .contained, // Minimum scale allowed (cannot zoom out beyond initial scale)
                maxScale: PhotoViewComputedScale.covered *
                    2.0, // Maximum scale allowed (zoom in limit)
                // heroAttributes: PhotoViewHeroAttributes(tag: product!.images[productDetailLogic.currentImageIndex.value].originalSrc),
              );
            },
            itemCount: product.images.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppConfig.to.primaryColor.value,
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                      event.expectedTotalBytes!.toInt(),
                ),
              ),
            ),
            backgroundDecoration: BoxDecoration(color: Colors.grey.shade100),
            pageController: pageController,
            onPageChanged: (int val) {
              currentImageIndex.value = val;
              carouselController.jumpToPage(val);
              // productDetailLogic.carouselController.jumpToPage(val);
            },
          ),
          Positioned(
            left: 10.w,
            top: 40.h,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                size: 26.sp,
              ),
            ),
          ),
          product?.images.length == 1 ? 0.heightBox : 10.heightBox,
          product?.images.length != 1
              ? SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  product?.images.length ?? 0,
                      (index) =>
                      Obx(() {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              child: AnimatedContainer(
                                duration:
                                const Duration(milliseconds: 250),
                                height: 7.h,
                                width: currentImageIndex.value ==
                                    index
                                    ? 25.h
                                    : 7.h,
                                decoration: currentImageIndex.value ==
                                    index
                                    ? BoxDecoration(
                                    color: AppConfig
                                        .to.primaryColor.value,
                                    borderRadius:
                                    BorderRadius.circular(50.r))
                                    : BoxDecoration(
                                    color: AppColors.appBordersColor,
                                    borderRadius:
                                    BorderRadius.circular(50.r)),
                              ),
                            ),
                            4.widthBox
                          ],
                        )
                        ;
                      })
              ),
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}