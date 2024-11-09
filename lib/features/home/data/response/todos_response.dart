import 'package:json_annotation/json_annotation.dart';
part 'todos_response.g.dart';

@JsonSerializable()
class TodosResponse {
  List<TodoDataResponse>? todos;
  int? total;
  int? skip;
  int? limit;

  TodosResponse({
    this.total,
    this.limit,
    this.skip,
    this.todos,
  });

  factory TodosResponse.fromJson(Map<String, dynamic> json) =>
      _$TodosResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodosResponseToJson(this);
}

@JsonSerializable()
class TodoDataResponse {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TodoDataResponse({
    this.id,
    this.completed,
    this.todo,
    this.userId,
  });

  factory TodoDataResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoDataResponseToJson(this);
}
