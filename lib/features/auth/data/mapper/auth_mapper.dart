import 'package:task_manager/features/auth/data/response/token_response.dart';
import 'package:task_manager/features/auth/data/response/user_response.dart';
import 'package:task_manager/features/auth/domain/models/token_model.dart';
import 'package:task_manager/features/auth/domain/models/user_model.dart';

extension TokenMapper on TokenResponse? {
  Token toDomain() {
    return Token(
      token: this?.token ?? "",
      refreshToken: this?.refreshToken ?? "",
    );
  }
}

extension UserMapper on UserResponse? {
  UserModel toDomain() {
    return UserModel(
      userName: this?.userName ?? "",
      token: this?.token ?? "",
      refreshToken: this?.refreshToken ?? "",
      id: this?.id ?? 0,
      lastName: this?.lastName ?? "",
      firstName: this?.firstName ?? "",
      email: this?.email ?? "",
      image: this?.image ?? "",
      gender: this?.gender ?? "",
    );
  }
}
