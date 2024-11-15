

## FlutterMDI

[![License: MIT][license_badge]][license_link]

  

This package provides a Multi-Document Interface ([wiki](https://en.wikipedia.org/wiki/Multiple-document_interface)) for Flutter applications with a focus on speed, easy to use and extendibility. The code is inspired from [Achref Faidi's FlutterGUI](https://github.com/achreffaidi/FlutterGUI) and uses [Provider](https://pub.dev/packages/provider) for its state management. 

A sample project is provided in the /example folder

  
# Getting started

  

## Installing

  

1. Add dependencies to `pubspec.yaml`
```yaml

dependencies:

  flutter_mdi_gui: <latest-version>

```

  

2. Run the following command to fetch the dependencies.

```shell
flutter pub get
```
  
3. Import package.
```dart
import 'package:flutter_mdi_gui/flutter_mdi_gui.dart';
```

## Implementation

1. Add `FlutterMdi` in the tree where all the windows should be displayed.
```dart
MaterialApp(
  home: Scaffold(
      appBar: AppBar(
      title: const Text('MDI Example'),
    ),
    body: FlutterMdi(
            mdiConfig: const MdiConfig(
              borderRadius: 3.0,
              defaultHeaderColor: Colors.blueAccent,
            ),
            child: Text("your app comes here")
    ),
  )
);
```


2. Create a window with `MdiController.addWindowTo` method.

```dart 
TextButton(
  child: const Text("Create static window"),
  onPressed: () {
    MdiController.addWindowTo(
      context,
      title: "Sample static window",
      body: const Text("This is a sample static window"),
    );
  },
);
```
  
  

3. Close a window from everywhere below the window tree with the ` MdiController.closeWindowIn` method.
```dart
TextButton(
  onPressed: () {
    MdiController.closeWindowIn(context);
  },
  child: const Text("Remove me from within window widget.")
);
 
```  

 
## Known limitations
- The ⤡ ⤢ cursors are not supported on Mac Desktop, see: https://github.com/flutter/flutter/issues/89351
  

## Screenshot
![Sample app in action](https://github.com/ibariens/flutter_mdi_gui/blob/main/recordings/flutter_mdi_gui-1731675851519.gif)

## Thanks
Thank you for using this package and keep supporting opensource community.

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/mit
