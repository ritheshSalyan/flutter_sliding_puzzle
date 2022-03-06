import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/util/offset_extension.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

class DepthBuilder extends HookConsumerWidget {
  const DepthBuilder({
    Key? key,
    required this.builder,
    required this.rotationController,
  }) : super(key: key);

  final Widget Function(BuildContext context, Offset offset) builder;
  final BoardRotationController rotationController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var rotationController =
    //     ref.watch(BoardUIController.provider).boardRotationController;

    Animation<Offset> animation =
        AlwaysStoppedAnimation(rotationController.boardAngle.value);
    final _animationController =
        useAnimationController(duration: const Duration(milliseconds: 250));
    useValueChanged(useValueListenable(rotationController.boardAngle),
        (Offset newOffset, Offset? previous) {
      animation = Tween<Offset>(
        begin: rotationController.previousValue,
        end: rotationController.boardAngle.value,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear),
      )..addListener(() {
          ///
          /// Store the progress of animation inorder ro continue next animation.
          ///
          /// This will be the starting point for next animation.
          ///
          rotationController.updatePrevious(animation.value);
        });

      _animationController.forward(from: 0);
      return rotationController.boardAngle.value;
    });
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return builder.call(
          context,
          animation.value.clamp(
            BoardRotationController.minAngle,
            BoardRotationController.maxAngle,
          ),
        );
      },
    );
  }
}
