import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ScreenshotProvider with ChangeNotifier {
  GlobalKey firstLayerKey = GlobalKey();
  GlobalKey secondLayerKey = GlobalKey();
  Future<void> takeScreenshot() async {
    try {
      RenderRepaintBoundary boundary = firstLayerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Capture the first layer image
      ui.Image image = await boundary.toImage();

      // Get the position and size of the second element
      final RenderBox secondLayerBox =
          secondLayerKey.currentContext!.findRenderObject() as RenderBox;

      // Offset relative to the parent widget, not the global screen
      Offset secondLayerPosition =
          secondLayerBox.localToGlobal(Offset.zero, ancestor: boundary);
      Size secondLayerSize = secondLayerBox.size;

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List imageBytes = byteData.buffer.asUint8List();

        // Now use second layer's position and size to crop the image
        final ui.Rect cropRect = ui.Rect.fromLTWH(
          secondLayerPosition.dx,
          secondLayerPosition.dy,
          secondLayerSize.width,
          secondLayerSize.height,
        );

        // Ensure the cropRect stays within the image bounds
        final imageWidth = image.width;
        final imageHeight = image.height;

        final adjustedCropRect = ui.Rect.fromLTWH(
          cropRect.left.clamp(0, imageWidth.toDouble()),
          cropRect.top.clamp(0, imageHeight.toDouble()),
          cropRect.width.clamp(0, imageWidth - cropRect.left),
          cropRect.height.clamp(0, imageHeight - cropRect.top),
        );

        // Crop the image based on the adjustedCropRect
        final croppedBytes = await _cropImage(imageBytes, adjustedCropRect);

        if (croppedBytes != null) {
          final pdf = pw.Document(
              version: PdfVersion.pdf_1_4,
              theme: pw.ThemeData(),
              verbose: false);

          final image = pw.Image(pw.MemoryImage(croppedBytes));

          pdf.addPage(pw.Page(
              pageFormat: PdfPageFormat.undefined,
              build: (pw.Context context) {
                return image;
              }));

          final uint8List = await pdf.save();
          await savePdfToFile(uint8List); // Save the PDF file
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Function to crop image based on Rect
  Future<Uint8List?> _cropImage(Uint8List imageBytes, ui.Rect cropRect) async {
    // Decode image using image package
    img.Image? decodedImage = img.decodeImage(imageBytes);
    if (decodedImage == null) return null;

    // Ensure cropRect is within image bounds
    int cropX = cropRect.left.toInt();
    int cropY = cropRect.top.toInt();
    int cropWidth = cropRect.width.toInt();
    int cropHeight = cropRect.height.toInt();

    // Crop the image
    img.Image croppedImage = img.copyCrop(decodedImage,
        x: cropX, y: cropY, width: cropWidth, height: cropHeight);


    // Encode the cropped image back to Uint8List
    return Uint8List.fromList(img.encodeJpg(croppedImage,chroma: img.JpegChroma.yuv444,quality: 70));
  }

  Future<void> savePdfToFile(Uint8List uint8List) async {
    // Получение пути к папке "Downloads" (или другой подходящей директории)
    Directory? downloadsDirectory;

    if (Platform.isWindows || Platform.isMacOS) {
      downloadsDirectory = await getDownloadsDirectory();
    } else {
      downloadsDirectory =
          await getApplicationDocumentsDirectory(); // Для других платформ
    }

    // Убедитесь, что директория существует
    if (downloadsDirectory != null) {
      // Определите путь и имя файла
      String filePath =
          path.join(downloadsDirectory.path, 'New ${DateTime.now()}.pdf');

      // Создание файла
      File file = File(filePath);

      // Запись PDF-данных в файл
      await file.writeAsBytes(uint8List);
      if (Platform.isMacOS) {
        await Process.run('open', [file.path]);
      } else if (Platform.isWindows) {
        await Process.run('explorer', [file.path]);
      }
      print('PDF сохранён по пути: ${file.path}');
    } else {
      print('Не удалось получить путь к папке загрузок.');
    }
  }
}
