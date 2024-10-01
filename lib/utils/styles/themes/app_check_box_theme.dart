import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppCheckBoxTheme {
  static CheckboxThemeData get lightTheme => _lightTheme();
  static CheckboxThemeData get darkTheme => _darkTheme();

  static CheckboxThemeData _lightTheme() => const CheckboxThemeData(
    shape: CircleBorder(),
    side: BorderSide(
      color: AppColors.blueF4,
    ),
  );

  static CheckboxThemeData _darkTheme() => _lightTheme().copyWith();
}
