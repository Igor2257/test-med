import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppPopButtonTheme {
  static PopupMenuThemeData get lightTheme => _lightTheme();

  static PopupMenuThemeData get darkTheme => _darkTheme();

  static PopupMenuThemeData _lightTheme() => const PopupMenuThemeData(
        color: AppColors.whiteF7,
        surfaceTintColor: Colors.transparent,
      );

  static PopupMenuThemeData _darkTheme() =>
      lightTheme.copyWith(color: AppColors.blue39);
}
