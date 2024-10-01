part of 'scan_document_bloc.dart';

@immutable
class ScanDocumentState {
  final double imageWidth;
  final double initialImageWidth;
  final double imageHeight;
  final double initialImageHeight;
  final Offset position;
  final bool isResizing;


  const ScanDocumentState({
    this.imageWidth = 300,
    this.imageHeight = 300,
    this.initialImageHeight = 300,
    this.initialImageWidth = 300,
    this.position = const Offset(0, 0),
    this.isResizing = false,
  });

  ScanDocumentState copyWith({
    double? imageWidth,
    double? imageHeight,
    double? initialImageWidth,
    double? initialImageHeight,
    Offset? position,
    bool? isResizing,
  }) {
    return ScanDocumentState(
      imageHeight: imageHeight ?? this.imageHeight,
      imageWidth: imageWidth ?? this.imageWidth,
      position: position ?? this.position,
      isResizing: isResizing ?? this.isResizing,
      initialImageWidth: initialImageWidth ?? this.initialImageWidth,
      initialImageHeight: initialImageHeight ?? this.initialImageHeight,
    );
  }
}
