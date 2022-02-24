import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white54,
        appBar: AppBar(),
        body: const Text("Sort it based on Height in asending order."));
  }
}
