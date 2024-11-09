// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodosModel _$TodosModelFromJson(Map<String, dynamic> json) => TodosModel(
      total: (json['total'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      todos: (json['todos'] as List<dynamic>)
          .map((e) => TodoDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodosModelToJson(TodosModel instance) =>
    <String, dynamic>{
      'todos': instance.todos,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };

TodoDataModel _$TodoDataModelFromJson(Map<String, dynamic> json) =>
    TodoDataModel(
      id: (json['id'] as num).toInt(),
      completed: json['completed'] as bool,
      todo: json['todo'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$TodoDataModelToJson(TodoDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todo': instance.todo,
      'completed': instance.completed,
      'userId': instance.userId,
    };
