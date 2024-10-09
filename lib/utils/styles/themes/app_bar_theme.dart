import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

class AppBarTheme1{
  static AppBarTheme get lightTheme => _lightTheme();

  static AppBarTheme get darkTheme => _darkTheme();

  static AppBarTheme _lightTheme() => AppBarTheme(
    backgroundColor: AppColors.background,
  );

  static AppBarTheme _darkTheme() => lightTheme.copyWith(
    backgroundColor: AppColors.dark,
  );
}