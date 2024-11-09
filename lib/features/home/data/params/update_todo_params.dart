import 'package:json_annotation/json_annotation.dart';
part 'update_todo_params.g.dart';

@JsonSerializable()
class UpdateTodoParams {
  bool completed;
  int id;

  UpdateTodoParams({
    required this.completed,
    required this.id,
  });

  factory UpdateTodoParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateTodoParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTodoParamsToJson(this);
}
