import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/utils/enums/drawer_navigation.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState()) {
    on<ChangeDrawerNavigation>(_onChangeDrawerNavigation);
    on<ChangeFullViewDrawer>(_onChangeFullViewDrawer);
  }

  FutureOr<void> _onChangeDrawerNavigation(
      ChangeDrawerNavigation event, Emitter<NavigationState> emit) {
    emit(
      state.copyWith(
        drawerNavigation: event.drawerNavigation,
      ),
    );
  }

  FutureOr<void> _onChangeFullViewDrawer(
      ChangeFullViewDrawer event, Emitter<NavigationState> emit) {
    emit(
      state.copyWith(
        isFullViewDrawer: !state.isFullViewDrawer,
      ),
    );
  }
}
