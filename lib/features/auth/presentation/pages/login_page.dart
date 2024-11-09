import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/validation.dart';
import 'package:task_manager/features/auth/data/params/login_params.dart';
import 'package:task_manager/features/auth/presentation/bloc/login_bloc.dart';
import 'package:task_manager/core/utils/routes_manger.dart';
import 'package:task_manager/core/utils/app_strings.dart';
import 'package:task_manager/core/widgets/app_button.dart';
import 'package:task_manager/core/widgets/app_form_filed.dart';
import 'package:task_manager/features/auth/presentation/widgets/password_hide_icon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            AppRoutes.navOfAll(context, routeName: AppRoutes.homeRoute);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      AppStrings.login,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 50),
                    AppFormFiled(
                      controller: nameController,
                      title: AppStrings.userName,
                      hint: AppStrings.enterYourName,
                      validator: Validation.emptyValid,
                    ),
                    const SizedBox(height: 30),
                    AppFormFiled(
                      lines: 1,
                      controller: passwordController,
                      title: AppStrings.password,
                      hint: AppStrings.enterYourPassword,
                      isPassword: isPassword,
                      validator: Validation.emptyValid,
                      suffixIcon: PasswordHideIcon(
                        isPassword: isPassword,
                        onTap: onChangedIsPassword,
                      ),
                    ),
                    const SizedBox(height: 50),
                    if (state is LoginLoadingState)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      AppButton(
                        width: 130,
                        title: AppStrings.login,
                        onTap: () => onTapLogin(context),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  onChangedIsPassword() {
    isPassword = !isPassword;
    setState(() {});
  }

  onTapLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final params = LoginParams(
        password: passwordController.text,
        userName: nameController.text,
        expiresInMins: 30,
      );
      context.read<LoginBloc>().add(LoginDataEvent(params));
    }
  }
}
