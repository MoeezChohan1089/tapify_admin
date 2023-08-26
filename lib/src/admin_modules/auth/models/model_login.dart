/// success : true
/// data : {"id":2,"first_name":"Muhammad","last_name":"Hamza","email":"hamza@gmail.com","email_verified_at":null,"original_password":null,"type":"Web","image":"https://tapyfy.noumanengr.com/upload/images/profile/avatar.png","status":"Active","created_at":"2023-08-24T15:10:22.000000Z","updated_at":"2023-08-24T15:10:22.000000Z","token":"12|SxG0WOzsin0dweIwAi2zbOcI5UQDqymUPTv1MhYP","shops":[{"id":1,"user_id":"2","app_user_id":"3","session_id":"1","name":"FillinxSolutions","email":"hamza@fillinxsolutions.com","customer_email":"hamza@fillinxsolutions.com","domain":"fillinxsolutions.myshopify.com","shop_owner":"Fillinx Solutions","plan_display_name":"Developer Preview","myshopify_domain":"fillinxsolutions.myshopify.com","province":null,"country":"PK","address1":null,"zip":null,"city":null,"phone":null,"latitude":null,"longitude":null,"primary_locale":"en","country_code":"PK","country_name":"Pakistan","currency":"USD","primary_location_id":"74643669304","created_at":"2023-08-24T15:10:22.000000Z","updated_at":"2023-08-24T15:10:22.000000Z","access_token":"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","trial":{"id":1,"shop_id":"1","status":"Active","start_date":"2023-08-24","end_date":"2023-09-08","created_at":"2023-08-24T15:11:21.000000Z","updated_at":"2023-08-24T15:11:21.000000Z"}}]}
/// message : "User login successfully."

class ModelLogin {
  ModelLogin({
      bool? success, 
      Data? data, 
      String? message,}){
    _success = success;
    _data = data;
    _message = message;
}

  ModelLogin.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }
  bool? _success;
  Data? _data;
  String? _message;
ModelLogin copyWith({  bool? success,
  Data? data,
  String? message,
}) => ModelLogin(  success: success ?? _success,
  data: data ?? _data,
  message: message ?? _message,
);
  bool? get success => _success;
  Data? get data => _data;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }

}

/// id : 2
/// first_name : "Muhammad"
/// last_name : "Hamza"
/// email : "hamza@gmail.com"
/// email_verified_at : null
/// original_password : null
/// type : "Web"
/// image : "https://tapyfy.noumanengr.com/upload/images/profile/avatar.png"
/// status : "Active"
/// created_at : "2023-08-24T15:10:22.000000Z"
/// updated_at : "2023-08-24T15:10:22.000000Z"
/// token : "12|SxG0WOzsin0dweIwAi2zbOcI5UQDqymUPTv1MhYP"
/// shops : [{"id":1,"user_id":"2","app_user_id":"3","session_id":"1","name":"FillinxSolutions","email":"hamza@fillinxsolutions.com","customer_email":"hamza@fillinxsolutions.com","domain":"fillinxsolutions.myshopify.com","shop_owner":"Fillinx Solutions","plan_display_name":"Developer Preview","myshopify_domain":"fillinxsolutions.myshopify.com","province":null,"country":"PK","address1":null,"zip":null,"city":null,"phone":null,"latitude":null,"longitude":null,"primary_locale":"en","country_code":"PK","country_name":"Pakistan","currency":"USD","primary_location_id":"74643669304","created_at":"2023-08-24T15:10:22.000000Z","updated_at":"2023-08-24T15:10:22.000000Z","access_token":"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","trial":{"id":1,"shop_id":"1","status":"Active","start_date":"2023-08-24","end_date":"2023-09-08","created_at":"2023-08-24T15:11:21.000000Z","updated_at":"2023-08-24T15:11:21.000000Z"}}]

