import 'package:flutter/material.dart';
import 'package:untitled1/screens/dialog/components/left_side.dart';
import 'package:untitled1/screens/dialog/components/right_side.dart';

class ScanDoc extends  StatelessWidget {
  const ScanDoc({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Row(children: [LeftSide(),SizedBox(width: 64,),RightSide()],),);
  }
}
