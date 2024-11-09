part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetTodosLoadingState extends HomeState {}

final class GetTodosSuccessState extends HomeState {}

final class GetTodosErrorState extends HomeState {}

final class GetTodosPaginateLoadingState extends HomeState {}

final class UpdateTodoSuccessState extends HomeState {}

final class UpdateTodoErrorState extends HomeState {}

final class AddTodoErrorState extends HomeState {}

final class AddTodoSuccessState extends HomeState {}

final class AddTodoLoadingState extends HomeState {}

final class DeleteTodoLoadingState extends HomeState {}

final class DeleteTodoSuccessState extends HomeState {}

final class DeleteTodoErrorState extends HomeState {}