class Data {
  Data({
      num? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      dynamic emailVerifiedAt, 
      dynamic originalPassword, 
      String? type, 
      String? image, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? token, 
      List<Shops>? shops,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _originalPassword = originalPassword;
    _type = type;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _token = token;
    _shops = shops;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _originalPassword = json['original_password'];
    _type = json['type'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _token = json['token'];
    if (json['shops'] != null) {
      _shops = [];
      json['shops'].forEach((v) {
        _shops?.add(Shops.fromJson(v));
      });
    }
  }
  num? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  dynamic _emailVerifiedAt;
  dynamic _originalPassword;
  String? _type;
  String? _image;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _token;
  List<Shops>? _shops;
Data copyWith({  num? id,
  String? firstName,
  String? lastName,
  String? email,
  dynamic emailVerifiedAt,
  dynamic originalPassword,
  String? type,
  String? image,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? token,
  List<Shops>? shops,
}) => Data(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
  originalPassword: originalPassword ?? _originalPassword,
  type: type ?? _type,
  image: image ?? _image,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  token: token ?? _token,
  shops: shops ?? _shops,
);
  num? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  dynamic get originalPassword => _originalPassword;
  String? get type => _type;
  String? get image => _image;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get token => _token;
  List<Shops>? get shops => _shops;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['email_verified_at'] = _emailVerifiedAt;
    map['original_password'] = _originalPassword;
    map['type'] = _type;
    map['image'] = _image;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['token'] = _token;
    if (_shops != null) {
      map['shops'] = _shops?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// user_id : "2"
/// app_user_id : "3"
/// session_id : "1"
/// name : "FillinxSolutions"
/// email : "hamza@fillinxsolutions.com"
/// customer_email : "hamza@fillinxsolutions.com"
/// domain : "fillinxsolutions.myshopify.com"
/// shop_owner : "Fillinx Solutions"
/// plan_display_name : "Developer Preview"
/// myshopify_domain : "fillinxsolutions.myshopify.com"
/// province : null
/// country : "PK"
/// address1 : null
/// zip : null
/// city : null
/// phone : null
/// latitude : null
/// longitude : null
/// primary_locale : "en"
/// country_code : "PK"
/// country_name : "Pakistan"
/// currency : "USD"
/// primary_location_id : "74643669304"
/// created_at : "2023-08-24T15:10:22.000000Z"
/// updated_at : "2023-08-24T15:10:22.000000Z"
/// access_token : "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"
/// trial : {"id":1,"shop_id":"1","status":"Active","start_date":"2023-08-24","end_date":"2023-09-08","created_at":"2023-08-24T15:11:21.000000Z","updated_at":"2023-08-24T15:11:21.000000Z"}

class Shops {
  Shops({
      num? id, 
      String? userId, 
      String? appUserId, 
      String? sessionId, 
      String? name, 
      String? email, 
      String? customerEmail, 
      String? domain, 
      String? shopOwner, 
      String? planDisplayName, 
      String? myshopifyDomain, 
      dynamic province, 
      String? country, 
      dynamic address1, 
      dynamic zip, 
      dynamic city, 
      dynamic phone, 
      dynamic latitude, 
      dynamic longitude, 
      String? primaryLocale, 
      String? countryCode, 
      String? countryName, 
      String? currency, 
      String? primaryLocationId, 
      String? createdAt, 
      String? updatedAt, 
      String? accessToken, 
      Trial? trial,}){
    _id = id;
    _userId = userId;
    _appUserId = appUserId;
    _sessionId = sessionId;
    _name = name;
    _email = email;
    _customerEmail = customerEmail;
    _domain = domain;
    _shopOwner = shopOwner;
    _planDisplayName = planDisplayName;
    _myshopifyDomain = myshopifyDomain;
    _province = province;
    _country = country;
    _address1 = address1;
    _zip = zip;
    _city = city;
    _phone = phone;
    _latitude = latitude;
    _longitude = longitude;
    _primaryLocale = primaryLocale;
    _countryCode = countryCode;
    _countryName = countryName;
    _currency = currency;
    _primaryLocationId = primaryLocationId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _accessToken = accessToken;
    _trial = trial;
}

  Shops.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _appUserId = json['app_user_id'];
    _sessionId = json['session_id'];
    _name = json['name'];
    _email = json['email'];
    _customerEmail = json['customer_email'];
    _domain = json['domain'];
    _shopOwner = json['shop_owner'];
    _planDisplayName = json['plan_display_name'];
    _myshopifyDomain = json['myshopify_domain'];
    _province = json['province'];
    _country = json['country'];
    _address1 = json['address1'];
    _zip = json['zip'];
    _city = json['city'];
    _phone = json['phone'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _primaryLocale = json['primary_locale'];
    _countryCode = json['country_code'];
    _countryName = json['country_name'];
    _currency = json['currency'];
    _primaryLocationId = json['primary_location_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _accessToken = json['access_token'];
    _trial = json['trial'] != null ? Trial.fromJson(json['trial']) : null;
  }
  num? _id;
  String? _userId;
  String? _appUserId;
  String? _sessionId;
  String? _name;
  String? _email;
  String? _customerEmail;
  String? _domain;
  String? _shopOwner;
  String? _planDisplayName;
  String? _myshopifyDomain;
  dynamic _province;
  String? _country;
  dynamic _address1;
  dynamic _zip;
  dynamic _city;
  dynamic _phone;
  dynamic _latitude;
  dynamic _longitude;
  String? _primaryLocale;
  String? _countryCode;
  String? _countryName;
  String? _currency;
  String? _primaryLocationId;
  String? _createdAt;
  String? _updatedAt;
  String? _accessToken;
  Trial? _trial;
Shops copyWith({  num? id,
  String? userId,
  String? appUserId,
  String? sessionId,
  String? name,
  String? email,
  String? customerEmail,
  String? domain,
  String? shopOwner,
  String? planDisplayName,
  String? myshopifyDomain,
  dynamic province,
  String? country,
  dynamic address1,
  dynamic zip,
  dynamic city,
  dynamic phone,
  dynamic latitude,
  dynamic longitude,
  String? primaryLocale,
  String? countryCode,
  String? countryName,
  String? currency,
  String? primaryLocationId,
  String? createdAt,
  String? updatedAt,
  String? accessToken,
  Trial? trial,
}) => Shops(  id: id ?? _id,
  userId: userId ?? _userId,
  appUserId: appUserId ?? _appUserId,
  sessionId: sessionId ?? _sessionId,
  name: name ?? _name,
  email: email ?? _email,
  customerEmail: customerEmail ?? _customerEmail,
  domain: domain ?? _domain,
  shopOwner: shopOwner ?? _shopOwner,
  planDisplayName: planDisplayName ?? _planDisplayName,
  myshopifyDomain: myshopifyDomain ?? _myshopifyDomain,
  province: province ?? _province,
  country: country ?? _country,
  address1: address1 ?? _address1,
  zip: zip ?? _zip,
  city: city ?? _city,
  phone: phone ?? _phone,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  primaryLocale: primaryLocale ?? _primaryLocale,
  countryCode: countryCode ?? _countryCode,
  countryName: countryName ?? _countryName,
  currency: currency ?? _currency,
  primaryLocationId: primaryLocationId ?? _primaryLocationId,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  accessToken: accessToken ?? _accessToken,
  trial: trial ?? _trial,
);
  num? get id => _id;
  String? get userId => _userId;
  String? get appUserId => _appUserId;
  String? get sessionId => _sessionId;
  String? get name => _name;
  String? get email => _email;
  String? get customerEmail => _customerEmail;
  String? get domain => _domain;
  String? get shopOwner => _shopOwner;
  String? get planDisplayName => _planDisplayName;
  String? get myshopifyDomain => _myshopifyDomain;
  dynamic get province => _province;
  String? get country => _country;
  dynamic get address1 => _address1;
  dynamic get zip => _zip;
  dynamic get city => _city;
  dynamic get phone => _phone;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
  String? get primaryLocale => _primaryLocale;
  String? get countryCode => _countryCode;
  String? get countryName => _countryName;
  String? get currency => _currency;
  String? get primaryLocationId => _primaryLocationId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get accessToken => _accessToken;
  Trial? get trial => _trial;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['app_user_id'] = _appUserId;
    map['session_id'] = _sessionId;
    map['name'] = _name;
    map['email'] = _email;
    map['customer_email'] = _customerEmail;
    map['domain'] = _domain;
    map['shop_owner'] = _shopOwner;
    map['plan_display_name'] = _planDisplayName;
    map['myshopify_domain'] = _myshopifyDomain;
    map['province'] = _province;
    map['country'] = _country;
    map['address1'] = _address1;
    map['zip'] = _zip;
    map['city'] = _city;
    map['phone'] = _phone;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['primary_locale'] = _primaryLocale;
    map['country_code'] = _countryCode;
    map['country_name'] = _countryName;
    map['currency'] = _currency;
    map['primary_location_id'] = _primaryLocationId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['access_token'] = _accessToken;
    if (_trial != null) {
      map['trial'] = _trial?.toJson();
    }
    return map;
  }

}

/// id : 1
/// shop_id : "1"
/// status : "Active"
/// start_date : "2023-08-24"
/// end_date : "2023-09-08"
/// created_at : "2023-08-24T15:11:21.000000Z"
/// updated_at : "2023-08-24T15:11:21.000000Z"

class Trial {
  Trial({
      num? id, 
      String? shopId, 
      String? status, 
      String? startDate, 
      String? endDate, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _shopId = shopId;
    _status = status;
    _startDate = startDate;
    _endDate = endDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Trial.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _status = json['status'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _shopId;
  String? _status;
  String? _startDate;
  String? _endDate;
  String? _createdAt;
  String? _updatedAt;
Trial copyWith({  num? id,
  String? shopId,
  String? status,
  String? startDate,
  String? endDate,
  String? createdAt,
  String? updatedAt,
}) => Trial(  id: id ?? _id,
  shopId: shopId ?? _shopId,
  status: status ?? _status,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get shopId => _shopId;
  String? get status => _status;
  String? get startDate => _startDate;
  String? get endDate => _endDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['status'] = _status;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}