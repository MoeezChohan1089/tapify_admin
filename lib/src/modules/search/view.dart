import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/extensions.dart';

import '../../custom_widgets/custom_app_bar.dart';
import '../../utils/constants/assets.dart';
import '../../utils/skeleton_loaders/shimmerLoader.dart';
import 'components/collections_list.dart';
import 'components/recent_searches.dart';
import 'components/search_bar.dart';
import 'components/search_results.dart';
import 'components/suggested_products.dart';
import 'logic.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final logic = Get.put(SearchLogic());

  final state = Get.find<SearchLogic>().state;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //---- Reset the Values
      final reset = Get.find<SearchLogic>().resetValues();
    });
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'search',
        ),
        body: Column(children: [
           SearchFieldBar(),
          Obx(() {
            return logic.showSearchedResult.isTrue
                ? logic.isLoading.isTrue ?   Expanded(
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height-10,
                  child: LoadingListPage()),
                )    :   const SearchedResult()
                :  Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    RecentSearches(),
                    CollectionsList(),
                    SuggestedProductsList(),
                  ],
                ),
              ),
            );
          }),




        ]),
      ),
    );
  }
}