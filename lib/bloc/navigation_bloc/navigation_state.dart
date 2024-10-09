part of 'navigation_bloc.dart';

@immutable
class NavigationState {
  final DrawerNavigation drawerNavigation;
  final bool isFullViewDrawer;

  const NavigationState({
    this.drawerNavigation = DrawerNavigation.overview,
    this.isFullViewDrawer = true,
  });

  NavigationState copyWith({
    DrawerNavigation? drawerNavigation,
    bool? isFullViewDrawer,
  }) {
    return NavigationState(
      drawerNavigation: drawerNavigation ?? this.drawerNavigation,
      isFullViewDrawer: isFullViewDrawer ?? this.isFullViewDrawer,
    );
  }
}
