// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_todos_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTodosParams _$GetTodosParamsFromJson(Map<String, dynamic> json) =>
    GetTodosParams(
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$GetTodosParamsToJson(GetTodosParams instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'skip': instance.skip,
    };
