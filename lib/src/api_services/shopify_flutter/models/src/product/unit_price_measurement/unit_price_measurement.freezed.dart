// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unit_price_measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UnitPriceMeasurement _$UnitPriceMeasurementFromJson(Map<String, dynamic> json) {
  return _UnitPriceMeasurement.fromJson(json);
}

/// @nodoc
mixin _$UnitPriceMeasurement {
  String get measuredType => throw _privateConstructorUsedError;
  String get quantityUnit => throw _privateConstructorUsedError;
  double get quantityValue => throw _privateConstructorUsedError;
  String get referenceUnit => throw _privateConstructorUsedError;
  int get referenceValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitPriceMeasurementCopyWith<UnitPriceMeasurement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitPriceMeasurementCopyWith<$Res> {
  factory $UnitPriceMeasurementCopyWith(UnitPriceMeasurement value,
          $Res Function(UnitPriceMeasurement) then) =
      _$UnitPriceMeasurementCopyWithImpl<$Res, UnitPriceMeasurement>;
  @useResult
  $Res call(
      {String measuredType,
      String quantityUnit,
      double quantityValue,
      String referenceUnit,
      int referenceValue});
}

/// @nodoc
class _$UnitPriceMeasurementCopyWithImpl<$Res,
        $Val extends UnitPriceMeasurement>
    implements $UnitPriceMeasurementCopyWith<$Res> {
  _$UnitPriceMeasurementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measuredType = null,
    Object? quantityUnit = null,
    Object? quantityValue = null,
    Object? referenceUnit = null,
    Object? referenceValue = null,
  }) {
    return _then(_value.copyWith(
      measuredType: null == measuredType
          ? _value.measuredType
          : measuredType // ignore: cast_nullable_to_non_nullable
              as String,
      quantityUnit: null == quantityUnit
          ? _value.quantityUnit
          : quantityUnit // ignore: cast_nullable_to_non_nullable
              as String,
      quantityValue: null == quantityValue
          ? _value.quantityValue
          : quantityValue // ignore: cast_nullable_to_non_nullable
              as double,
      referenceUnit: null == referenceUnit
          ? _value.referenceUnit
          : referenceUnit // ignore: cast_nullable_to_non_nullable
              as String,
      referenceValue: null == referenceValue
          ? _value.referenceValue
          : referenceValue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UnitPriceMeasurementCopyWith<$Res>
    implements $UnitPriceMeasurementCopyWith<$Res> {
  factory _$$_UnitPriceMeasurementCopyWith(_$_UnitPriceMeasurement value,
          $Res Function(_$_UnitPriceMeasurement) then) =
      __$$_UnitPriceMeasurementCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String measuredType,
      String quantityUnit,
      double quantityValue,
      String referenceUnit,
      int referenceValue});
}

/// @nodoc
class __$$_UnitPriceMeasurementCopyWithImpl<$Res>
    extends _$UnitPriceMeasurementCopyWithImpl<$Res, _$_UnitPriceMeasurement>
    implements _$$_UnitPriceMeasurementCopyWith<$Res> {
  __$$_UnitPriceMeasurementCopyWithImpl(_$_UnitPriceMeasurement _value,
      $Res Function(_$_UnitPriceMeasurement) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measuredType = null,
    Object? quantityUnit = null,
    Object? quantityValue = null,
    Object? referenceUnit = null,
    Object? referenceValue = null,
  }) {
    return _then(_$_UnitPriceMeasurement(
      measuredType: null == measuredType
          ? _value.measuredType
          : measuredType // ignore: cast_nullable_to_non_nullable
              as String,
      quantityUnit: null == quantityUnit
          ? _value.quantityUnit
          : quantityUnit // ignore: cast_nullable_to_non_nullable
              as String,
      quantityValue: null == quantityValue
          ? _value.quantityValue
          : quantityValue // ignore: cast_nullable_to_non_nullable
              as double,
      referenceUnit: null == referenceUnit
          ? _value.referenceUnit
          : referenceUnit // ignore: cast_nullable_to_non_nullable
              as String,
      referenceValue: null == referenceValue
          ? _value.referenceValue
          : referenceValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UnitPriceMeasurement extends _UnitPriceMeasurement {
  _$_UnitPriceMeasurement(
      {required this.measuredType,
      required this.quantityUnit,
      required this.quantityValue,
      required this.referenceUnit,
      required this.referenceValue})
      : super._();

  factory _$_UnitPriceMeasurement.fromJson(Map<String, dynamic> json) =>
      _$$_UnitPriceMeasurementFromJson(json);

  @override
  final String measuredType;
  @override
  final String quantityUnit;
  @override
  final double quantityValue;
  @override
  final String referenceUnit;
  @override
  final int referenceValue;

  @override
  String toString() {
    return 'UnitPriceMeasurement(measuredType: $measuredType, quantityUnit: $quantityUnit, quantityValue: $quantityValue, referenceUnit: $referenceUnit, referenceValue: $referenceValue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnitPriceMeasurement &&
            (identical(other.measuredType, measuredType) ||
                other.measuredType == measuredType) &&
            (identical(other.quantityUnit, quantityUnit) ||
                other.quantityUnit == quantityUnit) &&
            (identical(other.quantityValue, quantityValue) ||
                other.quantityValue == quantityValue) &&
            (identical(other.referenceUnit, referenceUnit) ||
                other.referenceUnit == referenceUnit) &&
            (identical(other.referenceValue, referenceValue) ||
                other.referenceValue == referenceValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, measuredType, quantityUnit,
      quantityValue, referenceUnit, referenceValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UnitPriceMeasurementCopyWith<_$_UnitPriceMeasurement> get copyWith =>
      __$$_UnitPriceMeasurementCopyWithImpl<_$_UnitPriceMeasurement>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnitPriceMeasurementToJson(
      this,
    );
  }
}

abstract class _UnitPriceMeasurement extends UnitPriceMeasurement {
  factory _UnitPriceMeasurement(
      {required final String measuredType,
      required final String quantityUnit,
      required final double quantityValue,
      required final String referenceUnit,
      required final int referenceValue}) = _$_UnitPriceMeasurement;
  _UnitPriceMeasurement._() : super._();

  factory _UnitPriceMeasurement.fromJson(Map<String, dynamic> json) =
      _$_UnitPriceMeasurement.fromJson;

  @override
  String get measuredType;
  @override
  String get quantityUnit;
  @override
  double get quantityValue;
  @override
  String get referenceUnit;
  @override
  int get referenceValue;
  @override
  @JsonKey(ignore: true)
  _$$_UnitPriceMeasurementCopyWith<_$_UnitPriceMeasurement> get copyWith =>
      throw _privateConstructorUsedError;
}
