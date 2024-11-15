import 'package:flutter/material.dart';
import 'package:flutter_mdi_gui/flutter_mdi_gui/mdi_config.dart';
import 'package:flutter_mdi_gui/flutter_mdi_gui/mdi_controller.dart';
import 'package:flutter_mdi_gui/flutter_mdi_gui/resizable_window.dart';
import 'package:provider/provider.dart';

export 'package:flutter_mdi_gui/flutter_mdi_gui/mdi_config.dart';
export 'package:flutter_mdi_gui/flutter_mdi_gui/mdi_controller.dart';
export 'package:flutter_mdi_gui/flutter_mdi_gui/window_state.dart';

class FlutterMdiGui extends StatelessWidget {
  final MdiConfig? mdiConfig;
  final Widget? child;
  const FlutterMdiGui({super.key, this.mdiConfig, this.child});

  @override
  Widget build(BuildContext context) {
    final config = mdiConfig ?? const MdiConfig();
    return ChangeNotifierProvider<MdiController>(
        create: (_) => MdiController(config: config),
        child: _FlutterMdi(config: config, child: child));
  }
}

class _FlutterMdi extends StatelessWidget {
  final MdiConfig config;
  final Widget? child;
  const _FlutterMdi({required this.config, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<MdiController>(
        builder: (context, manager, child) {
          return Stack(
              children: child != null
                  ? [child, ..._buildWindows(manager, config)]
                  : _buildWindows(manager, config));
        },
        child: child);
  }

  // Builds the list of resizable windows based on the current state
  List<Widget> _buildWindows(MdiController manager, MdiConfig config) {
    return List.generate(manager.windows.length, (index) {
      return ResizableWindow(
          key: manager.windows[index].key,
          windowState: manager.windows[index],
          config: config);
    });
  }
}
