import 'package:flutter/material.dart';

import 'package:untitled1/utils/styles/colors/app_colors.dart';
import 'package:untitled1/utils/styles/font_family/font_family.dart';

abstract class AppOutlinedButtonTheme {
  static OutlinedButtonThemeData get lightTheme => _lightTheme();

  static OutlinedButtonThemeData get darkTheme => _darkTheme();

  static OutlinedButtonThemeData _lightTheme() => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.whiteF7,
          foregroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: const BorderSide(color:AppColors.blueF4,),
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: FontFamily.montserratBold_700,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
      );

  static OutlinedButtonThemeData _darkTheme() => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.blue56,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: const BorderSide(color: AppColors.blue8C),
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: FontFamily.montserratBold_700,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        ),
      );


}
