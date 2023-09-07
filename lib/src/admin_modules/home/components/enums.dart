import 'dart:developer';

import '../../../global_controllers/database_controller.dart';

const webDomain = "https://tapify-ansihali1221-gmailcom.vercel.app/";

enum PageURLs { notification, messages, profile, support }

getEnumTypeURL(PageURLs urlType) {
  switch (urlType) {
    case PageURLs.notification:
      log("return this url => ${"$webDomain" "token-login?token=${LocalDatabase.to.box.read("adminSignedInToken")}&page=mobileengage"} ");
      return "$webDomain" "token-login?token=${LocalDatabase.to.box.read("adminSignedInToken")}&page=mobileengage";
      // return "https://shop-o-devahsanabdullah.vercel.app/mobileengage";
    case PageURLs.messages:
      return "$webDomain" "token-login?token=${LocalDatabase.to.box.read("adminSignedInToken")}&page=profilemobile";
    case PageURLs.profile:
      return "$webDomain" "token-login?token=${LocalDatabase.to.box.read("adminSignedInToken")}&page=profilemobile";
    case PageURLs.support:
      return "$webDomain" "token-login?token=${LocalDatabase.to.box.read("adminSignedInToken")}&page=profilemobile";
  }
}
