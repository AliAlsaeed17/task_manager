import 'package:flutter/material.dart';
import 'package:task_manager/core/themes/app_colors.dart';

class PasswordHideIcon extends StatelessWidget {
  final bool isPassword;
  final void Function()? onTap;

  const PasswordHideIcon({super.key, required this.isPassword, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isPassword ? Icons.visibility : Icons.visibility_off),
      color: AppColors.primary,
      onPressed: onTap,
    );
  }
}
