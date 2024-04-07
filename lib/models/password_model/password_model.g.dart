// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PasswordModelImpl _$$PasswordModelImplFromJson(Map<String, dynamic> json) =>
    _$PasswordModelImpl(
      email: json['email'] as String,
      userName: json['userName'] as String,
      password: json['password'] as String,
      website: json['website'] as String,
    );

Map<String, dynamic> _$$PasswordModelImplToJson(_$PasswordModelImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'userName': instance.userName,
      'password': instance.password,
      'website': instance.website,
    };
