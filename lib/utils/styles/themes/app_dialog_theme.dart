import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppDialogTheme {
  static DialogTheme get lightTheme => _lightTheme();

  static DialogTheme get darkTheme => _darkTheme();

  static DialogTheme _lightTheme() => const DialogTheme(
        backgroundColor: AppColors.whiteF7,
      );

  static DialogTheme _darkTheme() => _lightTheme().copyWith(
        backgroundColor: AppColors.blue39,
      );
}
