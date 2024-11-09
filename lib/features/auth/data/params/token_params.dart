import 'package:json_annotation/json_annotation.dart';
part 'token_params.g.dart';

@JsonSerializable()
class TokenParams {
  String refreshToken;
  int expiresInMins;

  TokenParams({
    required this.refreshToken,
    required this.expiresInMins,
  });

  factory TokenParams.fromJson(Map<String, dynamic> json) =>
      _$TokenParamsFromJson(json);

  Map<String, dynamic> toJson() => _$TokenParamsToJson(this);
}
