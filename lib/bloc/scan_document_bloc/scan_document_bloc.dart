import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:untitled1/ui/screens/dialog/components/parameters.dart';
import 'package:untitled1/ui/screens/dialog/components/preset_widget.dart';

part 'scan_document_event.dart';
part 'scan_document_state.dart';

class ScanDocumentBloc extends Bloc<ScanDocumentEvent, ScanDocumentState> {
  ScanDocumentBloc() : super(ScanDocumentState()) {
    on<ChangeImageSize>(_onChangeImageSize);
    on<ChangeScanPosition>(_onChangeScanPosition);
    on<UpdateSize>(_onUpdateSize);
    on<UpdatePosition>(_onUpdatePosition);
    on<CreatePdf>(_onCreatePdf);

    on<ChangePreset>(_onChangePreset);
    on<ChangeParameterValue>(_onChangeParameterValue);
    on<PreviewPdfEvent>(_onPreviewPdf);
  }

  FutureOr<void> _onChangeImageSize(
      ChangeImageSize event, Emitter<ScanDocumentState> emit) {
    emit(
      state.copyWith(
        imageHeight: event.imageSize.height,
        imageWidth: event.imageSize.width,
        initialImageWidth: event.imageSize.width,
        initialImageHeight: event.imageSize.height,
      ),
    );
  }

  FutureOr<void> _onChangeScanPosition(
      ChangeScanPosition event, Emitter<ScanDocumentState> emit) {
    emit(state.copyWith(position: event.position));
  }

  FutureOr<void> _onUpdateSize(
      UpdateSize event, Emitter<ScanDocumentState> emit) {
    var width = state.imageWidth;
    var height = state.imageHeight;
    print(event.dx);
    print(event.dy);
    width += event.dx;
    height += event.dy;
    print("initialImageHeight ${state.initialImageHeight}");
    print("height $height");
    // Ограничение по размерам
    width = width.clamp(50.0, (state.initialImageWidth));
    height = height.clamp(50.0, (state.initialImageHeight));
    print("height1 $height");
    emit(state.copyWith(imageWidth: width, imageHeight: height));
  }

  FutureOr<void> _onUpdatePosition(
      UpdatePosition event, Emitter<ScanDocumentState> emit) {
    var position = Offset(state.position.dx, state.position.dy);
    print(event.delta);
    position += event.delta;
    position = Offset(
      position.dx.clamp(0, (state.initialImageWidth) - state.imageWidth),
      position.dy.clamp(0, (state.initialImageHeight) - state.imageHeight),
    );
    print(position);
    emit(state.copyWith(position: position));
  }

