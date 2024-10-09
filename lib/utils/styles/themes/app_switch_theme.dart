import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppSwitchTheme {
  static SwitchThemeData get lightTheme => _lightTheme();

  static SwitchThemeData get darkTheme => _darkTheme();

  static SwitchThemeData _lightTheme() => SwitchThemeData(
        trackColor: WidgetStateProperty.all(AppColors.secondary),
      );

  static SwitchThemeData _darkTheme() => lightTheme.copyWith(
        trackColor: WidgetStateProperty.all(AppColors.primary),
      );
}
