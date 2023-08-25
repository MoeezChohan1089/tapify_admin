/// current_page : 1
/// per_page : 10
/// reviews : [{"id":407358111,"title":"aaaaa","body":"safsfsfsfs","rating":5,"product_external_id":8033111867704,"reviewer":{"id":88261286,"email":"ahmad","name":"Anonymous","phone":"null","accepts_marketing":true,"tags":["Wrote Judge.me web review"]},"source":"web","curated":"not-yet","hidden":false,"verified":"nothing","featured":false,"created_at":"2023-05-03T06:21:11+00:00","updated_at":"2023-05-03T06:21:40+00:00","has_published_pictures":false,"has_published_videos":false,"product_title":"Example Pants","product_handle":"example-pants"}]

class ModelReviewsList {
  ModelReviewsList({
    num? currentPage,
    num? perPage,
    List<Reviews>? reviews,}){
    _currentPage = currentPage;
    _perPage = perPage;
    _reviews = reviews;
  }

  ModelReviewsList.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _perPage = json['per_page'];
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
  }
  num? _currentPage;
  num? _perPage;
  List<Reviews>? _reviews;
  ModelReviewsList copyWith({  num? currentPage,
    num? perPage,
    List<Reviews>? reviews,
  }) => ModelReviewsList(  currentPage: currentPage ?? _currentPage,
    perPage: perPage ?? _perPage,
    reviews: reviews ?? _reviews,
  );
  num? get currentPage => _currentPage;
  num? get perPage => _perPage;
  List<Reviews>? get reviews => _reviews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['per_page'] = _perPage;
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 407358111
/// title : "aaaaa"
/// body : "safsfsfsfs"
/// rating : 5
/// product_external_id : 8033111867704
/// reviewer : {"id":88261286,"email":"ahmad","name":"Anonymous","phone":"null","accepts_marketing":true,"tags":["Wrote Judge.me web review"]}
/// source : "web"
/// curated : "not-yet"
/// hidden : false
/// verified : "nothing"
/// featured : false
/// created_at : "2023-05-03T06:21:11+00:00"
/// updated_at : "2023-05-03T06:21:40+00:00"
/// has_published_pictures : false
/// has_published_videos : false
/// product_title : "Example Pants"
/// product_handle : "example-pants"

class Reviews {
  Reviews({
    num? id,
    String? title,
    String? body,
    num? rating,
    num? productExternalId,
    Reviewer? reviewer,
    String? source,
    String? curated,
    bool? hidden,
    String? verified,
    bool? featured,
    String? createdAt,
    String? updatedAt,
    bool? hasPublishedPictures,
    bool? hasPublishedVideos,
    String? productTitle,
    String? productHandle,}){
    _id = id;
    _title = title;
    _body = body;
    _rating = rating;
    _productExternalId = productExternalId;
    _reviewer = reviewer;
    _source = source;
    _curated = curated;
    _hidden = hidden;
    _verified = verified;
    _featured = featured;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _hasPublishedPictures = hasPublishedPictures;
    _hasPublishedVideos = hasPublishedVideos;
    _productTitle = productTitle;
    _productHandle = productHandle;
  }

