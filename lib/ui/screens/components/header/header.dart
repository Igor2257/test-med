import 'package:flutter/material.dart';
import 'package:untitled1/ui/screens/components/header/components/search_widget.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

part 'components/sign_in_widget.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  Header({
    super.key,
    this.elevation,
    this.toolbarHeight,
    this.bottom,
  })  : assert(elevation == null || elevation >= 0.0),
        preferredSize =
            _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;

  @override
  State<Header> createState() => _HeaderState();

  @override
  final Size preferredSize;
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SearchWidget(),
          SignInWidget(),
        ],
      ),
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
