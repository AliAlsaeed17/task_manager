import 'package:bloc/bloc.dart';
import 'package:task_manager/core/utils/app_pref.dart';
import 'package:task_manager/features/auth/data/params/login_params.dart';
import 'package:task_manager/features/auth/domain/usecase/login.dart';
import 'package:task_manager/injection_container.dart';
import 'package:task_manager/core/utils/toast_utils.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _loginUseCase = instance<Login>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginDataEvent>((event, emit) async {
      emit(LoginLoadingState());
      final result = await _loginUseCase.execute(event.params);
      await result.fold(
        (l) {
          showToast(title: l.message);
          emit(LoginErrorState());
        },
        (r) async {
          await _appPreferences.setUserToken(r.token);
          await _appPreferences.setUserRefreshToken(r.refreshToken);
          await _appPreferences.setUser(r);
          emit(LoginSuccessState());
        },
      );
    });
  }
}
