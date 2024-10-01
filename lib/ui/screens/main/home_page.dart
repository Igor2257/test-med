import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/ui/screens/components/app_button.dart';
import 'package:untitled1/ui/screens/dialog/scan_doc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
            inscription: "Click",
            buttonAction: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? image =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              BlocProvider.of<MainBloc>(context).add(SaveImage(file: image));
              showDialog(
                  context: context,
                  builder: (context) {
                    return const ScanDoc();
                  });
            }),
      ),
    );
  }
}
