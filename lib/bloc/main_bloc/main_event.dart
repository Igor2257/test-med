part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class ChangePreset extends MainEvent {
  final Presets presets;

  ChangePreset({required this.presets});
}

class ChangeParameterValue extends MainEvent {
  final ParametersEnum parametersEnum;
  final double value;

  ChangeParameterValue({required this.parametersEnum, required this.value});
}

class SaveImage extends MainEvent{
  final XFile? file;

  SaveImage({required this.file});
}