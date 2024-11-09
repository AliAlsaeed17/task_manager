// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userName: json['userName'] as String,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      id: (json['id'] as num).toInt(),
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'image': instance.image,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