  Future<void> takeScreenshot() async {
    try {
      RenderRepaintBoundary boundary = state.firstLayerKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Capture the first layer image
      ui.Image image = await boundary.toImage();

      // Get the position and size of the second element
      final RenderBox secondLayerBox =
          state.secondLayerKey.currentContext!.findRenderObject() as RenderBox;

      // Offset relative to the parent widget, not the global screen
      Offset secondLayerPosition =
          secondLayerBox.localToGlobal(Offset.zero, ancestor: boundary);
      Size secondLayerSize = secondLayerBox.size;

      Uint8List? imageBytes = (await image.toByteData())?.buffer.asUint8List();

      if (imageBytes != null) {
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
        // quality can be between 0 and 100

        // Crop the image based on the adjustedCropRect
        final croppedBytes =
            await _resizeAndCropImageHalf(imageBytes, adjustedCropRect);

        if (croppedBytes != null) {
          final pdf = pw.Document(
            version: PdfVersion.pdf_1_4,
            theme: pw.ThemeData(),
            verbose: false,
            title: "",
            author: "",
            creator: "",
            subject: "",
            keywords: "",
            producer: "",
          );
          final memoryImage = pw.MemoryImage(croppedBytes, dpi: 70);
          final image = pw.Image(
            memoryImage,
            fit: pw.BoxFit.cover,
          );

          pdf.addPage(pw.Page(
              pageFormat: getFormat(state.presets),
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

// Function to resize and crop image to half the original size
  Future<Uint8List?> _resizeAndCropImageHalf(
      Uint8List imageBytes, ui.Rect cropRect) async {
    // Decode image using image package
    img.Image? decodedImage = img.decodeImage(imageBytes);
    if (decodedImage == null) return null;

    // Get the original width and height of the image
    int originalWidth = decodedImage.width;
    int originalHeight = decodedImage.height;

    // Calculate new width and height (half the size)
    int newWidth = (originalWidth / 2).toInt();
    int newHeight = (originalHeight / 2).toInt();

    // Resize the image to half the size
    img.Image resizedImage =
        img.copyResize(decodedImage, width: newWidth, height: newHeight);

    // Ensure cropRect is within resized image bounds
    int cropX = cropRect.left.toInt();
    int cropY = cropRect.top.toInt();
    int cropWidth = cropRect.width.toInt();
    int cropHeight = cropRect.height.toInt();

    // Crop the resized image
    img.Image croppedImage = img.copyCrop(resizedImage,
        x: cropX, y: cropY, width: cropWidth, height: cropHeight);

    // Encode the cropped image back to Uint8List
    return Uint8List.fromList(img.encodeJpg(croppedImage));
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

  FutureOr<void> _onCreatePdf(
      CreatePdf event, Emitter<ScanDocumentState> emit) async {
    await takeScreenshot();
  }

  getFormat(Presets presets) {
    switch (presets) {
      case Presets.a3:
        return PdfPageFormat.a3;
      case Presets.a4:
        return PdfPageFormat.a3;
      case Presets.a5:
        return PdfPageFormat.a5;
      case Presets.a6:
        return PdfPageFormat.a6;
      case Presets.letter:
        return PdfPageFormat.letter;
      case Presets.legal:
        return PdfPageFormat.legal;
      case Presets.roll57:
        return PdfPageFormat.roll57;
      case Presets.roll80:
        return PdfPageFormat.roll80;
    }
  }

  FutureOr<void> _onChangePreset(
      ChangePreset event, Emitter<ScanDocumentState> emit) {
    emit(state.copyWith(presets: event.presets));
  }

  FutureOr<void> _onChangeParameterValue(
      ChangeParameterValue event, Emitter<ScanDocumentState> emit) {
    switch (event.parametersEnum) {
      case ParametersEnum.parameters1:
        emit(state.copyWith(parameterValue1: event.value));
      case ParametersEnum.parameters2:
        emit(state.copyWith(parameterValue2: event.value));
      case ParametersEnum.parameters3:
        emit(state.copyWith(parameterValue3: event.value));
      case ParametersEnum.parameters4:
        emit(state.copyWith(parameterValue4: event.value));
    }
  }

  Future<Uint8List?> convertToJpeg(ui.Image image) async {
    // Получаем PNG байты изображения
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      // Преобразуем ByteData в Uint8List
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Декодируем PNG байты в объект img.Image с помощью image пакета
      img.Image? decodedImage = img.decodeImage(pngBytes);

      if (decodedImage != null) {
        // Кодируем изображение в JPEG с качеством 75%
        Uint8List jpegBytes =
            Uint8List.fromList(img.encodeJpg(decodedImage, quality: 75));

        return jpegBytes; // Возвращаем JPEG байты
      }
    }

    return null; // Возвращаем null в случае ошибки
  }

  FutureOr<void> _onPreviewPdf(PreviewPdfEvent event, Emitter<ScanDocumentState> emit)async {
    RenderRepaintBoundary boundary = state.firstLayerKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;

    // Capture the first layer image
    ui.Image image = await boundary.toImage();

    // Get the position and size of the second element
    final RenderBox secondLayerBox =
    state.secondLayerKey.currentContext!.findRenderObject() as RenderBox;

    // Offset relative to the parent widget, not the global screen
    Offset secondLayerPosition =
    secondLayerBox.localToGlobal(Offset.zero, ancestor: boundary);
    Size secondLayerSize = secondLayerBox.size;

    Uint8List? imageBytes = (await image.toByteData())?.buffer.asUint8List();

    if (imageBytes != null) {
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
      // quality can be between 0 and 100

      // Crop the image based on the adjustedCropRect
      final croppedBytes =
      await _resizeAndCropImageHalf(imageBytes, adjustedCropRect);
      int pdfSize = await estimatePdfSize(croppedBytes!);
      print("pdfSize $pdfSize");
    }

  }
  Future<int> estimatePdfSize(Uint8List imageBytes) async {
    // Создаем документ PDF
    final pdf = pw.Document();

    // Добавляем изображение в документ PDF
    final pdfImage = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pdfImage),
          );
        },
      ),
    );

    // Сохраняем PDF в память (как байты)
    Uint8List pdfBytes = await pdf.save();

    // Возвращаем размер PDF в байтах
    return pdfBytes.length;
  }
}
