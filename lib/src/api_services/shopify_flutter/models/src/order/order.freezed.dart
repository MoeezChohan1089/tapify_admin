// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  String? get id => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get currencyCode => throw _privateConstructorUsedError;
  String? get customerUrl => throw _privateConstructorUsedError;
  LineItemsOrder? get lineItems => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get orderNumber => throw _privateConstructorUsedError;
  String? get processedAt => throw _privateConstructorUsedError;
  ShippingAddress get shippingAddress => throw _privateConstructorUsedError;
  ShippingAddress? get billingAddress => throw _privateConstructorUsedError;
  String? get statusUrl => throw _privateConstructorUsedError;
  PriceV2 get subtotalPriceV2 => throw _privateConstructorUsedError;
  PriceV2 get totalPriceV2 => throw _privateConstructorUsedError;
  PriceV2 get totalShippingPriceV2 => throw _privateConstructorUsedError;
  PriceV2 get totalTaxV2 => throw _privateConstructorUsedError;
  String? get financialStatus => throw _privateConstructorUsedError;
  String? get fulfillmentStatus => throw _privateConstructorUsedError;
  PriceV2? get totalRefundedV2 => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get cursor => throw _privateConstructorUsedError;
  List<SuccessfulFullfilment>? get successfulFulfillments =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {String? id,
      String? email,
      String? currencyCode,
      String? customerUrl,
      LineItemsOrder? lineItems,
      String? name,
      int? orderNumber,
      String? processedAt,
      ShippingAddress shippingAddress,
      ShippingAddress? billingAddress,
      String? statusUrl,
      PriceV2 subtotalPriceV2,
      PriceV2 totalPriceV2,
      PriceV2 totalShippingPriceV2,
      PriceV2 totalTaxV2,
      String? financialStatus,
      String? fulfillmentStatus,
      PriceV2? totalRefundedV2,
      String? phone,
      String? cursor,
      List<SuccessfulFullfilment>? successfulFulfillments});

  $LineItemsOrderCopyWith<$Res>? get lineItems;
  $ShippingAddressCopyWith<$Res> get shippingAddress;
  $ShippingAddressCopyWith<$Res>? get billingAddress;
  $PriceV2CopyWith<$Res> get subtotalPriceV2;
  $PriceV2CopyWith<$Res> get totalPriceV2;
  $PriceV2CopyWith<$Res> get totalShippingPriceV2;
  $PriceV2CopyWith<$Res> get totalTaxV2;
  $PriceV2CopyWith<$Res>? get totalRefundedV2;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? currencyCode = freezed,
    Object? customerUrl = freezed,
    Object? lineItems = freezed,
    Object? name = freezed,
    Object? orderNumber = freezed,
    Object? processedAt = freezed,
    Object? shippingAddress = null,
    Object? billingAddress = freezed,
    Object? statusUrl = freezed,
    Object? subtotalPriceV2 = null,
    Object? totalPriceV2 = null,
    Object? totalShippingPriceV2 = null,
    Object? totalTaxV2 = null,
    Object? financialStatus = freezed,
    Object? fulfillmentStatus = freezed,
    Object? totalRefundedV2 = freezed,
    Object? phone = freezed,
    Object? cursor = freezed,
    Object? successfulFulfillments = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      customerUrl: freezed == customerUrl
          ? _value.customerUrl
          : customerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lineItems: freezed == lineItems
          ? _value.lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as LineItemsOrder?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNumber: freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: null == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as ShippingAddress,
      billingAddress: freezed == billingAddress
          ? _value.billingAddress
          : billingAddress // ignore: cast_nullable_to_non_nullable
              as ShippingAddress?,
      statusUrl: freezed == statusUrl
          ? _value.statusUrl
          : statusUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      subtotalPriceV2: null == subtotalPriceV2
          ? _value.subtotalPriceV2
          : subtotalPriceV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalPriceV2: null == totalPriceV2
          ? _value.totalPriceV2
          : totalPriceV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalShippingPriceV2: null == totalShippingPriceV2
          ? _value.totalShippingPriceV2
          : totalShippingPriceV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalTaxV2: null == totalTaxV2
          ? _value.totalTaxV2
          : totalTaxV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      financialStatus: freezed == financialStatus
          ? _value.financialStatus
          : financialStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      fulfillmentStatus: freezed == fulfillmentStatus
          ? _value.fulfillmentStatus
          : fulfillmentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      totalRefundedV2: freezed == totalRefundedV2
          ? _value.totalRefundedV2
          : totalRefundedV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      cursor: freezed == cursor
          ? _value.cursor
          : cursor // ignore: cast_nullable_to_non_nullable
              as String?,
      successfulFulfillments: freezed == successfulFulfillments
          ? _value.successfulFulfillments
          : successfulFulfillments // ignore: cast_nullable_to_non_nullable
              as List<SuccessfulFullfilment>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LineItemsOrderCopyWith<$Res>? get lineItems {
    if (_value.lineItems == null) {
      return null;
    }

    return $LineItemsOrderCopyWith<$Res>(_value.lineItems!, (value) {
      return _then(_value.copyWith(lineItems: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShippingAddressCopyWith<$Res> get shippingAddress {
    return $ShippingAddressCopyWith<$Res>(_value.shippingAddress, (value) {
      return _then(_value.copyWith(shippingAddress: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShippingAddressCopyWith<$Res>? get billingAddress {
    if (_value.billingAddress == null) {
      return null;
    }

    return $ShippingAddressCopyWith<$Res>(_value.billingAddress!, (value) {
      return _then(_value.copyWith(billingAddress: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get subtotalPriceV2 {
    return $PriceV2CopyWith<$Res>(_value.subtotalPriceV2, (value) {
      return _then(_value.copyWith(subtotalPriceV2: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get totalPriceV2 {
    return $PriceV2CopyWith<$Res>(_value.totalPriceV2, (value) {
      return _then(_value.copyWith(totalPriceV2: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get totalShippingPriceV2 {
    return $PriceV2CopyWith<$Res>(_value.totalShippingPriceV2, (value) {
      return _then(_value.copyWith(totalShippingPriceV2: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res> get totalTaxV2 {
    return $PriceV2CopyWith<$Res>(_value.totalTaxV2, (value) {
      return _then(_value.copyWith(totalTaxV2: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceV2CopyWith<$Res>? get totalRefundedV2 {
    if (_value.totalRefundedV2 == null) {
      return null;
    }

    return $PriceV2CopyWith<$Res>(_value.totalRefundedV2!, (value) {
      return _then(_value.copyWith(totalRefundedV2: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$_OrderCopyWith(_$_Order value, $Res Function(_$_Order) then) =
      __$$_OrderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? email,
      String? currencyCode,
      String? customerUrl,
      LineItemsOrder? lineItems,
      String? name,
      int? orderNumber,
      String? processedAt,
      ShippingAddress shippingAddress,
      ShippingAddress? billingAddress,
      String? statusUrl,
      PriceV2 subtotalPriceV2,
      PriceV2 totalPriceV2,
      PriceV2 totalShippingPriceV2,
      PriceV2 totalTaxV2,
      String? financialStatus,
      String? fulfillmentStatus,
      PriceV2? totalRefundedV2,
      String? phone,
      String? cursor,
      List<SuccessfulFullfilment>? successfulFulfillments});

  @override
  $LineItemsOrderCopyWith<$Res>? get lineItems;
  @override
  $ShippingAddressCopyWith<$Res> get shippingAddress;
  @override
  $ShippingAddressCopyWith<$Res>? get billingAddress;
  @override
  $PriceV2CopyWith<$Res> get subtotalPriceV2;
  @override
  $PriceV2CopyWith<$Res> get totalPriceV2;
  @override
  $PriceV2CopyWith<$Res> get totalShippingPriceV2;
  @override
  $PriceV2CopyWith<$Res> get totalTaxV2;
  @override
  $PriceV2CopyWith<$Res>? get totalRefundedV2;
}

/// @nodoc
class __$$_OrderCopyWithImpl<$Res> extends _$OrderCopyWithImpl<$Res, _$_Order>
    implements _$$_OrderCopyWith<$Res> {
  __$$_OrderCopyWithImpl(_$_Order _value, $Res Function(_$_Order) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? email = freezed,
    Object? currencyCode = freezed,
    Object? customerUrl = freezed,
    Object? lineItems = freezed,
    Object? name = freezed,
    Object? orderNumber = freezed,
    Object? processedAt = freezed,
    Object? shippingAddress = null,
    Object? billingAddress = freezed,
    Object? statusUrl = freezed,
    Object? subtotalPriceV2 = null,
    Object? totalPriceV2 = null,
    Object? totalShippingPriceV2 = null,
    Object? totalTaxV2 = null,
    Object? financialStatus = freezed,
    Object? fulfillmentStatus = freezed,
    Object? totalRefundedV2 = freezed,
    Object? phone = freezed,
    Object? cursor = freezed,
    Object? successfulFulfillments = freezed,
  }) {
    return _then(_$_Order(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      customerUrl: freezed == customerUrl
          ? _value.customerUrl
          : customerUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lineItems: freezed == lineItems
          ? _value.lineItems
          : lineItems // ignore: cast_nullable_to_non_nullable
              as LineItemsOrder?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNumber: freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      shippingAddress: null == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as ShippingAddress,
      billingAddress: freezed == billingAddress
          ? _value.billingAddress
          : billingAddress // ignore: cast_nullable_to_non_nullable
              as ShippingAddress?,
      statusUrl: freezed == statusUrl
          ? _value.statusUrl
          : statusUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      subtotalPriceV2: null == subtotalPriceV2
          ? _value.subtotalPriceV2
          : subtotalPriceV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalPriceV2: null == totalPriceV2
          ? _value.totalPriceV2
          : totalPriceV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalShippingPriceV2: null == totalShippingPriceV2
          ? _value.totalShippingPriceV2
          : totalShippingPriceV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      totalTaxV2: null == totalTaxV2
          ? _value.totalTaxV2
          : totalTaxV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2,
      financialStatus: freezed == financialStatus
          ? _value.financialStatus
          : financialStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      fulfillmentStatus: freezed == fulfillmentStatus
          ? _value.fulfillmentStatus
          : fulfillmentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      totalRefundedV2: freezed == totalRefundedV2
          ? _value.totalRefundedV2
          : totalRefundedV2 // ignore: cast_nullable_to_non_nullable
              as PriceV2?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      cursor: freezed == cursor
          ? _value.cursor
          : cursor // ignore: cast_nullable_to_non_nullable
              as String?,
      successfulFulfillments: freezed == successfulFulfillments
          ? _value._successfulFulfillments
          : successfulFulfillments // ignore: cast_nullable_to_non_nullable
              as List<SuccessfulFullfilment>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Order extends _Order {
  _$_Order(
      {required this.id,
      required this.email,
      required this.currencyCode,
      required this.customerUrl,
      required this.lineItems,
      required this.name,
      required this.orderNumber,
      required this.processedAt,
      required this.shippingAddress,
      required this.billingAddress,
      required this.statusUrl,
      required this.subtotalPriceV2,
      required this.totalPriceV2,
      required this.totalShippingPriceV2,
      required this.totalTaxV2,
      required this.financialStatus,
      required this.fulfillmentStatus,
      this.totalRefundedV2,
      this.phone,
      this.cursor,
      final List<SuccessfulFullfilment>? successfulFulfillments})
      : _successfulFulfillments = successfulFulfillments,
        super._();

  factory _$_Order.fromJson(Map<String, dynamic> json) =>
      _$$_OrderFromJson(json);

  @override
  final String? id;
  @override
  final String? email;
  @override
  final String? currencyCode;
  @override
  final String? customerUrl;
  @override
  final LineItemsOrder? lineItems;
  @override
  final String? name;
  @override
  final int? orderNumber;
  @override
  final String? processedAt;
  @override
  final ShippingAddress shippingAddress;
  @override
  final ShippingAddress? billingAddress;
  @override
  final String? statusUrl;
  @override
  final PriceV2 subtotalPriceV2;
  @override
  final PriceV2 totalPriceV2;
  @override
  final PriceV2 totalShippingPriceV2;
  @override
  final PriceV2 totalTaxV2;
  @override
  final String? financialStatus;
  @override
  final String? fulfillmentStatus;
  @override
  final PriceV2? totalRefundedV2;
  @override
  final String? phone;
  @override
  final String? cursor;
  final List<SuccessfulFullfilment>? _successfulFulfillments;
  @override
  List<SuccessfulFullfilment>? get successfulFulfillments {
    final value = _successfulFulfillments;
    if (value == null) return null;
    if (_successfulFulfillments is EqualUnmodifiableListView)
      return _successfulFulfillments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Order(id: $id, email: $email, currencyCode: $currencyCode, customerUrl: $customerUrl, lineItems: $lineItems, name: $name, orderNumber: $orderNumber, processedAt: $processedAt, shippingAddress: $shippingAddress, billingAddress: $billingAddress, statusUrl: $statusUrl, subtotalPriceV2: $subtotalPriceV2, totalPriceV2: $totalPriceV2, totalShippingPriceV2: $totalShippingPriceV2, totalTaxV2: $totalTaxV2, financialStatus: $financialStatus, fulfillmentStatus: $fulfillmentStatus, totalRefundedV2: $totalRefundedV2, phone: $phone, cursor: $cursor, successfulFulfillments: $successfulFulfillments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.customerUrl, customerUrl) ||
                other.customerUrl == customerUrl) &&
            (identical(other.lineItems, lineItems) ||
                other.lineItems == lineItems) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.billingAddress, billingAddress) ||
                other.billingAddress == billingAddress) &&
            (identical(other.statusUrl, statusUrl) ||
                other.statusUrl == statusUrl) &&
            (identical(other.subtotalPriceV2, subtotalPriceV2) ||
                other.subtotalPriceV2 == subtotalPriceV2) &&
            (identical(other.totalPriceV2, totalPriceV2) ||
                other.totalPriceV2 == totalPriceV2) &&
            (identical(other.totalShippingPriceV2, totalShippingPriceV2) ||
                other.totalShippingPriceV2 == totalShippingPriceV2) &&
            (identical(other.totalTaxV2, totalTaxV2) ||
                other.totalTaxV2 == totalTaxV2) &&
            (identical(other.financialStatus, financialStatus) ||
                other.financialStatus == financialStatus) &&
            (identical(other.fulfillmentStatus, fulfillmentStatus) ||
                other.fulfillmentStatus == fulfillmentStatus) &&
            (identical(other.totalRefundedV2, totalRefundedV2) ||
                other.totalRefundedV2 == totalRefundedV2) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.cursor, cursor) || other.cursor == cursor) &&
            const DeepCollectionEquality().equals(
                other._successfulFulfillments, _successfulFulfillments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        currencyCode,
        customerUrl,
        lineItems,
        name,
        orderNumber,
        processedAt,
        shippingAddress,
        billingAddress,
        statusUrl,
        subtotalPriceV2,
        totalPriceV2,
        totalShippingPriceV2,
        totalTaxV2,
        financialStatus,
        fulfillmentStatus,
        totalRefundedV2,
        phone,
        cursor,
        const DeepCollectionEquality().hash(_successfulFulfillments)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderCopyWith<_$_Order> get copyWith =>
      __$$_OrderCopyWithImpl<_$_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderToJson(
      this,
    );
  }
}

abstract class _Order extends Order {
  factory _Order(
      {required final String? id,
      required final String? email,
      required final String? currencyCode,
      required final String? customerUrl,
      required final LineItemsOrder? lineItems,
      required final String? name,
      required final int? orderNumber,
      required final String? processedAt,
      required final ShippingAddress shippingAddress,
      required final ShippingAddress? billingAddress,
      required final String? statusUrl,
      required final PriceV2 subtotalPriceV2,
      required final PriceV2 totalPriceV2,
      required final PriceV2 totalShippingPriceV2,
      required final PriceV2 totalTaxV2,
      required final String? financialStatus,
      required final String? fulfillmentStatus,
      final PriceV2? totalRefundedV2,
      final String? phone,
      final String? cursor,
      final List<SuccessfulFullfilment>? successfulFulfillments}) = _$_Order;
  _Order._() : super._();

  factory _Order.fromJson(Map<String, dynamic> json) = _$_Order.fromJson;

  @override
  String? get id;
  @override
  String? get email;
  @override
  String? get currencyCode;
  @override
  String? get customerUrl;
  @override
  LineItemsOrder? get lineItems;
  @override
  String? get name;
  @override
  int? get orderNumber;
  @override
  String? get processedAt;
  @override
  ShippingAddress get shippingAddress;
  @override
  ShippingAddress? get billingAddress;
  @override
  String? get statusUrl;
  @override
  PriceV2 get subtotalPriceV2;
  @override
  PriceV2 get totalPriceV2;
  @override
  PriceV2 get totalShippingPriceV2;
  @override
  PriceV2 get totalTaxV2;
  @override
  String? get financialStatus;
  @override
  String? get fulfillmentStatus;
  @override
  PriceV2? get totalRefundedV2;
  @override
  String? get phone;
  @override
  String? get cursor;
  @override
  List<SuccessfulFullfilment>? get successfulFulfillments;
  @override
  @JsonKey(ignore: true)
  _$$_OrderCopyWith<_$_Order> get copyWith =>
      throw _privateConstructorUsedError;
}
