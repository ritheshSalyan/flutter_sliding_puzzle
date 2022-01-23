import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/keyboard/keyboard_controller.dart';

class CustomKeyboardActionListner extends StatelessWidget {
  const CustomKeyboardActionListner(
      {Key? key, required this.controller, required this.child})
      : super(key: key);
  final KeyboardController controller;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      actions: controller.actions,
      shortcuts: controller.shortcuts,
      autofocus: true,
      child: child,
    );
  }
}
