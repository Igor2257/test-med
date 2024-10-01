import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CaptureScreenShotService {
  Future<Uint8List?> capture(
    GlobalKey containerKey,
  ) async {
    try {
      final boundary = containerKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary != null) {
        final image = await boundary.toImage();
        final byteData = await image.toByteData(format: ImageByteFormat.png);
        if (byteData != null) {
          return byteData.buffer.asUint8List();
        }
      }
    } catch (e, trace) {
      FlutterError(e.toString());
      //FirebaseCrashlytics.instance.recordError(e.toString(), trace);
    }
    return null;
  }
}
