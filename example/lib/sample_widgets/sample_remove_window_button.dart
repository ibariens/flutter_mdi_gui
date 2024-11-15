import 'package:flutter/material.dart';
import 'package:flutter_mdi_gui/flutter_mdi_gui.dart';

/// Sample button that demonstrates how to use Provider to close a widget from inside the body.
class SampleRemoveWindowFromInside extends StatelessWidget {
  const SampleRemoveWindowFromInside({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          MdiController.closeWindowIn(context);
        },
        child: const Text("Remove me from within window widget."));
  }
}
