import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';
import 'package:untitled1/utils/styles/font_family/font_family.dart';

abstract class AppInputDecorationTheme {
  static InputDecorationTheme get lightTheme => _lightTheme();

  static InputDecorationTheme get darkTheme => _darkTheme();

  static InputDecorationTheme _lightTheme() => InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
        errorBorder: _buildBorder(),
        focusedErrorBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        hintStyle: _buildTextStyle(AppColors.dark),
        prefixStyle: _buildTextStyle(AppColors.dark),
        errorStyle: _buildTextStyle(AppColors.accent1),
        counterStyle: _buildTextStyle(AppColors.dark),
        suffixIconColor: AppColors.dark,
        prefixIconColor: AppColors.dark,
        filled: true,
        fillColor: AppColors.background,
      );

  static InputDecorationTheme _darkTheme() => InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
    errorBorder: _buildBorder(),
    focusedErrorBorder: _buildBorder(),
    focusedBorder: _buildBorder(),
    enabledBorder: _buildBorder(),
    hintStyle: _buildTextStyle(AppColors.background),
    prefixStyle: _buildTextStyle(AppColors.background),
    errorStyle: _buildTextStyle(AppColors.accent1),
    counterStyle: _buildTextStyle(AppColors.background),
    suffixIconColor: AppColors.primary,
    prefixIconColor: AppColors.primary,
    filled: true,
    fillColor: AppColors.dark,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  static OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  static TextStyle _buildTextStyle(Color textColor) {
    return TextStyle(
      color: textColor,
      fontSize: 14,
      fontFamily: FontFamily.montserratMedium_500,
    );
  }
}
