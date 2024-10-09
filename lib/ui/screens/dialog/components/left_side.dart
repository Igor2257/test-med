import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/bloc/main_bloc/main_bloc.dart';
import 'package:untitled1/bloc/scan_document_bloc/scan_document_bloc.dart';
import 'package:untitled1/ui/screens/components/resizable_draggable_widget.dart';
import 'package:untitled1/ui/screens/dialog/components/screenshot_provider.dart';

class LeftSide extends StatefulWidget {
  const LeftSide({super.key});

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  @override
  Widget build(BuildContext context) {
    final screenshotProvider = Provider.of<ScreenshotProvider>(context);
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
            RepaintBoundary(
                key: screenshotProvider.firstLayerKey,
                child: Image.file(
                  File(savedImage.path),
                  filterQuality: FilterQuality.low,
                  colorBlendMode: BlendMode.clear,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      print(context.size);
                      BlocProvider.of<ScanDocumentBloc>(context).add(
                          ChangeImageSize(
                              imageSize: Size(
                                  context.size!.width, context.size!.height)));
                    });
                    return child;
                  },
                )),
            ResizableDraggableWidget(
              key: screenshotProvider.secondLayerKey,
            ),
          ],
        );
      },
    );
  }
}
