import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/features/home/presentation/widget/home_app_bar.dart';
import 'package:task_manager/features/home/presentation/widget/home_floating_button.dart';
import 'package:task_manager/features/home/presentation/widget/todos_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(GetUserFromLocalStorageEvent())
        ..add(GetTodosEvent()),
      child: const Scaffold(
        appBar: HomeAppBar(),
        body: TodosList(),
        floatingActionButton: HomeFloatingButton(),
      ),
    );
  }
}
