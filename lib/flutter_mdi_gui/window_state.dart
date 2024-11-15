import 'dart:math';

import 'package:flutter/material.dart';

import 'mdi_config.dart';

/// Class that holds the state of the window.
class WindowState extends ChangeNotifier {
  final Key key;
  final MdiConfig config;
  late final Color headerColor;
  late final Color bodyColor;
  late final double minWidth;
  late final double minHeight;
  late final double height;
  late final double width;
  late final double x;
  late final double y;
  late final String title;
  late final Widget body;

  WindowState({
    required this.key,
    required this.config,
    Color? headerColor,
    Color? bodyColor,
    double? minWidth,
    double? minHeight,
    double? height,
    double? width,
    double? x,
    double? y,
    String? title,
    required this.body,
  })  : headerColor = headerColor ?? config.defaultHeaderColor,
        bodyColor = bodyColor ?? config.defaultBodyColor,
        minWidth = minWidth ?? config.defaultWindowMinWidth,
        minHeight = minHeight ?? config.defaultWindowMinHeight,
        height = max((minHeight ?? config.defaultWindowMinHeight),
            (height ?? config.defaultWindowHeight)),
        width = max((minWidth ?? config.defaultWindowMinWidth),
            (width ?? config.defaultWindowMinWidth)),
        x = x ?? config.defaultX,
        y = y ?? config.defaultY,
        title = title ?? "";

  WindowState copyWith({
    Key? key,
    double? minWidth,
    double? minHeight,
    double? height,
    double? width,
    double? x,
    double? y,
    String? title,
    Widget? body,
    Color? headerColor,
    Color? bodyColor,
  }) {
    return WindowState(
        key: key ?? this.key,
        minWidth: minWidth ?? this.minWidth,
        minHeight: minHeight ?? this.minHeight,
        height: height ?? this.height,
        width: width ?? this.width,
        x: x ?? this.x,
        y: y ?? this.y,
        title: title ?? this.title,
        body: body ?? this.body,
        headerColor: headerColor ?? this.headerColor,
        bodyColor: bodyColor ?? this.bodyColor,
        config: config);
  }

  @override
  String toString() {
    return "$title ($minWidth x $minHeight) - $key";
  }
}
