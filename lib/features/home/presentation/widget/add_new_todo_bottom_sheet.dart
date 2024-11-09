import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/validation.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/core/themes/app_colors.dart';
import 'package:task_manager/core/utils/app_strings.dart';
import 'package:task_manager/core/widgets/app_button.dart';
import 'package:task_manager/core/widgets/app_form_filed.dart';

class AddNewTodoBottomSheet extends StatefulWidget {
  const AddNewTodoBottomSheet({super.key});

  @override
  State<AddNewTodoBottomSheet> createState() => _AddNewTodoBottomSheetState();
}

class _AddNewTodoBottomSheetState extends State<AddNewTodoBottomSheet> {
  final TextEditingController todoController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: AppColors.fillColor,
        ),
        child: Form(
          key: formKey,
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is AddTodoSuccessState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final controller = context.watch<HomeBloc>();
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppStrings.addNewTodo,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 20),
                  AppFormFiled(
                    lines: 4,
                    controller: todoController,
                    validator: Validation.emptyValid,
                  ),
                  const SizedBox(height: 20),
                  if (state is AddTodoLoadingState)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    AppButton(
                      width: MediaQuery.sizeOf(context).width,
                      title: AppStrings.addTodo,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          controller
                              .add(AddNewTodoEvent(todo: todoController.text));
                        }
                      },
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
