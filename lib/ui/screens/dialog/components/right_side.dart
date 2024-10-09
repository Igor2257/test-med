import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/ui/screens/components/app_button.dart';
import 'package:untitled1/ui/screens/dialog/components/parameters.dart';
import 'package:untitled1/ui/screens/dialog/components/preset_widget.dart';
import 'package:untitled1/ui/screens/dialog/components/preview_pdf.dart';
import 'package:untitled1/ui/screens/dialog/components/screenshot_provider.dart';

class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PresetWidget(),
            const Parameters(),
            const PreviewPdf(),
            const Spacer(),
            AppButton(
                inscription: "Good",
                buttonAction: () async {
                  await Provider.of<ScreenshotProvider>(context, listen: false)
                      .takeScreenshot();
                })
          ],
        ),
      ),
    );
  }
}
