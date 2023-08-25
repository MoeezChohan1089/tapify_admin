
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';
import 'package:tapify/src/global_controllers/app_config/config_controller.dart';
import 'package:tapify/src/modules/category/logic.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:vibration/vibration.dart';

import '../../../custom_widgets/custom_app_bar.dart';
import '../../../custom_widgets/custom_elevated_button.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/margins_spacnings.dart';
import '../../auth/components/custom_button.dart';
import '../api_service/model_filters.dart';

class FilterOptionsView extends StatefulWidget {
  final Filter filter;

  const FilterOptionsView({Key? key, required this.filter}) : super(key: key);

  @override
  State<FilterOptionsView> createState() => _FilterOptionsViewState();
}

class _FilterOptionsViewState extends State<FilterOptionsView> {

  // late RangeValues rangeValues = RangeValues(0.0, 100.0);
  double priceMin = 0.0;
  double priceMax = 100.0;

  final priceMinTxtController = TextEditingController();
  final priceMaxTxtController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.filter.id == "filter.v.price") setThePriceRange();



  }

  setThePriceRange(){


    print("1 => ${widget.filter.values[0]}");
    print("2 => ${widget.filter.values[0].input}");
    dynamic priceRanges = jsonDecode(widget.filter.values[0].input);
    priceMin = 0.0;
    // priceMin = priceRanges['price']['min'].toDouble();
    priceMax = priceRanges['price']['max'].toDouble();
    print("3 => $priceMin  and $priceMax");



    int existingIndex = -1;
    for (int i = 0; i < CategoryLogic.to.selectedFilters.length; i++) {
      Map<String, dynamic> filter = CategoryLogic.to.selectedFilters[i];
      if (filter.containsKey("price")) {
        existingIndex = i;
        break;
      }
    }



    if (existingIndex != -1) {
      priceMinTxtController.text = CategoryLogic.to.selectedFilters[existingIndex]["price"]["min"].toString();
      priceMaxTxtController.text = CategoryLogic.to.selectedFilters[existingIndex]["price"]["max"].toString();
      // priceMax
    } else {
      priceMinTxtController.text = "0.0";
      priceMaxTxtController.text = priceRanges['price']['max'].toString();
    }

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.filter.label,
        trailingButton: TextButton(
          onPressed: (){
            CategoryLogic.to.resetFilters();
            CategoryLogic.to.productFetchService(
                context: context,
                id: CategoryLogic.to.currentCategoryId.value,
                isNewId: true
            );
            Navigator.pop(context);
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
              foregroundColor: Colors.red
          ),
          child: Text('Clear',
            style: context.text.bodyMedium?.copyWith(
                color: Colors.red
            ),
          ),
        ),
      ),
      body: GetBuilder<CategoryLogic>(builder: (categoryLogic) {



        return  widget.filter.id == "filter.v.price" ?
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: pageMarginHorizontal
          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              30.heightBox,

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Set Price Range",
                  style: context.text.labelSmall?.copyWith(
                      color: AppColors.customBlackTextColor, fontSize: 14),
                ),
              ),
              10.heightBox,

              Row(
                children: [
                  Expanded(
                    child: FlutterSlider(
                      values: [double.parse(priceMinTxtController.text), double.parse(priceMaxTxtController.text)],
                      rangeSlider: true,
                      handler: FlutterSliderHandler(
                        decoration: const BoxDecoration(),
                        child: Material(
                          type: MaterialType.canvas,
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppConfig.to.primaryColor.value,
                                width: 2
                              )
                            ),
                          ),
                        ),
                      ),
                      rightHandler: FlutterSliderHandler(
                        decoration: const BoxDecoration(),
                        child: Material(
                          type: MaterialType.canvas,
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppConfig.to.primaryColor.value,
                                    width: 2
                                )
                            ),
                          ),
                        ),
                      ),
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBarHeight: 4,
                        activeTrackBar: BoxDecoration(
                          color: AppConfig.to.primaryColor.value,
                        )
                      ),
                      max: priceMax,
                      min: 0.0,
                      onDragging: (handlerIndex, lowerValue, upperValue) {

                        print("upper values is ${upperValue}");

                        priceMinTxtController.text =
                        lowerValue > upperValue ?  priceMax.toString() : lowerValue < priceMin ? "0.0" : lowerValue.toString();
                        priceMaxTxtController.text =
                        upperValue > priceMax ? priceMax.toString() : upperValue.toString();
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              10.heightBox,


              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Text("From"),
                    4.heightBox,

                      CustomTextField(
                        controller: priceMinTxtController,
                        hint: "0.0",
                        fieldVerticalPadding: 8,
                        suffixIcon: Text('USD  ',
                            style: context.text.bodyMedium
                        ),
                      ),

                    // TextField(
                    //   controller: priceMinTxtController,
                    //   style: context.text.bodyLarge,
                    //   cursorColor: Colors.black,
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     contentPadding: const EdgeInsets.symmetric(
                    //       vertical: 10,
                    //       horizontal: 10
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(0.0),
                    //       borderSide: const BorderSide(color: Colors.black), // Border color for the focused state
                    //     ),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(0.0),
                    //       borderSide: const BorderSide(
                    //         color: Colors.black,
                    //         width: .5
                    //       ),
                    //
                    //       // borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     suffix: Container(
                    //       padding: const EdgeInsets.only(
                    //         right: 5
                    //       ),
                    //       child: Text(
                    //         'USD',
                    //         style: context.text.bodyMedium
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],)),

                  20.widthBox,
                  Text("to",
                   style: context.text.bodyMedium?.copyWith(
                     height: 3
                   ),
                  ),
                  20.widthBox,
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("To"),
                      4.heightBox,

                      CustomTextField(
                        controller: priceMaxTxtController,
                        hint: priceMax.toString(),
                        fieldVerticalPadding: 8,
                        suffixIcon: Text('USD  ',
                            style: context.text.bodyMedium
                        ),
                      ),


                      // TextField(
                      //   controller: priceMaxTxtController,
                      //   style: context.text.bodyLarge,
                      //   cursorColor: Colors.black,
                      //   decoration: InputDecoration(
                      //     isDense: true,
                      //     contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 10,
                      //         horizontal: 10
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(0.0),
                      //       borderSide: const BorderSide(color: Colors.black), // Border color for the focused state
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(0.0),
                      //       borderSide: const BorderSide(
                      //           color: Colors.black,
                      //           width: .5
                      //       ),
                      //
                      //       // borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     suffix: Container(
                      //       padding: const EdgeInsets.only(
                      //           right: 5
                      //       ),
                      //       child: Text(
                      //           'USD',
                      //           style: context.text.bodyMedium
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],)),


                ],
              )





            ],
          ),
        ) :
        SingleChildScrollView(
          child: Column(
            children: List.generate(widget.filter.values.length, (index) {

              final Map<String, dynamic> input = jsonDecode(widget.filter.values[index].input);


              return Column(
                children: [

                  InkWell(
                    onTap: () {
                      ///---- on clicking make sure this should be included in the Filters List
                      print("${widget.filter.values[index].input}");

                      // input data is like => {"productType":"car"}

                      ///---- First check if categoryLogic.selectedFilters already contains this
                      ///---- if contains then remove that else add this
                      // dynamic keyValueId = jsonDecode(widget.filter.values[index].input);
                      print("before Filters List values => ${categoryLogic.selectedFilters}");


                      // Check if categoryLogic.selectedFilters already contains this filter
                      // dynamic existingFilter = categoryLogic.selectedFilters
                      //     .firstWhere((f) => f == widget.filter.values[index].input);


                      dynamic existingFilter;
                      try {
                        // existingFilter = categoryLogic.selectedFilters.firstWhere(
                        //       (f) => f == jsonDecode(widget.filter.values[index].input),
                        // );

                        // final Map<String, dynamic> input = jsonDecode(widget.filter.values[index].input);

                        existingFilter = categoryLogic.selectedFilters.firstWhere(
                              (f) => const DeepCollectionEquality().equals(f, input),
                        );

                      } catch (e) {
                        existingFilter = null; // Set a default value or do any other necessary handling
                      }

                      print("value of existing filter is $existingFilter");


                      if (existingFilter != null) {
                        // If the filter already exists, remove it from the list
                        categoryLogic.selectedFilters.remove(existingFilter);
                      } else {
                        // If the filter doesn't exist, add it to the list
                        categoryLogic.selectedFilters.add(jsonDecode(widget.filter.values[index].input));
                      }

                      print("=> Current Filters List values => ${categoryLogic.selectedFilters}");

                      categoryLogic.update();


                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: pageMarginHorizontal,
                          vertical: pageMarginVertical - 2.h),
                      decoration:  BoxDecoration(
                        color: categoryLogic.selectedFilters.indexWhere(
                              (f) => const DeepCollectionEquality().equals(f, input),
                        ) != -1 ? AppColors.textFieldBGColor : Colors.white,
                        border: const Border(
                            bottom:
                            BorderSide(color: Color(0xffF2F2F2), width: 1)),
                      ),
                      child:

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [



                          SizedBox(
                            width: 30.w,
                            child: categoryLogic.selectedFilters.indexWhere(
                                  (f) => const DeepCollectionEquality().equals(f, input),
                            ) != -1
                                ?
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.check,
                                color: AppConfig.to.primaryColor.value,
                                size: 16,
                              ),
                            )
                                : const SizedBox(),

                          ),






                          Expanded(
                              flex: 2,
                              child: Text(
                                "${widget.filter.values[index].label}  (${widget.filter.values[index].count})".capitalize!,
                                style: context.text.labelSmall?.copyWith(
                                    color: AppColors.customBlackTextColor, fontSize: 14.sp),
                              )),
                          // const Spacer(),
                          //
                          // ///---- This Check Icon will be shown when this exists in the categoryLogic.selectedFilters
                          //
                          // Expanded(
                          //   child: Align(
                          //       alignment: Alignment.bottomRight,
                          //       child:
                          //       categoryLogic.selectedFilters.indexWhere(
                          //             (f) => const DeepCollectionEquality().equals(f, input),
                          //       ) != -1
                          //           ?
                          //       const Icon(
                          //         Icons.check,
                          //         color: Colors.black,
                          //         size: 16,
                          //       )
                          //           : const SizedBox(),
                          // )
                          // )
                        ],
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "${widget.filter.values[index].label}  (${widget.filter.values[index].count})".capitalize!,
                      //       style: context.text.labelSmall?.copyWith(
                      //           color: AppColors.customBlackTextColor, fontSize: 14),
                      //     ),
                      //
                      //   ],
                      // ),
                    ),
                  ),


                ],
              );

            }),
          ),
        );
      }),
      bottomNavigationBar:   SafeArea(

        child: Padding(
          padding:  EdgeInsets.only(
            bottom: pageMarginVertical
          ),
          child: GlobalElevatedButton(
            text: "apply filter",
            onPressed: () {
//
//
//
              if(widget.filter.id == "filter.v.price"){
// The new price object to be added
                Map<String, dynamic> newPriceObject = {
                  "price": {
                    "min": double.parse(priceMinTxtController.text),
                    "max": double.parse(priceMaxTxtController.text),
                  }
                };

                // Check if an object with the key "price" already exists
                int existingIndex = -1;
                for (int i = 0; i < CategoryLogic.to.selectedFilters.length; i++) {
                  Map<String, dynamic> filter = CategoryLogic.to.selectedFilters[i];
                  if (filter.containsKey("price")) {
                    existingIndex = i;
                    break;
                  }
                }

                if (existingIndex != -1) {
                  // Remove the existing object with the key "price"
                  CategoryLogic.to.selectedFilters.removeAt(existingIndex);
                }

                // Add the new price object
                CategoryLogic.to.selectedFilters.add(newPriceObject);




                // Vibration.vibrate(duration: 100);
                HapticFeedback.lightImpact();
                CategoryLogic.to.fetchProductBasedOnFilters(context: context, isNewId: true);


              } else {
                // Vibration.vibrate(duration: 100);
                HapticFeedback.lightImpact();
                if(CategoryLogic.to.selectedFilters.isEmpty) {
                  CategoryLogic.to.resetFilters();
                  CategoryLogic.to.productFetchService(
                      context: context, id: CategoryLogic.to.currentCategoryId.value, isNewId: true);
                } else {
                  CategoryLogic.to.fetchProductBasedOnFilters(context: context, isNewId: true);
                }
              }



print("current filters list is ${CategoryLogic.to.selectedFilters}");


              Navigator.pop(context);
              Navigator.pop(context);
            },
            isLoading: false,
            applyHorizontalPadding: true,
          ),
        ),
      )



