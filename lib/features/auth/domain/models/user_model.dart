import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int id;
  String userName;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String token;
  String refreshToken;

  UserModel({
    required this.userName,
    required this.token,
    required this.refreshToken,
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.image,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
