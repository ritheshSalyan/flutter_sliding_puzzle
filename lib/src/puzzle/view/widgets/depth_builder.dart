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
    Animation<Offset> animation = const AlwaysStoppedAnimation(Offset.zero);
    var rotationController =
        ref.watch(BoardUIController.provider).boardRotationController;

    useValueChanged(useValueListenable(rotationController.boardAngle),
        (_, void __) {
      animation = Tween<Offset>(
              begin: rotationController.previousValue,
              end: rotationController.boardAngle.value)
          .animate(CurvedAnimation(
              parent: _animationController, curve: Curves.easeInCubic));
      _animationController.forward(from: 0);
    });
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return builder.call(context, animation.value);
      },
    );
  }
}
