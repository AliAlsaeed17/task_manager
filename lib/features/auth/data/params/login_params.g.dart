// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginParams _$LoginParamsFromJson(Map<String, dynamic> json) => LoginParams(
      password: json['password'] as String,
      userName: json['username'] as String,
      expiresInMins: (json['expiresInMins'] as num).toInt(),
    );

Map<String, dynamic> _$LoginParamsToJson(LoginParams instance) =>
    <String, dynamic>{
      'username': instance.userName,
      'password': instance.password,
      'expiresInMins': instance.expiresInMins,
    };
