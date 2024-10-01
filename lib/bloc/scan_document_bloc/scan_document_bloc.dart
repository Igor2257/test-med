import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'scan_document_event.dart';
part 'scan_document_state.dart';

class ScanDocumentBloc extends Bloc<ScanDocumentEvent, ScanDocumentState> {
  ScanDocumentBloc() : super(ScanDocumentState()) {
    on<ChangeImageSize>(_onChangeImageSize);
    on<ChangeScanPosition>(_onChangeScanPosition);
    on<UpdateSize>(_onUpdateSize);
    on<UpdatePosition>(_onUpdatePosition);
  }

  FutureOr<void> _onChangeImageSize(
      ChangeImageSize event, Emitter<ScanDocumentState> emit) {
    emit(
      state.copyWith(
        imageHeight: event.imageSize.height,
        imageWidth: event.imageSize.width,
        initialImageWidth: event.imageSize.width,
        initialImageHeight: event.imageSize.height,
      ),
    );
  }

  FutureOr<void> _onChangeScanPosition(
      ChangeScanPosition event, Emitter<ScanDocumentState> emit) {
    emit(state.copyWith(position: event.position));
  }

  FutureOr<void> _onUpdateSize(
      UpdateSize event, Emitter<ScanDocumentState> emit) {
    var width = state.imageWidth;
    var height = state.imageHeight;
    print(event.dx);
    print(event.dy);
    width += event.dx;
    height += event.dy;
    print("initialImageHeight ${state.initialImageHeight}");
    print("height $height");
    // Ограничение по размерам
    width = width.clamp(50.0, (state.initialImageWidth));
    height = height.clamp(50.0, (state.initialImageHeight));
    print("height1 $height");
    emit(state.copyWith(imageWidth: width, imageHeight: height));
  }

  FutureOr<void> _onUpdatePosition(
      UpdatePosition event, Emitter<ScanDocumentState> emit) {
    var position = Offset(state.position.dx, state.position.dy);
    print(event.delta);
    position += event.delta;
    position = Offset(
      position.dx.clamp(0, (state.initialImageWidth) - state.imageWidth),
      position.dy.clamp(0, (state.initialImageHeight) - state.imageHeight),
    );
    print(position);
    emit(state.copyWith(position: position));
  }
}
