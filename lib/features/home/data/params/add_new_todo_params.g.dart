// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_todo_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewTodoParams _$AddNewTodoParamsFromJson(Map<String, dynamic> json) =>
    AddNewTodoParams(
      completed: json['completed'] as bool,
      todo: json['todo'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$AddNewTodoParamsToJson(AddNewTodoParams instance) =>
    <String, dynamic>{
      'todo': instance.todo,
      'userId': instance.userId,
      'completed': instance.completed,
    };
