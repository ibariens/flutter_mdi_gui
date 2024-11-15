import 'package:flutter/material.dart';

import 'sample_remove_window_button.dart';
import 'window_info.dart';

class SampleInfoBody extends StatelessWidget {
  const SampleInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WindowInfo(),
        SampleRemoveWindowFromInside(),
      ],
    );
  }
}
