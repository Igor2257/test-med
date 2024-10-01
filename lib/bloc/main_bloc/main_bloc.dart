import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_compressor/pdf_compressor.dart';
import 'package:untitled1/ui/screens/dialog/components/parameters.dart';
import 'package:untitled1/ui/screens/dialog/components/preset_widget.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<ChangePreset>(_onChangePreset);
    on<ChangeParameterValue>(_onChangeParameterValue);
    on<SaveImage>(_onSaveImage);
    on<CreatePdf>(_onCreatePdf);
  }

  FutureOr<void> _onChangePreset(ChangePreset event, Emitter<MainState> emit) {
    emit(state.copyWith(presets: event.presets));
  }

  FutureOr<void> _onChangeParameterValue(
      ChangeParameterValue event, Emitter<MainState> emit) {
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

  FutureOr<void> _onSaveImage(SaveImage event, Emitter<MainState> emit) {
    emit(state.copyWith(savedImage: event.file));
  }

  FutureOr<void> _onCreatePdf(CreatePdf event, Emitter<MainState> emit) async {
    if(state.savedImage==null)return;
    final pdf = pw.Document(version: PdfVersion.pdf_1_4,theme: pw.ThemeData(),verbose: false);
    File imageFile = File(state.savedImage!.path);
    Uint8List imageBytes = await imageFile.readAsBytes();


    // Преобразование в MemoryImage
    final image = pw.Image(pw.MemoryImage(imageBytes));
    print(image.dpi);
    print(image.width);
    print(image.height);
    print(image.fit);
    print(image.box);
    print(image.alignment);

    pdf.addPage(pw.Page(
        pageFormat: getFormat(state.presets),
        build: (pw.Context context) {
          return image;
        }));
    final uint8List = await pdf.save();
    await savePdfToFile(uint8List);
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
      String filePath = path.join(downloadsDirectory.path, 'New ${DateTime.now()}.pdf');

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

  Uint8List compressImage(Uint8List imageBytes) {
    // Декодируем изображение
    final image = decodeImage(imageBytes);

    // Проверяем, было ли изображение декодировано успешно
    if (image == null) {
      throw Exception('Ошибка при декодировании изображения');
    }

    // Сжимаем изображение с уменьшением качества
    final compressedImage = encodeJpg(image, quality: 85);
    return compressedImage;
  }

  getFormat(Presets presets) {
    switch(presets){

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
}
