import 'package:flutter/material.dart';
import 'package:untitled1/screens/components/app_button.dart';
import 'package:untitled1/screens/dialog/components/parameters.dart';
import 'package:untitled1/screens/dialog/components/preset_widget.dart';

class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(color: Colors.grey.shade300,
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PresetWidget(),
            const Parameters(),
            AppButton(inscription: "Good", buttonAction: () {})
          ],
        ),
      ),
    );
  }
}
