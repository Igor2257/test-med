import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';
import 'package:untitled1/utils/styles/font_family/font_family.dart';

abstract class AppTextButtonTheme {
  static TextButtonThemeData get lightTheme => _lightTheme();

  static TextButtonThemeData get darkTheme => _darkTheme();

  static TextButtonThemeData _lightTheme() => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.dark,
          textStyle: TextStyle(
              fontFamily: FontFamily.montserratBold_700,
              fontSize: 12,
              color: AppColors.dark),
        ),
      );

  static TextButtonThemeData _darkTheme() => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.dark,
          textStyle: TextStyle(
              fontFamily: FontFamily.montserratBold_700,
              fontSize: 12,
              color: AppColors.background),
        ),
      );
}
