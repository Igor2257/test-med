import 'package:flutter/material.dart';

class ScalableFindingTextInDoc extends CustomPainter {
  final Paint _paintLine = new Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;

  void paint(Canvas canvas, Size size) {
    print('size ${size}');
    print('draw Circle blue');

    canvas.drawCircle(new Offset(250.0, 400.0), 100.0, _paintLine);
  } // paint

  bool shouldRepaint(ScalableFindingTextInDoc old) => true;
}
