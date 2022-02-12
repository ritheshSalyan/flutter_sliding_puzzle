import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/app_module.dart';
import 'package:sliding_puzzle/app_widget.dart';

void main() {
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
