part of 'scan_document_bloc.dart';

@immutable
sealed class ScanDocumentEvent {}

class ChangeImageSize extends ScanDocumentEvent {
  final Size imageSize;

  ChangeImageSize({required this.imageSize});
}

class ChangeScanPosition extends ScanDocumentEvent {
  final Offset position;

  ChangeScanPosition({required this.position});
}

class UpdateSize extends ScanDocumentEvent {
  final double dx;
  final double dy;

  UpdateSize({required this.dx, required this.dy});
}

class UpdatePosition extends ScanDocumentEvent {
  final Offset delta;

  UpdatePosition({required this.delta});
}
