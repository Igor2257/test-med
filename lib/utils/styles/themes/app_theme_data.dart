import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';
import 'package:untitled1/utils/styles/themes/app_bottom_sheet_theme.dart';
import 'package:untitled1/utils/styles/themes/app_check_box_theme.dart';
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
        scaffoldBackgroundColor: AppColors.whiteF7,
        elevatedButtonTheme: AppElevatedButtonTheme.lightTheme,
        textTheme: AppTextTheme.lightTheme,
        textButtonTheme: AppTextButtonTheme.lightTheme,
        inputDecorationTheme: AppInputDecorationTheme.lightTheme,
        checkboxTheme: AppCheckBoxTheme.lightTheme,
        outlinedButtonTheme: AppOutlinedButtonTheme.lightTheme,
        bottomSheetTheme: AppBottomSheetTheme.lightTheme,
        progressIndicatorTheme: AppProgressIndicatorTheme.lightTheme,
        useMaterial3: true,
        popupMenuTheme: AppPopButtonTheme.lightTheme,
        dialogTheme: AppDialogTheme.lightTheme,
        dividerColor: AppColors.grey65,
        sliderTheme: AppSliderTheme.lightTheme,
      );

  static ThemeData _darkTheme() => lightTheme.copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.blue39,
        elevatedButtonTheme: AppElevatedButtonTheme.darkTheme,
        textTheme: AppTextTheme.darkTheme,
        textButtonTheme: AppTextButtonTheme.darkTheme,
        inputDecorationTheme: AppInputDecorationTheme.darkTheme,
        outlinedButtonTheme: AppOutlinedButtonTheme.darkTheme,
        bottomSheetTheme: AppBottomSheetTheme.darkTheme,
        progressIndicatorTheme: AppProgressIndicatorTheme.darkTheme,
        popupMenuTheme: AppPopButtonTheme.darkTheme,
        dialogTheme: AppDialogTheme.darkTheme,
        dividerColor: AppColors.blueD4,
        sliderTheme: AppSliderTheme.darkTheme,
      );
}
