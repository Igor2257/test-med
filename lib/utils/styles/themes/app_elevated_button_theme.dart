import 'package:flutter/material.dart';

import 'package:untitled1/utils/styles/colors/app_colors.dart';
import 'package:untitled1/utils/styles/font_family/font_family.dart';

abstract class AppElevatedButtonTheme {
  static ElevatedButtonThemeData get lightTheme => _lightTheme();

  static ElevatedButtonThemeData get darkTheme => _darkTheme();

  static ElevatedButtonThemeData _lightTheme() => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.background,
          disabledForegroundColor: AppColors.dark,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: FontFamily.montserratBold_700,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        ),
      );

  static ElevatedButtonThemeData _darkTheme() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.dark,
          disabledForegroundColor: AppColors.dark,
          foregroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: FontFamily.montserratBold_700,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        ),
      );
}
