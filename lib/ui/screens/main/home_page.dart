import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/ui/screens/components/drawer/app_drawer.dart';
import 'package:untitled1/ui/screens/components/header/header.dart';
import 'package:untitled1/ui/screens/dialog/scan_doc.dart';
import 'package:untitled1/ui/screens/main/components/screen_element.dart';
import 'package:untitled1/utils/enums/screen_elements.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        toolbarHeight: 70,
      ),
      body: Flex(direction: Axis.horizontal,
        children: [
          const AppDrawer(),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(right: 16, top: 16),
              decoration: BoxDecoration(color: AppColors.dark.withOpacity(0.1)),
              child: GridView.count(
                crossAxisCount: 5,
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                children: [
                  ScreenElement(
                      screenElements: ScreenElements.scanDoc,
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? image =
                            await imagePicker.pickImage(source: ImageSource.gallery);
                        BlocProvider.of<MainBloc>(context)
                            .add(SaveImage(file: image));
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const ScanDoc();
                            });
                      }),
                  ScreenElement(
                      screenElements: ScreenElements.searchPatient, onTap: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
