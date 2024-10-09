part of 'scan_document_bloc.dart';

@immutable
class ScanDocumentState {
  final double imageWidth;
  final double initialImageWidth;
  final double imageHeight;
  final double initialImageHeight;
  final Offset position;
  final bool isResizing;
  final GlobalKey firstLayerKey = GlobalKey();
  final GlobalKey secondLayerKey = GlobalKey();

  final Presets presets;
  final double parameterValue1;
  final double parameterValue2;
  final double parameterValue3;
  final double parameterValue4;


  ScanDocumentState({
    this.imageWidth = 300,
    this.imageHeight = 300,
    this.initialImageHeight = 300,
    this.initialImageWidth = 300,
    this.position = const Offset(0, 0),
    this.isResizing = false,
    this.presets = Presets.a4,
    this.parameterValue1 = 0,
    this.parameterValue2 = 0,
    this.parameterValue3 = 0,
    this.parameterValue4 = 0,
  });

  ScanDocumentState copyWith({
    double? imageWidth,
    double? imageHeight,
    double? initialImageWidth,
    double? initialImageHeight,
    Offset? position,
    bool? isResizing,
    Presets? presets,
    double? parameterValue1,
    double? parameterValue2,
    double? parameterValue3,
    double? parameterValue4,
  }) {
    return ScanDocumentState(
      imageHeight: imageHeight ?? this.imageHeight,
      imageWidth: imageWidth ?? this.imageWidth,
      position: position ?? this.position,
      isResizing: isResizing ?? this.isResizing,
      initialImageWidth: initialImageWidth ?? this.initialImageWidth,
      initialImageHeight: initialImageHeight ?? this.initialImageHeight,
      presets: presets ?? this.presets,
      parameterValue1: parameterValue1 ?? this.parameterValue1,
      parameterValue2: parameterValue2 ?? this.parameterValue2,
      parameterValue3: parameterValue3 ?? this.parameterValue3,
      parameterValue4: parameterValue4 ?? this.parameterValue4,
    );
  }
}
