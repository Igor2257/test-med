import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:untitled1/ui/screens/dialog/components/parameters.dart';
import 'package:untitled1/ui/screens/dialog/components/preset_widget.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {

    on<SaveImage>(_onSaveImage);

  }


  FutureOr<void> _onSaveImage(SaveImage event, Emitter<MainState> emit) {
    emit(state.copyWith(savedImage: event.file));
  }


}
