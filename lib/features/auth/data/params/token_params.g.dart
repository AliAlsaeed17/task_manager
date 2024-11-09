// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenParams _$TokenParamsFromJson(Map<String, dynamic> json) => TokenParams(
      refreshToken: json['refreshToken'] as String,
      expiresInMins: (json['expiresInMins'] as num).toInt(),
    );

Map<String, dynamic> _$TokenParamsToJson(TokenParams instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'expiresInMins': instance.expiresInMins,
    };
