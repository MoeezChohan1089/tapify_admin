import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tapify/src/utils/extensions.dart';
import 'package:tapify/src/utils/tapday_api_srvices/api_services.dart';

import 'app_config/config_controller.dart';

class CurrencyController extends GetxController {

  static CurrencyController get to => Get.find();

  RxString selectedCurrency = "USD".obs;
  RxBool multiCurrencyEnabled = false.obs;
  Rx<Map<String, dynamic>> exchangeRates = Rx<Map<String, dynamic>>({});

  // RxMap exchangeRates = {}.obs;
  List get exchangeRateOptions =>
      exchangeRates.value.keys.toList(growable: false);


  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //
  //   ///----- implement API logic here
  //   fetchExchangeRates();
  // }


  setMultiCurrency(){
    multiCurrencyEnabled.value = AppConfig.to.appSettingsStoreSettings["allowMultiCurrency"];
    if(multiCurrencyEnabled.value) {
      fetchExchangeRates();
    }

  }



  Future<void> fetchExchangeRates() async {
    try {
      var response = await Dio().get(
        '${TapDay.currencyURL}/${selectedCurrency.value}',
      );
      exchangeRates.value = response.data['conversion_rates'];
      log("====> SUCCESS exchange rates fetched  <====");
    } catch (e) {
      log("====> ERROR fetching exchange rates $e  <====");

    }
  }

  String getConvertedPrice({required num priceAmount, bool includeSign = true}) {
    String currencySymbol = '';
    switch (selectedCurrency.value) {
      case 'USD':
        currencySymbol = '\$';
        break;
      case 'EUR':
        currencySymbol = '€';
        break;
      case 'GBP':
        currencySymbol = '£';
        break;
      default:
        currencySymbol = selectedCurrency.value;
    }

    num convertedValue;
    if (multiCurrencyEnabled.value) {
      // Apply the currency conversion using exchangeRates.value
      convertedValue = priceAmount * exchangeRates.value[selectedCurrency.value];
    } else {
      // Use the original priceAmount without conversion
      convertedValue = priceAmount;
    }

    String formattedValue = convertedValue.toStringAsFixed(2);
    if (formattedValue.endsWith('.00')) {
      formattedValue = formattedValue.split('.')[0];
    }

    String formattedWithCommas = formattedValue.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );

    // Check if currencySymbol is from the default case
    bool isDefaultCurrency =
        selectedCurrency.value != 'USD' && selectedCurrency.value != 'EUR' && selectedCurrency.value != 'GBP';

    // Return the formatted string with or without space
    return includeSign
        ? isDefaultCurrency
        ? "$currencySymbol $formattedWithCommas"
        : "$currencySymbol$formattedWithCommas"
        : formattedWithCommas;
  }









}