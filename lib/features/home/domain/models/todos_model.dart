import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todos_model.g.dart';

@JsonSerializable()
class TodosModel {
  List<TodoDataModel> todos;
  int total;
  int skip;
  int limit;

  TodosModel({
    required this.total,
    required this.limit,
    required this.skip,
    required this.todos,
  });

  factory TodosModel.fromJson(Map<String, dynamic> json) =>
      _$TodosModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodosModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodosModel &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(todos, other.todos) &&
          total == other.total &&
          skip == other.skip &&
          limit == other.limit;

  @override
  int get hashCode =>
      todos.hashCode ^ total.hashCode ^ skip.hashCode ^ limit.hashCode;
}

@JsonSerializable()
class TodoDataModel {
  int id;
  String todo;
  bool completed;
  int userId;

  TodoDataModel({
    required this.id,
    required this.completed,
    required this.todo,
    required this.userId,
  });

  factory TodoDataModel.fromJson(Map<String, dynamic> json) =>
      _$TodoDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoDataModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDataModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          completed == other.completed &&
          todo == other.todo &&
          userId == other.userId;

  @override
  int get hashCode =>
      id.hashCode ^ completed.hashCode ^ todo.hashCode ^ userId.hashCode;
}
