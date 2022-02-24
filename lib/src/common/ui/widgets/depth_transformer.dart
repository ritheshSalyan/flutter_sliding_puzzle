import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/depth_builder.dart';
import 'package:sliding_puzzle/src/common/util/offset_extension.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';

class DepthTransformer extends StatelessWidget {
  const DepthTransformer({
    Key? key,
    required this.rotationController,
    required this.child,
    this.maxRotation,
    this.minRotation,
  }) : super(key: key);

  final BoardRotationController rotationController;
  final Widget child;

  final Offset? maxRotation;
  final Offset? minRotation;
  @override
  Widget build(BuildContext context) {
    return DepthBuilder(
        rotationController: rotationController,
        builder: (context, original) {
          final offset = original.clamp(
              minRotation ?? BoardRotationController.minAngle,
              maxRotation ?? BoardRotationController.maxAngle);
          final angleY = (offset.dy);
          final angleX = (offset.dx);
          return Transform(
            transform: Matrix4.identity()
              // ..setEntry(3, 2, perspective)
              ..rotateX(angleY)
              ..rotateY(angleX)
              ..translate(0.0, 0.0, 0),
            alignment: FractionalOffset.center,
            child: child,
          );
        });
  }
}
