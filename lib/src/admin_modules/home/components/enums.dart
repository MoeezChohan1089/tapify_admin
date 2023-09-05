enum PageURLs { notification, messages, profile, support }

getEnumTypeURL(PageURLs urlType) {
  switch (urlType) {
    case PageURLs.notification:
      return "https://shop-o-devahsanabdullah.vercel.app/mobileengage";
    case PageURLs.messages:
      return "https://shop-o-devahsanabdullah.vercel.app/mobileengage";
    case PageURLs.profile:
      return "https://shop-o-devahsanabdullah.vercel.app/newProfile";
    case PageURLs.support:
      return "https://shop-o-devahsanabdullah.vercel.app/mobileengage";
  }
}