  Reviews.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _rating = json['rating'];
    _productExternalId = json['product_external_id'];
    _reviewer = json['reviewer'] != null ? Reviewer.fromJson(json['reviewer']) : null;
    _source = json['source'];
    _curated = json['curated'];
    _hidden = json['hidden'];
    _verified = json['verified'];
    _featured = json['featured'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _hasPublishedPictures = json['has_published_pictures'];
    _hasPublishedVideos = json['has_published_videos'];
    _productTitle = json['product_title'];
    _productHandle = json['product_handle'];
  }
  num? _id;
  String? _title;
  String? _body;
  num? _rating;
  num? _productExternalId;
  Reviewer? _reviewer;
  String? _source;
  String? _curated;
  bool? _hidden;
  String? _verified;
  bool? _featured;
  String? _createdAt;
  String? _updatedAt;
  bool? _hasPublishedPictures;
  bool? _hasPublishedVideos;
  String? _productTitle;
  String? _productHandle;
  Reviews copyWith({  num? id,
    String? title,
    String? body,
    num? rating,
    num? productExternalId,
    Reviewer? reviewer,
    String? source,
    String? curated,
    bool? hidden,
    String? verified,
    bool? featured,
    String? createdAt,
    String? updatedAt,
    bool? hasPublishedPictures,
    bool? hasPublishedVideos,
    String? productTitle,
    String? productHandle,
  }) => Reviews(  id: id ?? _id,
    title: title ?? _title,
    body: body ?? _body,
    rating: rating ?? _rating,
    productExternalId: productExternalId ?? _productExternalId,
    reviewer: reviewer ?? _reviewer,
    source: source ?? _source,
    curated: curated ?? _curated,
    hidden: hidden ?? _hidden,
    verified: verified ?? _verified,
    featured: featured ?? _featured,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    hasPublishedPictures: hasPublishedPictures ?? _hasPublishedPictures,
    hasPublishedVideos: hasPublishedVideos ?? _hasPublishedVideos,
    productTitle: productTitle ?? _productTitle,
    productHandle: productHandle ?? _productHandle,
  );
  num? get id => _id;
  String? get title => _title;
  String? get body => _body;
  num? get rating => _rating;
  num? get productExternalId => _productExternalId;
  Reviewer? get reviewer => _reviewer;
  String? get source => _source;
  String? get curated => _curated;
  bool? get hidden => _hidden;
  String? get verified => _verified;
  bool? get featured => _featured;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  bool? get hasPublishedPictures => _hasPublishedPictures;
  bool? get hasPublishedVideos => _hasPublishedVideos;
  String? get productTitle => _productTitle;
  String? get productHandle => _productHandle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    map['rating'] = _rating;
    map['product_external_id'] = _productExternalId;
    if (_reviewer != null) {
      map['reviewer'] = _reviewer?.toJson();
    }
    map['source'] = _source;
    map['curated'] = _curated;
    map['hidden'] = _hidden;
    map['verified'] = _verified;
    map['featured'] = _featured;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['has_published_pictures'] = _hasPublishedPictures;
    map['has_published_videos'] = _hasPublishedVideos;
    map['product_title'] = _productTitle;
    map['product_handle'] = _productHandle;
    return map;
  }

}

/// id : 88261286
/// email : "ahmad"
/// name : "Anonymous"
/// phone : "null"
/// accepts_marketing : true
/// tags : ["Wrote Judge.me web review"]

class Reviewer {
  Reviewer({
    num? id,
    String? email,
    String? name,
    String? phone,
    bool? acceptsMarketing,
    List<String>? tags,}){
    _id = id;
    _email = email;
    _name = name;
    _phone = phone;
    _acceptsMarketing = acceptsMarketing;
    _tags = tags;
  }

  Reviewer.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _name = json['name'];
    _phone = json['phone'];
    _acceptsMarketing = json['accepts_marketing'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
  num? _id;
  String? _email;
  String? _name;
  String? _phone;
  bool? _acceptsMarketing;
  List<String>? _tags;
  Reviewer copyWith({  num? id,
    String? email,
    String? name,
    String? phone,
    bool? acceptsMarketing,
    List<String>? tags,
  }) => Reviewer(  id: id ?? _id,
    email: email ?? _email,
    name: name ?? _name,
    phone: phone ?? _phone,
    acceptsMarketing: acceptsMarketing ?? _acceptsMarketing,
    tags: tags ?? _tags,
  );
  num? get id => _id;
  String? get email => _email;
  String? get name => _name;
  String? get phone => _phone;
  bool? get acceptsMarketing => _acceptsMarketing;
  List<String>? get tags => _tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['name'] = _name;
    map['phone'] = _phone;
    map['accepts_marketing'] = _acceptsMarketing;
    map['tags'] = _tags;
    return map;
  }

}