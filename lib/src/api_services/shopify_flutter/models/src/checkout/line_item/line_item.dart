// import 'package:tapify_admin/src/api_services/shopify_flutter/models/src/product/product.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../checkout/attribute/attribute.dart';
import '../../checkout/product_variant_checkout/product_variant_checkout.dart';
import '../../order/discount_allocations/discount_allocations.dart';

part 'line_item.freezed.dart';
part 'line_item.g.dart';

@freezed
class LineItem with _$LineItem {
  const LineItem._();
  factory LineItem({
    required String title,
    required int quantity,
    required List<DiscountAllocations> discountAllocations,
    @Default([]) List<Attribute> customAttributes,
    String? variantId,
    String? id,
    ProductVariantCheckout? variant,
  }) = _LineItem;

  static LineItem fromGraphJson(Map<String, dynamic> json) {
    Map<String, dynamic> nodeJson = json['node'] ?? {};

    return LineItem(
      id: nodeJson['id'],
      quantity: nodeJson['quantity'],
      variant: nodeJson['variant'] != null
          ? ProductVariantCheckout.fromJson(nodeJson['variant'])
          : null,
      title: nodeJson['title'],
      discountAllocations: nodeJson['discountAllocations'] == null
          ? []
          : (nodeJson['discountAllocations'] as List)
              .map((e) => DiscountAllocations.fromJson(e))
              .toList(),
      variantId: nodeJson['variant'] != null
          ? ProductVariantCheckout.fromJson(nodeJson['variant']).id
          : null,
    );
  }

  factory LineItem.fromJson(Map<String, dynamic> json) =>
      _$LineItemFromJson(json);
}
