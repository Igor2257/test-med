part of 'main_bloc.dart';

@immutable
class MainState {
  final Presets presets;
  final double parameterValue1;
  final double parameterValue2;
  final double parameterValue3;
  final double parameterValue4;
  final XFile? savedImage;

  MainState({
    this.presets = Presets.preset1,
    this.parameterValue1 = 0,
    this.parameterValue2 = 0,
    this.parameterValue3 = 0,
    this.parameterValue4 = 0,
    this.savedImage ,
  });

  MainState copyWith({
    Presets? presets,
    double? parameterValue1,
    double? parameterValue2,
    double? parameterValue3,
    double? parameterValue4,
    XFile? savedImage,
  }) {
    return MainState(
      presets: presets ?? this.presets,
      parameterValue1: parameterValue1 ?? this.parameterValue1,
      parameterValue2: parameterValue2 ?? this.parameterValue2,
      parameterValue3: parameterValue3 ?? this.parameterValue3,
      parameterValue4: parameterValue4 ?? this.parameterValue4,
      savedImage: savedImage ?? this.savedImage,
    );
  }
}
