import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/puzzle/provider/board_provider.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

class DepthBuilder extends HookConsumerWidget {
  const DepthBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, Offset offset) builder;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var rotationController =
        ref.watch(BoardUIController.provider).boardRotationController;

    Animation<Offset> animation =
        AlwaysStoppedAnimation(rotationController.boardAngle.value);
    final _animationController =
        useAnimationController(duration: const Duration(milliseconds: 500));
    useValueChanged(useValueListenable(rotationController.boardAngle),
        (Offset newOffset, Offset? previous) {
      final previousAnimationVal = animation.value;

      animation = Tween<Offset>(
              begin: (previous ?? rotationController.previousValue),
              // rotationController.previousValue, // previous ??
              end: rotationController.boardAngle.value)
          .animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear),
      );
      // }
      _animationController.forward(from: 0);
      return rotationController.boardAngle.value;
    });
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        // print("${animation.value}");

        return builder.call(
          context,
          animation.value.clamp(
            // const Offset(
            //   BoardRotationController.minAngle,
            BoardRotationController.minAngle,
            // ),
            // const Offset(
            //   BoardRotationController.maxAngle,
            BoardRotationController.maxAngle,
            // ),
          ),
        );
      },
    );
  }
}

extension OffsetExtension on Offset {
  Offset clamp(Offset min, Offset max) {
    return Offset(dx.clamp(min.dx, max.dx), dy.clamp(min.dy, max.dy));
  }
}
