import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_provider.dart';

class DepthBuilder extends HookConsumerWidget {
  const DepthBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, Offset offset) builder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _animationController =
        useAnimationController(duration: const Duration(milliseconds: 250));
    var rotationController =
        ref.watch(BoardUIController.provider).boardRotationController;

    Animation<Offset> animation =
        AlwaysStoppedAnimation(rotationController.boardAngle.value);
    useValueChanged(useValueListenable(rotationController.boardAngle),
        (Offset newOffset, Offset? previous) {
          // if(newOffset.isNear(previous??Offset.zero)) return newOffset;
          print("$newOffset $previous");
          
      animation = Tween<Offset>(
              begin: previous ?? rotationController.previousValue,
              end: rotationController.boardAngle.value
              )
          .
          animate(CurvedAnimation(
              parent: _animationController, curve: Curves.linear));
      _animationController.forward(from: 0);
      return rotationController.boardAngle.value;
    });
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
          print("${animation.value}");

        return builder.call(context, animation.value);
      },
    );
  }
}
