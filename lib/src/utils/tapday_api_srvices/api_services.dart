class TapDay {
  // String apiBaseURL = "https://tapyfy.noumanengr.com";



  static String get baseUrl => 'https://tapyfy.noumanengr.com';
  static String get baseUrl1 => 'https://api.tapday.com/';
  static String get baseUrlApi => '$baseUrl/api';
  static String get baseUrlApi1 => '$baseUrl1/api';



  ///----------- Service End Points
  static String adminLoginURL = '$baseUrlApi/auth/login';
  static String adminLoginURL1 = '$baseUrlApi1/auth/login';
  static String adminCreateClientURL =
      '$baseUrlApi/api/android/clients/create';
  static String adminCreateOrderURL =
      '$baseUrlApi/android/orders/create';
  static String adminStructureViewURL =
      '$baseUrlApi/api/android/structure/view';
  static String adminSplashURL =
      '$baseUrlApi/android/appSetting/show?store=$storeName';


  ///----------- App Static information -----------
  static const String storeName = 'FillinxSolutions';
  static const String adminEmail = 'fillinxsolutions@tapify.com';
  static const String adminPassword = 'Y0aBQ0op9X23';


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