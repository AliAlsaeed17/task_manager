// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_todo_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTodoParams _$UpdateTodoParamsFromJson(Map<String, dynamic> json) =>
    UpdateTodoParams(
      completed: json['completed'] as bool,
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateTodoParamsToJson(UpdateTodoParams instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'id': instance.id,
    };
