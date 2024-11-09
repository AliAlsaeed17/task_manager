import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:task_manager/core/utils/routes_manger.dart';
import 'package:task_manager/core/utils/app_strings.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(RefreshAuthSession()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is RefreshSessionSuccessState) {
            AppRoutes.navOfAll(context, routeName: AppRoutes.homeRoute);
          }
          if (state is RefreshSessionErrorState) {
            AppRoutes.navOfAll(context, routeName: AppRoutes.loginRoute);
          }
        },
        child: Scaffold(
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.appTitle,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
