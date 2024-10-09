part of 'main_bloc.dart';

@immutable
class MainState {

  final XFile? savedImage;

  MainState({

    this.savedImage ,
  });

  MainState copyWith({

    XFile? savedImage,
  }) {
    return MainState(

      savedImage: savedImage ?? this.savedImage,
    );
  }
}
