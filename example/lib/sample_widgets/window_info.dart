import 'package:flutter/material.dart';
import 'package:flutter_mdi_gui/flutter_mdi_gui.dart';
import 'package:provider/provider.dart';

class WindowInfo extends StatelessWidget {
  const WindowInfo({super.key});

  /// Example how to access the WindowState through Provider.
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(12.0),
            child: Consumer<WindowState>(builder: (context, state, child) {
              return Table(
                children: [
                  TableRow(
                    children: [
                      const Text("Last build:"),
                      Text(DateTime.now().toIso8601String()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Key:"),
                      Text(state.key.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Width:"),
                      Text(state.width.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("Height:"),
                      Text(state.height.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("minWidth:"),
                      Text(state.minWidth.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("minHeight:"),
                      Text(state.minHeight.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("x:"),
                      Text(state.x.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text("y:"),
                      Text(state.y.toString()),
                    ],
                  ),
                ],
              );
            })),
      ],
    );
  }
}
