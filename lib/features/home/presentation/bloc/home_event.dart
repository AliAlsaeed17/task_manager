part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetUserFromLocalStorageEvent extends HomeEvent {}

class GetTodosEvent extends HomeEvent {
  final bool isPaginate;

  GetTodosEvent({
    this.isPaginate = false,
  });
}

class UpdateTodoEvent extends HomeEvent {
  final UpdateTodoParams params;
  final int index;

  UpdateTodoEvent({
    required this.params,
    required this.index,
  });
}

class AddNewTodoEvent extends HomeEvent {
  final String todo;

  AddNewTodoEvent({
    required this.todo,
  });
}

class DeleteTodoEvent extends HomeEvent {
  final int id;
  final int index;

  DeleteTodoEvent({
    required this.id,
    required this.index,
  });
}
