import 'package:flutter/material.dart';
import 'package:flutter_mdi_gui/flutter_mdi_gui.dart';

import 'sample_widgets/sample_clock_body.dart';
import 'sample_widgets/sample_info_body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('MDI Example'),
          ),
          body: FlutterMdiGui(
            mdiConfig: const MdiConfig(
              borderRadius: 3.0,
              defaultBodyColor: Color.fromRGBO(255, 255, 255, 0.9),
              defaultHeaderColor: Color.fromRGBO(12, 12, 255, 0.3),
            ),
            child: Builder(builder: (context) {
              return Center(
                child: Column(
                  children: [
                    TextButton(
                        child: const Text("Create static window"),
                        onPressed: () {
                          MdiController.addWindowTo(context,
                              title: "Sample window with state information",
                              minWidth: 455.0,
                              minHeight: 300.0,
                              body: const SampleInfoBody());
                        }),
                    TextButton(
                        child: const Text("Create refreshing window"),
                        onPressed: () {
                          MdiController.addWindowTo(context,
                              title:
                                  "Sample window with state information and self updating clock",
                              minWidth: 455.0,
                              minHeight: 300.0,
                              body: const SampleClockBody());
                        }),
                  ],
                ),
              );
            }),
          )),
    );
  }
}
