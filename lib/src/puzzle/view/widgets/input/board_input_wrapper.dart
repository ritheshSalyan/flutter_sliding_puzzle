import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/puzzle.dart';

import 'keyboard_listner.dart';

class BoardInputWrapper extends ConsumerWidget {
  const BoardInputWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context, ref) {
    return DeferredPointerHandler(
      child: CustomKeyboardActionListner(
        controller: ref.watch(BoardUIController.provider),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanUpdate: (details) {
            ref.read(BoardUIController.provider).rotateBoardBy(
                Offset(-details.delta.dx * 0.01, details.delta.dy * 0.01));
          },
          onPanEnd: (details) {
            // ref.read(BoardUIController.provider).resetRotation();
          },
          child: child,
        ),
      ),
    );
  }
}
