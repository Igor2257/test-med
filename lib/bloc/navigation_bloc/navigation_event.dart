part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}
class ChangeDrawerNavigation extends NavigationEvent{
  final DrawerNavigation drawerNavigation;

  ChangeDrawerNavigation({required this.drawerNavigation});
}

class ChangeFullViewDrawer extends NavigationEvent{
  ChangeFullViewDrawer();
}