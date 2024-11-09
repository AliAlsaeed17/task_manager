import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  int? id;
  @JsonKey(name: 'username')
  String? userName;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;
  String? refreshToken;

  UserResponse({
    this.userName,
    this.token,
    this.refreshToken,
    this.id,
    this.lastName,
    this.firstName,
    this.email,
    this.image,
    this.gender,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
