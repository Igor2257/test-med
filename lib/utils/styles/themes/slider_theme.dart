import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppSliderTheme {
  static SliderThemeData get lightTheme => _lightTheme();

  static SliderThemeData get darkTheme => _darkTheme();

  static SliderThemeData _lightTheme() => SliderThemeData(
        activeTrackColor: AppColors.primary,
        disabledActiveTrackColor: AppColors.dark,
        inactiveTrackColor: AppColors.dark,
        thumbColor: AppColors.primary,
      );

  static SliderThemeData _darkTheme() => lightTheme.copyWith(
        activeTrackColor: AppColors.primary,
        disabledActiveTrackColor: AppColors.secondary,
        inactiveTrackColor: AppColors.secondary,
        thumbColor: AppColors.primary,
      );
}
