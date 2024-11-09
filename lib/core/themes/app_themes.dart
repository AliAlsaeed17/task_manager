import 'package:flutter/material.dart';
import 'package:task_manager/core/themes/app_styles.dart';

import 'app_colors.dart';

ThemeData getApplicationTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
        bodyLarge: getBoldStyle(color: AppColors.white, fontSize: 20),
        bodyMedium: getMediumStyle(color: AppColors.white, fontSize: 16),
        bodySmall: getRegularStyle(color: AppColors.white, fontSize: 12),
        displayLarge: getBoldStyle(color: AppColors.primary, fontSize: 20),
        displayMedium: getMediumStyle(color: AppColors.primary, fontSize: 16),
        displaySmall: getRegularStyle(color: AppColors.primary, fontSize: 12),
        headlineLarge: getBoldStyle(color: AppColors.gray, fontSize: 20),
        headlineMedium: getMediumStyle(color: AppColors.gray, fontSize: 16),
        headlineSmall: getRegularStyle(color: AppColors.gray, fontSize: 12),
        labelLarge: getBoldStyle(color: AppColors.black, fontSize: 20),
        labelMedium: getMediumStyle(color: AppColors.black, fontSize: 16),
        labelSmall: getRegularStyle(color: AppColors.black, fontSize: 12),
        titleLarge: getBoldStyle(color: AppColors.lightGray, fontSize: 20),
        titleMedium: getMediumStyle(color: AppColors.lightGray, fontSize: 16),
        titleSmall: getRegularStyle(color: AppColors.lightGray, fontSize: 12),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lineColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lineColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lineColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lineColor),
        ),
        filled: true,
        fillColor: AppColors.white,
        errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColors.red,
            ),
        hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 16,
              color: AppColors.black.withOpacity(0.5),
            ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withOpacity(0.5),
        selectionHandleColor: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.fillColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.primary,
        onSecondary: AppColors.primary,
        error: AppColors.red,
        onError: AppColors.red,
        background: AppColors.white,
        onBackground: AppColors.black,
        surface: AppColors.white,
        onSurface: AppColors.black,
      ),
    );
