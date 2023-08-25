import 'dart:convert';

import '../../../api_services/shopify_flutter/models/models.dart';

class ProductInfo {
  late final String id;
  late final String title;
  late final double price;
  late final bool availableForSale;
  late final double compareAtPrice;
  late final String image;
  late final String webUrl;

  ProductInfo(
      {required this.id,
        required this.title,
        required this.price,
        required this.availableForSale,
        required this.compareAtPrice,
        required this.webUrl,
        required this.image});


  factory ProductInfo.fromProduct(Product product) {
    return ProductInfo(
      id: product.id,
      title: product.title,
      price: product.price,
      availableForSale: product.availableForSale,
      compareAtPrice: product.compareAtPrice,
      image: product.image,
      webUrl: "",
    );
  }

  factory ProductInfo.fromCollection(Collection collection) {
    return ProductInfo(
      id: collection.id,
      title: collection.title,
      price: 0.0,
      compareAtPrice: 0.0,
      availableForSale: false,
      image: collection.imageUrl,
      webUrl: "",
    );
  }


  factory ProductInfo.fromJSON(Map<String, dynamic> jsonData) {
    return ProductInfo(
      id: jsonData['id'],
      title: jsonData['title'],
      price: jsonData['price'],
      compareAtPrice: jsonData['compareAtPrice'],
      availableForSale: jsonData['availableForSale'],
      image: jsonData['image'],
      webUrl: jsonData['webUrl'],
    );
  }


  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'compareAtPrice': compareAtPrice,
      'availableForSale': availableForSale,
      'image': image,
      'webUrl': webUrl,
    };
  }
}