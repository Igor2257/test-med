import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocSelector<MainBloc, MainState, XFile?>(
        selector: (state) {
          return state.savedImage;
        },
        builder: (context, savedImage) {
          if (savedImage == null) {
            return SizedBox();
          }
          return Image.file(File(savedImage.path));
        },
      ),
    );
  }
}

