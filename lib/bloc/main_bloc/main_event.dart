part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}



class SaveImage extends MainEvent{
  final XFile? file;

  SaveImage({required this.file});
}

