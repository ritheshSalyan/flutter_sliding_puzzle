import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/app_widget.dart';
import 'package:libwinmedia/libwinmedia.dart'
    if (dart.library.html) 'dummy_dart_vlc.dart';
import 'package:universal_platform/universal_platform.dart';
void main() {
     if (UniversalPlatform.isWindows || UniversalPlatform.isLinux) {
      // DartVLC.initialize();
      LWM.initialize();
    }
  runApp(ProviderScope(
      child: ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  )));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const PuzzlePage(),
//     );
//   }
// }
