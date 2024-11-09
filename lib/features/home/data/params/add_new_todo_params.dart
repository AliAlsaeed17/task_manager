import 'package:json_annotation/json_annotation.dart';
part 'add_new_todo_params.g.dart';

@JsonSerializable()
class AddNewTodoParams {
  String todo;
  int userId;
  bool completed;

  AddNewTodoParams({
    required this.completed,
    required this.todo,
    required this.userId,
  });

  factory AddNewTodoParams.fromJson(Map<String, dynamic> json) =>
      _$AddNewTodoParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewTodoParamsToJson(this);
}
