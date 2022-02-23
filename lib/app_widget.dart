import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: const Color(0xFF4f1611),
          appBarTheme: const AppBarTheme(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.green)),
      // home: const PuzzlePage(),
    ); //added by extension
  }
}
