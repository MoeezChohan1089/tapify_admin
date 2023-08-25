import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';

class ContainerDivider extends StatefulWidget {
  final dynamic product;

  const ContainerDivider({Key? key, required this.product}) : super(key: key);

  @override
  State<ContainerDivider> createState() => _ContainerDividerState();
}

class _ContainerDividerState extends State<ContainerDivider> {
  bool expanded = false;
  bool expanded1 = false;
  bool expanded2 = false;
  bool expanded3 = false;
  bool expanded4 = false;

  // final logic = Get.find<ProductDetailLogic>();

  Widget renderHtmlContent(String htmlContent) {
    if (htmlContent != null && htmlContent.isNotEmpty) {
      // return Text("");
      return Html(
        data: htmlContent,
      );
    } else {
      return Text(
        "No Description",
        style: context.text.bodyMedium?.copyWith(fontSize: 13.sp),
      );
    }
  }

  customContainerDivide(String heading, String description,
      {bool expand = false}) {
    if (heading == "Product Details" && description.isEmpty) {
      return Container();
    }

    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: pageMarginHorizontal),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                expand = !expand;
                setState(() {});
              },
              child: Container(
                color: Colors.transparent,
                // padding: EdgeInsets.symmetric(vertical: pageMarginVertical / 3),
                child: Column(
                  children: [
                    4.heightBox,
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            heading,
                            style: context.text.bodyMedium?.copyWith(
                                color: AppColors.appTextColor, fontSize: 16.sp
                              // height: 0.1
                            ),
                          ),
                          const Spacer(),
                          expand
                              ? Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: AppColors.customBlackTextColor,
                            size: 28.sp,
                          )
                              : Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColors.customBlackTextColor,
                            size: 28.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: expand ? 10 : 0),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      child: expand
                          ? Builder(builder: (context) {
                        return (heading == "Product Details")
                            ? renderHtmlContent(description)
                            : Container(
                          width: double.maxFinite,
                          child: Text(
                            description,
                            textAlign: TextAlign.left,
                            style: context.text.bodyMedium
                                ?.copyWith(fontSize: 13.sp),
                          ),
                        );
                      })
                          : Container(
                        height: 0,
                      ),
                    ),
                    4.heightBox,
                  ],
                ),
              ),
            ),
            const Divider(
              color: AppColors.appHintColor,
              thickness: .2,
            ),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return Column(
      children: [
        widget.product != null &&
            widget.product!.description != null &&
            widget.product!.description!.isNotEmpty
            ? customContainerDivide(
            "Product Details", "${widget.product?.descriptionHtml}" ?? "",
            expand: expanded)
            : const SizedBox(),
        widget.product != null &&
            widget.product!.vendor != null &&
            widget.product!.vendor.isNotEmpty
            ? customContainerDivide(
            "About the Brand", "${widget.product?.vendor}" ?? "",
            expand: expanded3)
            : const SizedBox(),
      ],
    );
    // });
  }
}