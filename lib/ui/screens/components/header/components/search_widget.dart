import 'package:flutter/material.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = MediaQuery.of(context).size;
    Widget widget = Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
          border: Border.all(color: AppColors.secondary,width: 2),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.search),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            controller: searchTextEditingController,
            focusNode: focusNode,
            onSubmitted: (value) {},
            onChanged: (value) {},
            decoration:  InputDecoration(
              contentPadding: EdgeInsets.zero,
                border: InputBorder.none, hintText: "I look for"),
          )),
          IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: AppColors.dark,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4))),
              child: Center(
                child: Text(
                  "Search",
                  style: TextStyle(color: scaffoldBackgroundColor),
                ),
              ),
            ),
          )
        ],
      ),
    );

    return SizedBox(
      width: size.width / 2,
      child: widget,
    );
  }
}
