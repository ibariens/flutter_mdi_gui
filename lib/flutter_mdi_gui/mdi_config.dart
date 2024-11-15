import 'package:flutter/material.dart';

class MdiConfig {
  final bool showKeyInHeader;
  final List<BoxShadow> windowBoxShadows;
  final double borderRadius;
  final double headerHeight;
  final double dragAreaSize;
  final Color defaultBodyColor;
  final Color defaultHeaderColor;
  final double defaultWindowMinWidth;
  final double defaultWindowMinHeight;
  final double defaultWindowHeight;
  final double defaultWindowWidth;
  final double defaultX;
  final double defaultY;

  const MdiConfig(
      {this.showKeyInHeader = true,
      this.borderRadius = 4.0,
      this.headerHeight = 24.0,
      this.dragAreaSize = 4.0,
      this.defaultBodyColor = Colors.red,
      this.defaultHeaderColor = Colors.green,
      this.defaultWindowMinWidth = 100.0,
      this.defaultWindowMinHeight = 100.0,
      this.defaultWindowHeight = 100.0,
      this.defaultWindowWidth = 100.0,
      this.defaultX = 100.0,
      this.defaultY = 100.0,
      this.windowBoxShadows = const [
        BoxShadow(
          color: Color(0x53000000),
          spreadRadius: 1.8,
          blurRadius: 2.8,
        )
      ]});
}
