import 'package:json_annotation/json_annotation.dart';
part 'get_todos_params.g.dart';

@JsonSerializable()
class GetTodosParams {
  int limit;
  int skip;

  GetTodosParams({
    required this.skip,
    required this.limit,
  });

  factory GetTodosParams.fromJson(Map<String, dynamic> json) =>
      _$GetTodosParamsFromJson(json);

  Map<String, dynamic> toJson() => _$GetTodosParamsToJson(this);
}
