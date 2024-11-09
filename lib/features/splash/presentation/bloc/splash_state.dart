part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class RefreshSessionSuccessState extends SplashState {}

final class RefreshSessionErrorState extends SplashState {}
