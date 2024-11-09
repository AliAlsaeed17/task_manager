import 'package:json_annotation/json_annotation.dart';

part 'login_params.g.dart';

@JsonSerializable()
class LoginParams {
  @JsonKey(name: 'username')
  String userName;
  String password;
  int expiresInMins;

  LoginParams({
    required this.password,
    required this.userName,
    required this.expiresInMins,
  });

  factory LoginParams.fromJson(Map<String, dynamic> json) =>
      _$LoginParamsFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParamsToJson(this);
}
