import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/app_colors.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/screens/main/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          sliderTheme: SliderThemeData(activeTrackColor: AppColors.blueE2,disabledActiveTrackColor:AppColors.grey65,inactiveTrackColor: AppColors.grey65,thumbColor: AppColors.blueE2 )
        ),
        home: const HomePage(),
      ),
    );
  }
}