//       Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: pageMarginHorizontal,
//             vertical: pageMarginVertical
//         ),
//         child: AuthBlackButton(
//           buttonTitle: "apply filter",
//           onPressed: () {
//
//
//
//             if(widget.filter.id == "filter.v.price"){
// // The new price object to be added
//               Map<String, dynamic> newPriceObject = {
//                 "price": {
//                   "min": double.parse(priceMinTxtController.text),
//                   "max": double.parse(priceMaxTxtController.text),
//                 }
//               };
//
//               // Check if an object with the key "price" already exists
//               int existingIndex = -1;
//               for (int i = 0; i < CategoryLogic.to.selectedFilters.length; i++) {
//                 Map<String, dynamic> filter = CategoryLogic.to.selectedFilters[i];
//                 if (filter.containsKey("price")) {
//                   existingIndex = i;
//                   break;
//                 }
//               }
//
//               if (existingIndex != -1) {
//                 // Remove the existing object with the key "price"
//                 CategoryLogic.to.selectedFilters.removeAt(existingIndex);
//               }
//
//               // Add the new price object
//               CategoryLogic.to.selectedFilters.add(newPriceObject);
//
//
//
//
//               Vibration.vibrate(duration: 100);
//               CategoryLogic.to.fetchProductBasedOnFilters(context: context, isNewId: true);
//
//
//             } else {
//               Vibration.vibrate(duration: 100);
//               if(CategoryLogic.to.selectedFilters.isEmpty) {
//                 CategoryLogic.to.resetFilters();
//                 CategoryLogic.to.productFetchService(
//                     context: context, id: CategoryLogic.to.currentCategoryId.value, isNewId: true);
//               } else {
//                 CategoryLogic.to.fetchProductBasedOnFilters(context: context, isNewId: true);
//               }
//             }
//
//
//
// print("current filters list is ${CategoryLogic.to.selectedFilters}");
//
//
//             Navigator.pop(context);
//             Navigator.pop(context);
//
//
//             // ProductDetailLogic.to.addProductToCart(context);
//           },
//         ),
//       ),
    );
  }
}