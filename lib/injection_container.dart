import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager/core/network/app_api.dart';
import 'package:task_manager/core/network/dio_factory.dart';
import 'package:task_manager/core/network/network_info.dart';
import 'package:task_manager/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:task_manager/features/auth/data/repository/auth_repository_impl.dart';
import 'package:task_manager/features/auth/domain/repository/auth_repository.dart';
import 'package:task_manager/features/auth/domain/usecase/get_refresh_token.dart';
import 'package:task_manager/features/auth/domain/usecase/login.dart';
import 'package:task_manager/features/home/data/data_source/home_remote_data_source.dart';
import 'package:task_manager/features/home/data/repository/home_repository_impl.dart';
import 'package:task_manager/features/home/domain/usecases/add_new_todo.dart';
import 'package:task_manager/features/home/domain/usecases/delete_todo.dart';
import 'package:task_manager/features/home/domain/usecases/get_all_todos.dart';
import 'package:task_manager/features/home/domain/usecases/update_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/app_pref.dart';
import 'features/home/domain/repository/home_repository.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(instance()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  instance.registerLazySingleton<Connectivity>(() => Connectivity());

  Dio dio = await instance<DioFactory>().getDio();

  instance
      .registerLazySingleton<AppServiceClient>(() => AppServiceClientImpl(dio));

  initAuthModel();
  initHomeModel();
}

initAuthModel() {
  instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance(), instance()));

  instance.registerLazySingleton<GetRefreshToken>(
      () => GetRefreshToken(instance()));

  instance.registerLazySingleton<Login>(() => Login(instance()));
}

initHomeModel() {
  instance.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(instance(), instance(), instance()));

  instance.registerLazySingleton<GetAllTodos>(() => GetAllTodos(instance()));

  instance.registerLazySingleton<UpdateTodo>(() => UpdateTodo(instance()));

  instance.registerLazySingleton<AddNewTodo>(() => AddNewTodo(instance()));

  instance.registerLazySingleton<DeleteTodo>(() => DeleteTodo(instance()));
}
