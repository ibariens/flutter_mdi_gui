import 'package:flutter/material.dart';

import 'window_info.dart';

class SampleClockBody extends StatelessWidget {
  const SampleClockBody({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Column(
          children: [
            const WindowInfo(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Table(children: [
                TableRow(
                  children: [
                    const Text("Current time:"),
                    Text(DateTime.now().toIso8601String()),
                  ],
                )
              ]),
            ),
          ],
        );
      },
    );
  }
}
