// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'household_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HouseholdAccount {
  int get id => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get money => throw _privateConstructorUsedError;
  String get incomeOrExpendFlag => throw _privateConstructorUsedError;
  String get tagId => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HouseholdAccountCopyWith<HouseholdAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseholdAccountCopyWith<$Res> {
  factory $HouseholdAccountCopyWith(
          HouseholdAccount value, $Res Function(HouseholdAccount) then) =
      _$HouseholdAccountCopyWithImpl<$Res, HouseholdAccount>;
  @useResult
  $Res call(
      {int id,
      String date,
      int money,
      String incomeOrExpendFlag,
      String tagId,
      String memo});
}

/// @nodoc
class _$HouseholdAccountCopyWithImpl<$Res, $Val extends HouseholdAccount>
    implements $HouseholdAccountCopyWith<$Res> {
  _$HouseholdAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? money = null,
    Object? incomeOrExpendFlag = null,
    Object? tagId = null,
    Object? memo = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      money: null == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as int,
      incomeOrExpendFlag: null == incomeOrExpendFlag
          ? _value.incomeOrExpendFlag
          : incomeOrExpendFlag // ignore: cast_nullable_to_non_nullable
              as String,
      tagId: null == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HouseholdAccountCopyWith<$Res>
    implements $HouseholdAccountCopyWith<$Res> {
  factory _$$_HouseholdAccountCopyWith(
          _$_HouseholdAccount value, $Res Function(_$_HouseholdAccount) then) =
      __$$_HouseholdAccountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String date,
      int money,
      String incomeOrExpendFlag,
      String tagId,
      String memo});
}

/// @nodoc
class __$$_HouseholdAccountCopyWithImpl<$Res>
    extends _$HouseholdAccountCopyWithImpl<$Res, _$_HouseholdAccount>
    implements _$$_HouseholdAccountCopyWith<$Res> {
  __$$_HouseholdAccountCopyWithImpl(
      _$_HouseholdAccount _value, $Res Function(_$_HouseholdAccount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? money = null,
    Object? incomeOrExpendFlag = null,
    Object? tagId = null,
    Object? memo = null,
  }) {
    return _then(_$_HouseholdAccount(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      null == money
          ? _value.money
          : money // ignore: cast_nullable_to_non_nullable
              as int,
      null == incomeOrExpendFlag
          ? _value.incomeOrExpendFlag
          : incomeOrExpendFlag // ignore: cast_nullable_to_non_nullable
              as String,
      null == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String,
      null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_HouseholdAccount implements _HouseholdAccount {
  const _$_HouseholdAccount(this.id, this.date, this.money,
      this.incomeOrExpendFlag, this.tagId, this.memo);

  @override
  final int id;
  @override
  final String date;
  @override
  final int money;
  @override
  final String incomeOrExpendFlag;
  @override
  final String tagId;
  @override
  final String memo;

  @override
  String toString() {
    return 'HouseholdAccount(id: $id, date: $date, money: $money, incomeOrExpendFlag: $incomeOrExpendFlag, tagId: $tagId, memo: $memo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HouseholdAccount &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.money, money) || other.money == money) &&
            (identical(other.incomeOrExpendFlag, incomeOrExpendFlag) ||
                other.incomeOrExpendFlag == incomeOrExpendFlag) &&
            (identical(other.tagId, tagId) || other.tagId == tagId) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, date, money, incomeOrExpendFlag, tagId, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HouseholdAccountCopyWith<_$_HouseholdAccount> get copyWith =>
      __$$_HouseholdAccountCopyWithImpl<_$_HouseholdAccount>(this, _$identity);
}

abstract class _HouseholdAccount implements HouseholdAccount {
  const factory _HouseholdAccount(
      final int id,
      final String date,
      final int money,
      final String incomeOrExpendFlag,
      final String tagId,
      final String memo) = _$_HouseholdAccount;

  @override
  int get id;
  @override
  String get date;
  @override
  int get money;
  @override
  String get incomeOrExpendFlag;
  @override
  String get tagId;
  @override
  String get memo;
  @override
  @JsonKey(ignore: true)
  _$$_HouseholdAccountCopyWith<_$_HouseholdAccount> get copyWith =>
      throw _privateConstructorUsedError;
}
