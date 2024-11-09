// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      userName: json['username'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      id: (json['id'] as num?)?.toInt(),
      lastName: json['lastName'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'image': instance.image,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
