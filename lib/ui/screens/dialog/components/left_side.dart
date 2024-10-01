import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/bloc/scan_document_bloc/scan_document_bloc.dart';
import 'package:untitled1/services/capture_screen_shot_service.dart';
import 'package:untitled1/ui/screens/components/app_button.dart';
import 'package:untitled1/ui/screens/components/resizable_draggable_widget.dart';

class LeftSide extends StatefulWidget {
  const LeftSide({super.key});

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  final GlobalKey _resizableKey = GlobalKey();

  Future<void> _captureScreenshot() async {
    final imageBytes = await CaptureScreenShotService().capture(_resizableKey);
    print(imageBytes);
    if (imageBytes != null) {
      final pdf = pw.Document(
          version: PdfVersion.pdf_1_4, theme: pw.ThemeData(), verbose: false);
      // Преобразование в MemoryImage
      final image = pw.Image(pw.MemoryImage(imageBytes));
      print(image.dpi);
      print(image.width);
      print(image.height);
      print(image.fit);
      print(image.box);
      print(image.alignment);

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return image;
          }));
      final uint8List = await pdf.save();
      await savePdfToFile(uint8List);
    }
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

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MainBloc, MainState, XFile?>(
      selector: (state) {
        return state.savedImage;
      },
      builder: (context, savedImage) {
        if (savedImage == null) {
          return const SizedBox();
        }

        return Stack(
          children: [
            Image.file(
              File(savedImage.path),
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  print(context.size);
                  BlocProvider.of<ScanDocumentBloc>(context).add(
                      ChangeImageSize(
                          imageSize:
                              Size(context.size!.width, context.size!.height)));
                });
                return child;
              },
            ),
            BlocSelector<ScanDocumentBloc, ScanDocumentState, Size>(
              selector: (state) {
                return Size(state.imageWidth, state.imageHeight);
              },
              builder: (context, state) {
                return ResizableDraggableWidget(
                  key: _resizableKey,
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(onPressed: ()async{_captureScreenshot();}, child: Text("save")),
            )
          ],
        );
      },
    );
  }
}
