import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manager/core/utils/app_pref.dart';
import 'package:task_manager/core/network/network_info.dart';
import 'package:task_manager/features/auth/data/mapper/auth_mapper.dart';
import 'package:task_manager/features/auth/data/response/user_response.dart';
import 'package:task_manager/features/auth/domain/models/user_model.dart';
import 'package:task_manager/features/home/data/params/add_new_todo_params.dart';
import 'package:task_manager/features/home/data/params/get_todos_params.dart';
import 'package:task_manager/features/home/data/params/update_todo_params.dart';
import 'package:task_manager/features/home/domain/models/todos_model.dart';
import 'package:task_manager/features/home/domain/usecases/add_new_todo.dart';
import 'package:task_manager/features/home/domain/usecases/delete_todo.dart';
import 'package:task_manager/features/home/domain/usecases/get_all_todos.dart';
import 'package:task_manager/features/home/domain/usecases/update_todo.dart';
import 'package:task_manager/injection_container.dart';
import 'package:task_manager/core/utils/toast_utils.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final GetAllTodos _allTodosUseCase = instance<GetAllTodos>();
  final UpdateTodo _updateTodoUseCase = instance<UpdateTodo>();
  final AddNewTodo _addNewTodoUseCase = instance<AddNewTodo>();
  final DeleteTodo _deleteTodoUseCase = instance<DeleteTodo>();
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  UserModel user = UserResponse().toDomain();
  List<TodoDataModel> todos = [];
  late TodosModel todosModel;
  final ScrollController scrollController = ScrollController();

  HomeBloc() : super(HomeInitial()) {
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (state is! GetTodosPaginateLoadingState) {
          add(GetTodosEvent(isPaginate: true));
        }
      }
    });

    on<HomeEvent>((event, emit) {});

    on<GetUserFromLocalStorageEvent>((event, emit) {
      user = _appPreferences.getUser();
      emit(HomeInitial());
    });

    on<GetTodosEvent>((event, emit) async {
      if (event.isPaginate) {
        emit(GetTodosPaginateLoadingState());
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      } else {
        todos.clear();
        emit(GetTodosLoadingState());
      }
      final params = GetTodosParams(skip: 10, limit: 10);
      final result = await _allTodosUseCase.execute(params);
      await result.fold(
        (l) {
          showToast(title: l.message);
          emit(GetTodosErrorState());
        },
        (r) async {
          todosModel = r;
          if (!await _networkInfo.isConnected()) {
            todos.clear();
          }
          todos.addAll(r.todos);
          emit(GetTodosSuccessState());
          await _appPreferences.deleteTodoList();
          await _appPreferences.setTodoList(r.todos);
        },
      );
    });

    on<UpdateTodoEvent>((event, emit) async {
      final params = UpdateTodoParams(
        completed: event.params.completed,
        id: event.params.id,
      );
      final result = await _updateTodoUseCase.execute(params);
      result.fold(
        (l) {
          showToast(title: l.message);
          emit(UpdateTodoErrorState());
        },
        (r) {
          todos[event.index].completed = r.completed;
          emit(UpdateTodoSuccessState());
        },
      );
    });

    on<AddNewTodoEvent>((event, emit) async {
      emit(AddTodoLoadingState());
      final params = AddNewTodoParams(
        completed: false,
        todo: event.todo,
        userId: user.id,
      );
      final result = await _addNewTodoUseCase.execute(params);
      result.fold(
        (l) {
          showToast(title: l.message);
          emit(AddTodoErrorState());
        },
        (r) {
          todos.insert(0, r);
          emit(AddTodoSuccessState());
        },
      );
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(DeleteTodoLoadingState());
      final result = await _deleteTodoUseCase.execute(event.id);
      result.fold(
        (l) {
          showToast(title: l.message);
          emit(DeleteTodoErrorState());
        },
        (r) {
          todos.removeAt(event.index);
          emit(DeleteTodoSuccessState());
        },
      );
    });
  }
}
