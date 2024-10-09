import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppDialogTheme {
  static DialogTheme get lightTheme => _lightTheme();

  static DialogTheme get darkTheme => _darkTheme();

  static DialogTheme _lightTheme() => DialogTheme(
        backgroundColor: AppColors.background,
      );

  static DialogTheme _darkTheme() => _lightTheme().copyWith(
        backgroundColor: AppColors.dark,
      );
}
