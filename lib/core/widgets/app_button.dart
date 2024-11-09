import 'package:flutter/material.dart';
import 'package:task_manager/core/themes/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final double? width;

  const AppButton({super.key, required this.title, this.width, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.button),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
