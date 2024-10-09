import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';
import 'package:untitled1/utils/styles/themes/app_bar_theme.dart';

import 'package:untitled1/utils/styles/themes/app_dialog_theme.dart';
import 'package:untitled1/utils/styles/themes/app_elevated_button_theme.dart';
import 'package:untitled1/utils/styles/themes/app_outlined_button_theme.dart';
import 'package:untitled1/utils/styles/themes/app_pop_button_theme.dart';
import 'package:untitled1/utils/styles/themes/app_progress_indicator_theme.dart';
import 'package:untitled1/utils/styles/themes/app_text_button_theme.dart';
import 'package:untitled1/utils/styles/themes/app_text_field_theme.dart';
import 'package:untitled1/utils/styles/themes/app_text_theme.dart';
import 'package:untitled1/utils/styles/themes/slider_theme.dart';

abstract class AppThemeData {
  static ThemeData get lightTheme => _lightTheme();

  static ThemeData get darkTheme => _darkTheme();

  static ThemeData _lightTheme() => ThemeData(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      elevatedButtonTheme: AppElevatedButtonTheme.lightTheme,
      textTheme: AppTextTheme.lightTheme,
      textButtonTheme: AppTextButtonTheme.lightTheme,
      inputDecorationTheme: AppInputDecorationTheme.lightTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.lightTheme,
      progressIndicatorTheme: AppProgressIndicatorTheme.lightTheme,
      useMaterial3: true,
      popupMenuTheme: AppPopButtonTheme.lightTheme,
      dialogTheme: AppDialogTheme.lightTheme,
      dividerTheme: DividerThemeData(color: AppColors.dark,thickness: 10,space: 20),
      sliderTheme: AppSliderTheme.lightTheme,
      appBarTheme: AppBarTheme1.lightTheme,
  );

  static ThemeData _darkTheme() => lightTheme.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.dark,
      elevatedButtonTheme: AppElevatedButtonTheme.darkTheme,
      textTheme: AppTextTheme.darkTheme,
      textButtonTheme: AppTextButtonTheme.darkTheme,
      inputDecorationTheme: AppInputDecorationTheme.darkTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.darkTheme,
      progressIndicatorTheme: AppProgressIndicatorTheme.darkTheme,
      popupMenuTheme: AppPopButtonTheme.darkTheme,
      dialogTheme: AppDialogTheme.darkTheme,
      dividerTheme: DividerThemeData(color: AppColors.primary),
      sliderTheme: AppSliderTheme.darkTheme,
      appBarTheme: AppBarTheme1.darkTheme);
}
