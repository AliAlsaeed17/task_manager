import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_manager/core/utils/app_pref.dart';
import 'package:task_manager/features/auth/domain/usecase/get_refresh_token.dart';
import 'package:task_manager/injection_container.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final GetRefreshToken _getRefreshTokenUseCase = instance<GetRefreshToken>();

  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<RefreshAuthSession>((event, emit) async {
      if (_appPreferences.getUserRefreshToken().isEmpty) {
        await Future.delayed(const Duration(seconds: 3));
        emit(RefreshSessionErrorState());
        return;
      }
      final result = await _getRefreshTokenUseCase.execute('');
      await result.fold(
        (l) async {
          if (l.code == -6) {
            emit(RefreshSessionSuccessState());
            return;
          }
          emit(RefreshSessionErrorState());
        },
        (r) async {
          await _appPreferences.setUserRefreshToken(r.refreshToken);
          await _appPreferences.setUserToken(r.token);
          emit(RefreshSessionSuccessState());
        },
      );
    });
  }
}
