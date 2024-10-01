import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

abstract class AppSliderTheme {
  static SliderThemeData get lightTheme => _lightTheme();

  static SliderThemeData get darkTheme => _darkTheme();

  static SliderThemeData _lightTheme() => const SliderThemeData(
        activeTrackColor: AppColors.blueE2,
        disabledActiveTrackColor: AppColors.grey65,
        inactiveTrackColor: AppColors.grey65,
        thumbColor: AppColors.blueE2,
      );

  static SliderThemeData _darkTheme() => lightTheme.copyWith(
        activeTrackColor: AppColors.blueE2,
        disabledActiveTrackColor: AppColors.grey65,
        inactiveTrackColor: AppColors.grey65,
        thumbColor: AppColors.blueE2,
      );
}
