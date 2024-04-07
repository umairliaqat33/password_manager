// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PasswordModel _$PasswordModelFromJson(Map<String, dynamic> json) {
  return _PasswordModel.fromJson(json);
}

/// @nodoc
mixin _$PasswordModel {
  String get email => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get website => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PasswordModelCopyWith<PasswordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordModelCopyWith<$Res> {
  factory $PasswordModelCopyWith(
          PasswordModel value, $Res Function(PasswordModel) then) =
      _$PasswordModelCopyWithImpl<$Res, PasswordModel>;
  @useResult
  $Res call({String email, String userName, String password, String website});
}

/// @nodoc
class _$PasswordModelCopyWithImpl<$Res, $Val extends PasswordModel>
    implements $PasswordModelCopyWith<$Res> {
  _$PasswordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? userName = null,
    Object? password = null,
    Object? website = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PasswordModelImplCopyWith<$Res>
    implements $PasswordModelCopyWith<$Res> {
  factory _$$PasswordModelImplCopyWith(
          _$PasswordModelImpl value, $Res Function(_$PasswordModelImpl) then) =
      __$$PasswordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String userName, String password, String website});
}

/// @nodoc
class __$$PasswordModelImplCopyWithImpl<$Res>
    extends _$PasswordModelCopyWithImpl<$Res, _$PasswordModelImpl>
    implements _$$PasswordModelImplCopyWith<$Res> {
  __$$PasswordModelImplCopyWithImpl(
      _$PasswordModelImpl _value, $Res Function(_$PasswordModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? userName = null,
    Object? password = null,
    Object? website = null,
  }) {
    return _then(_$PasswordModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      website: null == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PasswordModelImpl implements _PasswordModel {
  const _$PasswordModelImpl(
      {required this.email,
      required this.userName,
      required this.password,
      required this.website});

  factory _$PasswordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PasswordModelImplFromJson(json);

  @override
  final String email;
  @override
  final String userName;
  @override
  final String password;
  @override
  final String website;

  @override
  String toString() {
    return 'PasswordModel(email: $email, userName: $userName, password: $password, website: $website)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.website, website) || other.website == website));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, email, userName, password, website);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordModelImplCopyWith<_$PasswordModelImpl> get copyWith =>
      __$$PasswordModelImplCopyWithImpl<_$PasswordModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PasswordModelImplToJson(
      this,
    );
  }
}

abstract class _PasswordModel implements PasswordModel {
  const factory _PasswordModel(
      {required final String email,
      required final String userName,
      required final String password,
      required final String website}) = _$PasswordModelImpl;

  factory _PasswordModel.fromJson(Map<String, dynamic> json) =
      _$PasswordModelImpl.fromJson;

  @override
  String get email;
  @override
  String get userName;
  @override
  String get password;
  @override
  String get website;
  @override
  @JsonKey(ignore: true)
  _$$PasswordModelImplCopyWith<_$PasswordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
