import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mdi_config.dart';
import 'mdi_controller.dart';
import 'window_state.dart';

/// Widget that represents the actual window, which is a wrapper around the body.
class ResizableWindow extends StatelessWidget {
  final WindowState windowState;
  final MdiConfig config;
  const ResizableWindow(
      {super.key, required this.windowState, required this.config});

  @override
  Widget build(BuildContext context) {
    final mdiController = Provider.of<MdiController>(context, listen: false);

    return ChangeNotifierProvider.value(
      value: windowState,
      child: _ResizableWindow(
          config: config,
          windowState: windowState,
          onDragStart: () {
            mdiController.onFocus(windowState.key);
          },
          onClose: () {
            mdiController.closeWindow(windowState.key);
          },
          onDrag: (dx, dy) {
            mdiController.dragWindow(key: windowState.key, dx: dx, dy: dy);
          },
          onResize: ({
            required double dx,
            required double dy,
            required bool moveHorizontalBase,
            required bool moveVerticalBase,
          }) {
            mdiController.resizeWindow(
              key: windowState.key,
              dx: dx,
              dy: dy,
              moveHorizontalBase: moveHorizontalBase,
              moveVerticalBase: moveVerticalBase,
            );
          }),
    );
  }
}

class _Body extends StatelessWidget {
  final double headerHeight;
  final WindowState windowState;
  final Color bodyColor;

  const _Body(
      {required this.headerHeight,
      required this.windowState,
      required this.bodyColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: windowState.width,
      height: windowState.height - headerHeight,
      color: bodyColor,
      child: windowState.body,
    );
  }
}

class _Header extends StatelessWidget {
  final MdiConfig config;
  final double headerHeight;
  final WindowState windowState;
  final VoidCallback onClose;
  final VoidCallback onDragStart;
  final Color headerColor;
  final Function(double dx, double dy) onDrag;

  const _Header({
    required this.config,
    required this.headerHeight,
    required this.windowState,
    required this.onDragStart,
    required this.onClose,
    required this.onDrag,
    required this.headerColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onPanStart: (_) {
        onDragStart();
      },
      onPanUpdate: (details) {
        onDrag(details.delta.dx, details.delta.dy);
      },
      child: Container(
        width: windowState.width,
        height: headerHeight,
        color: headerColor,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: onClose,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      size: headerHeight * .6,
                      Icons.circle,
                      color: Colors.red,
                    ),
                    Icon(
                      size: headerHeight * .5,
                      Icons.close,
                      color: const Color.fromRGBO(137, 2, 2, 1),
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                  child: Padding(
                /// Ensure a title is not overlapping with the window buttons.
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                    config.showKeyInHeader
                        ? "${windowState.title} (${windowState.key}}"
                        : windowState.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white)),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

/// Creates the frame around the widget that represents a window.
/// It creates GestureDetectors around every edge, including the corners for resizing purposes
/// Note ⤡ ⤢ cursors are not supported on Mac Desktop, see: https://github.com/flutter/flutter/issues/89351

class _ResizableWindow extends StatelessWidget {
  final MdiConfig config;
  final WindowState windowState;
  final VoidCallback onClose;
  final VoidCallback onDragStart;
  final Function(double dx, double dy) onDrag;
  final Function(
      {required double dx,
      required double dy,
      required bool moveHorizontalBase,
      required bool moveVerticalBase}) onResize;

  const _ResizableWindow({
    required this.config,
    required this.windowState,
    required this.onClose,
    required this.onDragStart,
    required this.onDrag,
    required this.onResize,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: windowState.x,
      top: windowState.y,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(config.borderRadius)),
          boxShadow: config.windowBoxShadows,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(config.borderRadius)),
          child: Stack(
            children: [
              Column(
                children: [
                  _Header(
                      config: config,
                      headerHeight: config.headerHeight,
                      windowState: windowState,
                      onClose: onClose,
                      onDragStart: onDragStart,
                      onDrag: onDrag,
                      headerColor: windowState.headerColor),
                  _Body(
                      headerHeight: config.headerHeight,
                      windowState: windowState,
                      bodyColor: windowState.bodyColor),
                ],
              ),
              // Right
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragStart: (details) => onDragStart(),
                  onHorizontalDragUpdate: (details) => onResize(
                      dx: details.delta.dx,
                      dy: 0,
                      moveHorizontalBase: false,
                      moveVerticalBase: false),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: SizedBox(width: config.dragAreaSize),
                  ),
                ),
              ),
              // Left
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onHorizontalDragStart: (details) => onDragStart(),
                  onHorizontalDragUpdate: (details) => onResize(
                      dx: -details.delta.dx,
                      dy: 0,
                      moveHorizontalBase: true,
                      moveVerticalBase: false),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: SizedBox(width: config.dragAreaSize),
                  ),
                ),
              ),
              // Top
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) => onDragStart(),
                  onVerticalDragUpdate: (details) => onResize(
                      dx: 0,
                      dy: -details.delta.dy,
                      moveHorizontalBase: false,
                      moveVerticalBase: true),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    child: SizedBox(height: config.dragAreaSize),
                  ),
                ),
              ),
              // Bottom
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onVerticalDragStart: (details) => onDragStart(),
                  onVerticalDragUpdate: (details) => onResize(
                      dx: 0,
                      dy: details.delta.dy,
                      moveHorizontalBase: false,
                      moveVerticalBase: false),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    child: SizedBox(height: config.dragAreaSize),
                  ),
                ),
              ),
              // BottomRight
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onPanStart: (details) => onDragStart(),
                  onPanUpdate: (details) => onResize(
                      dx: details.delta.dx,
                      dy: details.delta.dy,
                      moveHorizontalBase: false,
                      moveVerticalBase: false),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    child: SizedBox(
                        width: config.dragAreaSize,
                        height: config.dragAreaSize),
                  ),
                ),
              ),
              // BottomLeft
              Positioned(
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onPanStart: (details) => onDragStart(),
                  onPanUpdate: (details) => onResize(
                      dx: -details.delta.dx,
                      dy: details.delta.dy,
                      moveHorizontalBase: true,
                      moveVerticalBase: false),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    child: SizedBox(
                        width: config.dragAreaSize,
                        height: config.dragAreaSize),
                  ),
                ),
              ),
              // TopRight
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onPanStart: (details) => onDragStart(),
                  onPanUpdate: (details) => onResize(
                      dx: details.delta.dx,
                      dy: -details.delta.dy,
                      moveHorizontalBase: false,
                      moveVerticalBase: true),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpRightDownLeft,
                    child: SizedBox(
                        width: config.dragAreaSize,
                        height: config.dragAreaSize),
                  ),
                ),
              ),
              //TopLeft
              Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onPanStart: (details) => onDragStart(),
                  onPanUpdate: (DragUpdateDetails details) => onResize(
                      dx: -details.delta.dx,
                      dy: -details.delta.dy,
                      moveHorizontalBase: true,
                      moveVerticalBase: true),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpLeftDownRight,
                    child: SizedBox(
                        width: config.dragAreaSize,
                        height: config.dragAreaSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
