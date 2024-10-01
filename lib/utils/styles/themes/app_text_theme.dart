import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';
import 'package:untitled1/utils/styles/font_family/font_family.dart';

abstract class AppTextTheme {
  static TextTheme get lightTheme => _lightTheme();

  static TextTheme get darkTheme => _darkTheme();

  static TextTheme _lightTheme() => const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratBold_700,
        ),
        bodyMedium: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        bodySmall: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        titleSmall: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratBold_700,
        ),
        titleLarge: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratBold_700,
        ),
        // Text field body
        titleMedium: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        // Text field label, Password validation item text
        displaySmall: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        displayMedium: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        // Drawer
        displayLarge: TextStyle(
          color: AppColors.white,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        headlineSmall: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        headlineLarge: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
      );

  static TextTheme _darkTheme() => const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratBold_700,
        ),
        bodyMedium: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        bodySmall: TextStyle(
          color: AppColors.white,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        titleSmall: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratBold_700,
        ),
        titleLarge: TextStyle(
          color: AppColors.white,
          fontFamily: FontFamily.montserratBold_700,
        ),
        // Text field body
        titleMedium: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        // Text field label, Password validation item text
        displaySmall: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        displayMedium: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        displayLarge: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        headlineSmall: TextStyle(
          color: AppColors.black,
          fontFamily: FontFamily.montserratMedium_500,
        ),
        headlineLarge: TextStyle(
          color: AppColors.white,
          fontFamily: FontFamily.montserratMedium_500,
        ),
      );
}
