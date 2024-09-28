import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/screens/dialog/components/parameters.dart';
import 'package:untitled1/screens/dialog/components/preset_widget.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<ChangePreset>(_onChangePreset);
    on<ChangeParameterValue>(_onChangeParameterValue);
    on<SaveImage>(_onSaveImage);
  }

  FutureOr<void> _onChangePreset(ChangePreset event, Emitter<MainState> emit) {
    emit(state.copyWith(presets: event.presets));
  }

  FutureOr<void> _onChangeParameterValue(ChangeParameterValue event, Emitter<MainState> emit) {
    switch(event.parametersEnum){

      case ParametersEnum.parameters1:
        emit(state.copyWith(parameterValue1: event.value));
      case ParametersEnum.parameters2:
        emit(state.copyWith(parameterValue2: event.value));
      case ParametersEnum.parameters3:
        emit(state.copyWith(parameterValue3: event.value));
      case ParametersEnum.parameters4:
        emit(state.copyWith(parameterValue4: event.value));
    }
  }

  FutureOr<void> _onSaveImage(SaveImage event, Emitter<MainState> emit) {
    emit(state.copyWith(savedImage:event.file));
  }
}
