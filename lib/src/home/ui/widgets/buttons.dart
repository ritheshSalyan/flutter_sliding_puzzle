import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/cube.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

import '../../../common/ui/widgets/depth_transformer.dart';

class PuzzleFilledButton extends ConsumerWidget {
  const PuzzleFilledButton(
      {Key? key,
      required this.child,
      required this.rotationController,
      this.onTap})
      : super(key: key);
  final Widget child;
  final BoardRotationController rotationController;

  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, ref) {
    final Color buttonColor =
        ref.watch(ThemeNotifier.provider).foregroundColor; // Colors.green;
    return DepthTransformer(
      rotationController: rotationController,
      minRotation: const Offset(-0.2, -0.2),
      maxRotation: const Offset(0.2, 0.2),
      child: CustomCube(
        boardRotaioncontroller: rotationController,
        onTap: onTap,
        width: 100,
        height: 50,
        depth: 30,
        faceWidgets: CubeFaceWidgets.symetric(
          (context, size) => Container(
            color: buttonColor,
            child: Center(child: child),
          ),
          (context, size) => Container(
            child: const Center(),
            color: buttonColor,
          ),
          (context, size) => Container(
            child: const Center(),
            color: buttonColor,
          ),
        ),
      ),
    );
  }
}
