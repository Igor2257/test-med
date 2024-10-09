import 'package:flutter/material.dart';
import 'package:untitled1/ui/screens/dialog/components/left_side.dart';
import 'package:untitled1/ui/screens/dialog/components/right_side.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/ui/screens/dialog/components/screenshot_provider.dart';
class ScanDoc extends StatelessWidget {
  const ScanDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (_) => ScreenshotProvider(),
      child: ClipRect(
        child: Dialog(
          backgroundColor: Colors.grey.shade300,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [LeftSide(), RightSide()],
            ),
          ),
        ),
      ),
    );
  }
}
