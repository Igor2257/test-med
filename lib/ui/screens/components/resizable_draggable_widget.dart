import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bloc/scan_document_bloc/scan_document_bloc.dart';

class ResizableDraggableWidget extends StatelessWidget {
  const ResizableDraggableWidget({
    Key? key,
  }) : super(key: key);

  void _updatePosition(Offset delta,BuildContext context) {
    BlocProvider.of<ScanDocumentBloc>(context).add(UpdatePosition(delta: delta));
  }

  void _updateSize(double dx, double dy,BuildContext context) {
    BlocProvider.of<ScanDocumentBloc>(context).add(UpdateSize(dx: dx, dy: dy));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanDocumentBloc, ScanDocumentState>(
      builder: (context, state) {
        return Positioned(
          left: state.position.dx,
          top: state.position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              if (!state.isResizing) {
                _updatePosition(details.delta,context);
              }
            },
            child: MouseRegion(
              cursor: _getCursorForPosition(
                state.isResizing,
              ),
              child: SizedBox(
                width: state.imageWidth,
                height: state.imageHeight,
                child: Stack(
                  children: [
                    // Обработчики для изменения размеров по сторонам
                    _buildSideResizeHandle(
                      alignment: Alignment.topCenter,
                      onDrag: (dx, dy) {
                        _updateSize(0, -dy,context);
                        _updatePosition(Offset(0, dy),context); // Корректируем позицию
                      },
                      cursor: SystemMouseCursors.resizeUpDown,
                      isResizing: state.isResizing,
                    ),
                    _buildSideResizeHandle(
                      alignment: Alignment.bottomCenter,
                      onDrag: (dx, dy) {
                        _updateSize(0, dy,context);
                      },
                      cursor: SystemMouseCursors.resizeUpDown,
                      isResizing: state.isResizing,
                    ),
                    _buildSideResizeHandle(
                      alignment: Alignment.centerLeft,
                      onDrag: (dx, dy) {
                        _updateSize(-dx, 0,context);
                        _updatePosition(Offset(dx, 0),context); // Корректируем позицию
                      },
                      cursor: SystemMouseCursors.resizeLeftRight,
                      isResizing: state.isResizing,
                    ),
                    _buildSideResizeHandle(
                      alignment: Alignment.centerRight,
                      onDrag: (dx, dy) {
                        _updateSize(dx, 0,context);
                      },
                      cursor: SystemMouseCursors.resizeLeftRight,
                      isResizing: state.isResizing,
                    ),
                    // Углы
                    _buildResizeHandle(
                      alignment: Alignment.topLeft,
                      onDrag: (dx, dy) {
                        _updateSize(-dx, -dy,context);
                        _updatePosition(Offset(dx, dy),context); // Корректируем позицию
                      },
                      cursor: SystemMouseCursors.resizeUpLeftDownRight,
                      isResizing: state.isResizing,
                    ),
                    _buildResizeHandle(
                      alignment: Alignment.topRight,
                      onDrag: (dx, dy) {
                        _updateSize(dx, -dy,context);
                        _updatePosition(Offset(0, dy),context); // Корректируем позицию
                      },
                      cursor: SystemMouseCursors.resizeUpRightDownLeft,
                      isResizing: state.isResizing,
                    ),
                    _buildResizeHandle(
                      alignment: Alignment.bottomLeft,
                      onDrag: (dx, dy) {
                        _updateSize(-dx, dy,context);
                        _updatePosition(Offset(dx, 0),context); // Корректируем позицию
                      },
                      cursor: SystemMouseCursors.resizeUpRightDownLeft,
                      isResizing: state.isResizing,
                    ),
                    _buildResizeHandle(
                      alignment: Alignment.bottomRight,
                      onDrag: (dx, dy) {
                        _updateSize(dx, dy,context);
                      },
                      cursor: SystemMouseCursors.resizeUpLeftDownRight,
                      isResizing: state.isResizing,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResizeHandle({
    required Alignment alignment,
    required Function(double, double) onDrag,
    required SystemMouseCursor cursor,
    required bool isResizing,
  }) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onPanStart: (_) => isResizing = true,
        onPanEnd: (_) => isResizing = false,
        onPanUpdate: (details) {
          onDrag(details.delta.dx, details.delta.dy);
        },
        child: MouseRegion(
          cursor: cursor,
          child: Container(
            width: 10, // Широкие зоны для углов
            height: 10,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildSideResizeHandle({
    required Alignment alignment,
    required Function(double, double) onDrag,
    required SystemMouseCursor cursor,
    required bool isResizing,
  }) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onPanStart: (_) => isResizing = true,
        onPanEnd: (_) => isResizing = false,
        onPanUpdate: (details) {
          onDrag(details.delta.dx, details.delta.dy);
        },
        child: MouseRegion(
          cursor: cursor,
          child: Container(
            width: alignment == Alignment.topCenter ||
                    alignment == Alignment.bottomCenter
                ? double
                    .infinity // Для верхней и нижней стороны захватываем всю ширину
                : 10, // Для левой и правой стороны небольшая ширина
            height: alignment == Alignment.centerLeft ||
                    alignment == Alignment.centerRight
                ? double
                    .infinity // Для левой и правой стороны захватываем всю высоту
                : 10, // Для верхней и нижней стороны небольшая высота
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: alignment == Alignment.topCenter
                  ? const Border(
                      top: BorderSide(color: Colors.green, width: 3),
                    )
                  : alignment == Alignment.bottomCenter
                      ? const Border(
                          bottom: BorderSide(color: Colors.green, width: 3),
                        )
                      : alignment == Alignment.centerLeft
                          ? const Border(
                              left: BorderSide(color: Colors.green, width: 3),
                            )
                          : alignment == Alignment.centerRight
                              ? const Border(
                                  right:
                                      BorderSide(color: Colors.green, width: 3),
                                )
                              : null,
            ), // Прозрачная зона для захвата
          ),
        ),
      ),
    );
  }

  SystemMouseCursor _getCursorForPosition(
    bool isResizing,
  ) {
    return isResizing
        ? SystemMouseCursors.resizeUpLeftDownRight
        : SystemMouseCursors.move;
  }
}
