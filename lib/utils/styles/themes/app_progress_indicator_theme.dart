import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppProgressIndicatorTheme {
  static ProgressIndicatorThemeData get lightTheme => _lightTheme();

  static ProgressIndicatorThemeData get darkTheme => _darkTheme();

  static ProgressIndicatorThemeData _lightTheme() =>
      const ProgressIndicatorThemeData(color: AppColors.blueF4);

  static ProgressIndicatorThemeData _darkTheme() => _lightTheme().copyWith();
}
