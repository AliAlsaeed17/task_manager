// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodosResponse _$TodosResponseFromJson(Map<String, dynamic> json) =>
    TodosResponse(
      total: (json['total'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      skip: (json['skip'] as num?)?.toInt(),
      todos: (json['todos'] as List<dynamic>?)
          ?.map((e) => TodoDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodosResponseToJson(TodosResponse instance) =>
    <String, dynamic>{
      'todos': instance.todos,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };

TodoDataResponse _$TodoDataResponseFromJson(Map<String, dynamic> json) =>
    TodoDataResponse(
      id: (json['id'] as num?)?.toInt(),
      completed: json['completed'] as bool?,
      todo: json['todo'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TodoDataResponseToJson(TodoDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };
