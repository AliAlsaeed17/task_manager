import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/core/themes/app_colors.dart';
import 'package:task_manager/core/utils/app_strings.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final controller = context.watch<HomeBloc>();
        return AppBar(
          title: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.welcome,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${controller.user.firstName} ${controller.user.lastName}',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
