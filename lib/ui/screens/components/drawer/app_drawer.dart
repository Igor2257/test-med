import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:untitled1/ui/screens/components/drawer/custom_list_tile.dart';
import 'package:untitled1/utils/enums/drawer_navigation.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final dividerTheme =Theme.of(context).dividerTheme;

    return Container(
      color: AppColors.dark.withOpacity(0.1),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final isFullViewDrawer = state.isFullViewDrawer;
          final drawerNavigation = state.drawerNavigation;

          return Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  color: AppColors.background,
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.overview, isFullViewDrawer),
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.appointments, isFullViewDrawer),
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.patient, isFullViewDrawer),
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.contacts, isFullViewDrawer),
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.schedule, isFullViewDrawer),
                      Divider(
                        height: 1, // Высота
                        thickness: 1, // Толщина
                        color: AppColors.dark, // Цвет
                        indent: 0, // Отступ слева
                        endIndent: 0, // Отступ справа
                      ),
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.help, isFullViewDrawer),
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.support, isFullViewDrawer),
                      _buildDrawerItem(context, drawerNavigation,
                          DrawerNavigation.settings, isFullViewDrawer),
                    ],
                  ),
                ),
              ),
              Padding(
               padding: EdgeInsets.only(top: 8),
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(ChangeFullViewDrawer());
                  },
                  icon: Icon(
                    isFullViewDrawer
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_forward_ios,
                    color: AppColors.dark,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, DrawerNavigation currentNav,
      DrawerNavigation navItem, bool isFullViewDrawer) {
    return Flexible(
      fit: FlexFit.loose,
      child: CustomListTile(
        paddingOut: const EdgeInsets.only(right: 32, top: 8, bottom: 8),
        text: navItem.name,
        leadingIconPath: navItem.imagePath,
        isSelected: currentNav == navItem,
        press: () {
          BlocProvider.of<NavigationBloc>(context)
              .add(ChangeDrawerNavigation(drawerNavigation: navItem));
        },
        hoverColor: AppColors.primary.withOpacity(0.4),
        isOnlyIcon: !isFullViewDrawer,
      ),
    );
  }
}
