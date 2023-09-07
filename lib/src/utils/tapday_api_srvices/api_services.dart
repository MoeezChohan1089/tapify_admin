class TapDay {
  static String get baseUrl => 'https://api.tapday.com';
  // static String get baseUrl => 'https://tapyfy.noumanengr.com';
  static String get baseUrlApi => '$baseUrl/api';

  ///----------- Admin Related APIs
  static String adminShopViewURL = '$baseUrlApi/shop/structure/show';
  static String getShopListURL = '$baseUrlApi/shop/list';

  ///----------- Service End Points
  static String loginURL = '$baseUrlApi/auth/login';
  static String createClientURL = '$baseUrlApi/api/android/clients/create';
  static String createOrderURL = '$baseUrlApi/android/orders/create';
  static String clientStructureViewURL =
      '$baseUrlApi/api/android/structure/view';
  // static String clientSplashImageURL = '$baseUrlApi/android/appSetting/show';
  static String clientSplashImageURL = '$baseUrlApi/android/settings/app/show';

  ///----------- App Static information -----------
  // static const String storeName = 'FillinxSolutions';
  // static const String adminEmail = 'fillinxsolutions@tapify.com';
  // static const String adminPassword = 'Y0aBQ0op9X23';

  static const vendorsFCMTopic = 'tapday-vendors';

  static const storeFrontAccessToken = 'd0d94fa9247bc280d6054076506d28a7';
  static const shopNameUrl = 'fillinxsolutions.myshopify.com';

  ///----------- Reviews - Judge Me
  static String judgeMeReviewURL = 'https://judge.me/api/v1/reviews';
  //--- Judge Me Token Reviews
  static const String apiTokenJudgeMe = 'KZBuvDt_MXzzO0qM2HKkd8hcLlU';

  // currency----
  static String currencyURL =
      'https://v6.exchangerate-api.com/v6/0f58cee149c8e149f3f44457/latest';
}
