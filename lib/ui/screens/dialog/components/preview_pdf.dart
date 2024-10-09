import 'package:flutter/material.dart';
import 'package:untitled1/ui/screens/components/app_button.dart';

class PreviewPdf extends StatelessWidget {
  const PreviewPdf({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        AppButton(inscription: "preview", buttonAction: () async {}),
      ],
    ));
  }
}
