import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:vector_math/vector_math_64.dart';

mixin DepthObject on Widget {
  double get centerX;
  double get centerY;
  double get centerZ => 0.0;
}

class DepthResolver extends StatefulWidget {
  const DepthResolver(
      {Key? key, required this.objects, required this.rotationController})
      : super(key: key);
  final List<DepthObject> objects;
  final BoardRotationController rotationController;
  @override
  State<DepthResolver> createState() => _DepthResolverState();
}

class _DepthResolverState extends State<DepthResolver> {
  @override
  Widget build(BuildContext context) {
    return DepthBuilder(
      rotationController: widget.rotationController,
      builder: (context, angle) {
        final angleY = (angle.dy);
        final angleX = (angle.dx);
        final cameraMatrix = Matrix4.identity()
          // ..translate(width, height, 0)
          ..multiply(Matrix4.identity()
            ..setEntry(3, 2, perspective)
            ..rotateX(angleY)
            ..rotateY(angleX));
        List<int> sortedKeys = createZOrder(widget.objects, cameraMatrix);
        // List<CubeFace> sortedFaces = [];

        final List<Widget> facesInOrder = [];

        for (var item in sortedKeys) {
          facesInOrder.add(widget.objects[item]);
        }

        return Stack(
          clipBehavior: Clip.none,
          children: facesInOrder,
        );
      },
    );
  }

  List<int> createZOrder(
    List<DepthObject> _positions,
    Matrix4 matrix,
  ) {
    final renderOrder = <int, double>{};
    final pos = Vector3.zero();
    for (int i = 0; i < _positions.length; i++) {
      // var tmp = matrix;
      pos.x = _positions[i].centerX;

      /// Side
      pos.y = _positions[i].centerY;

      /// Side
      pos.z = _positions[i].centerZ;
      var t = matrix.transform3(pos).z;
      renderOrder[i] = t;
    }

    return renderOrder.keys.toList(growable: false)
      ..sort((a, b) => renderOrder[b]!.compareTo(renderOrder[a]!));
  }
}
