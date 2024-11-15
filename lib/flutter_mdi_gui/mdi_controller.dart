import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mdi_config.dart';
import 'window_state.dart';

class MdiController extends ChangeNotifier {
  final MdiConfig config;
  final List<WindowState> _windows = [];

  MdiController({required this.config});

  UnmodifiableListView<WindowState> get windows =>
      UnmodifiableListView(_windows);

  addWindow({
    required String title,
    required Widget body,
    Alignment? parentWidgetAlignment,
    double? minWidth,
    double? minHeight,
    double? width,
    double? height,
    double? placementPadding,
    double? x,
    double? y,
    Color? headerColor,
    Color? bodyColor,
  }) {
    final windowState = WindowState(
      key: UniqueKey(),
      config: config,
      title: title,
      body: body,
      headerColor: headerColor,
      bodyColor: bodyColor,
      minWidth: minWidth,
      minHeight: minHeight,
      height: height,
      width: width,
      x: x,
      y: y,
    );

    _windows.add(windowState);
    notifyListeners();
  }

  closeWindow(Key key) {
    final window = _findWindowWithIndex(key);
    _windows.remove(window.windowState);
    notifyListeners();
  }

  dragWindow({required Key key, required double dx, required double dy}) {
    final wwi = _findWindowWithIndex(key);

    final newWindow = wwi.windowState.copyWith(
      x: wwi.windowState.x + dx,
      y: wwi.windowState.y + dy,
    );

    _windows[wwi.index] = newWindow;
    notifyListeners();
  }

  onFocus(Key key) {
    _moveOnTop(key: key);
    notifyListeners();
  }

  resizeWindow(
      {required Key key,
      required double dx,
      required double dy,
      bool moveHorizontalBase = false,
      bool moveVerticalBase = false}) {
    final wwi = _findWindowWithIndex(key);
    final newWindow = wwi.windowState.copyWith(
      x: moveHorizontalBase &&
              wwi.windowState.width + dx > wwi.windowState.minWidth
          ? wwi.windowState.x - dx
          : null,
      y: moveVerticalBase &&
              wwi.windowState.height + dy > wwi.windowState.minHeight
          ? wwi.windowState.y - dy
          : null,
      width: (wwi.windowState.width + dx)
          .clamp(wwi.windowState.minWidth, double.infinity),
      height: (wwi.windowState.height + dy)
          .clamp(wwi.windowState.minHeight, double.infinity),
    );
    _windows[wwi.index] = newWindow;
    notifyListeners();
  }

  ({WindowState windowState, int index}) _findWindowWithIndex(Key key) {
    final index = _windows.indexWhere((x) => x.key == key);
    if (index == -1) {
      throw ("MdiController error: can't find window with key $key");
    } else {
      return (windowState: _windows[index], index: index);
    }
  }

  _moveOnTop({required Key key}) {
    final wwi = _findWindowWithIndex(key);

    final isOnTop = wwi.index == _windows.length - 1;
    if (isOnTop) {
      _windows[wwi.index] = wwi.windowState;
    } else {
      _windows.removeAt(wwi.index);
      _windows.add(wwi.windowState);
    }
  }

  static void addWindowTo(
    BuildContext context, {
    required String title,
    required Widget body,
    Alignment? parentWidgetAlignment,
    double? minWidth,
    double? minHeight,
    double? width,
    double? height,
    double? placementPadding,
    double? x,
    double? y,
    Color? headerColor,
    Color? bodyColor,
  }) {
    Provider.of<MdiController>(context, listen: false).addWindow(
      title: title,
      body: body,
      parentWidgetAlignment: parentWidgetAlignment,
      minWidth: minWidth,
      minHeight: minHeight,
      width: width,
      height: height,
      placementPadding: placementPadding,
      x: x,
      y: y,
    );
  }

  static void closeWindowIn(BuildContext context) {
    final key = Provider.of<WindowState>(context, listen: false).key;
    Provider.of<MdiController>(context, listen: false).closeWindow(key);
  }
}
