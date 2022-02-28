import 'dart:math';
import 'dart:typed_data';

import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/depth_builder.dart';
import 'package:sliding_puzzle/src/puzzle/provider/input/board_rotation_controller.dart';
import 'package:vector_math/vector_math.dart' as vector;

double perspective = 0.000000001;

class CustomCube extends StatelessWidget {
  const CustomCube({
    Key? key,
    required this.width,
    required this.height,
    required this.depth,
    required this.faceWidgets,
    required this.boardRotaioncontroller,
    this.depthOffset = 0,
    this.enableShadow = true,
    this.onTap,
  }) : super(key: key);
  static final light = vector.Vector3(0, 0, -1);
  final double width;
  final double height;
  final double depth;
  final double depthOffset;
  final VoidCallback? onTap;
  final CubeFaceWidgets faceWidgets;
  final BoardRotationController boardRotaioncontroller;
  final bool enableShadow;
  @override
  Widget build(BuildContext context) {
    final v1 = vector.Vector3(depth, depth, 0);
    final v2 = vector.Vector3(-depth, depth, 0);
    final v3 = vector.Vector3(-depth, -depth, 0);

    List<CubeFace> faces = [
      ///
      ///up Face
      ///
      CubeFace(
          transform: vector.Matrix4.identity()
            // ..setEntry(3, 2, perspective)
            ..translate(0.0, 0.0, depthOffset)
            ..rotateX(-pi / 2),
          width: width,
          height: depth,
          child: faceWidgets.upFace),

      ///
      ///Right Face
      ///
      CubeFace(
          transform: vector.Matrix4.identity()
            // ..setEntry(3, 2, perspective)
            ..translate(0.0, 0.0, depthOffset)
            ..translate(width, 0, 0)
            ..rotateY(pi / 2),
          width: depth,
          height: height,
          child: faceWidgets.rightFace),

      ///
      ///Left Face
      ///
      CubeFace(
          transform: vector.Matrix4.identity()
            // ..setEntry(3, 2, perspective)
            ..translate(0.0, 0.0, depthOffset)
            ..rotateY(pi / 2),
          width: depth,
          height: height,
          // color: Colors.pink,
          child: faceWidgets.leftFace),

      ///
      ///down Face
      ///
      CubeFace(
          transform: vector.Matrix4.identity()
            // ..setEntry(3, 2, perspective)
            ..translate(0.0, 0.0, depthOffset)
            ..translate(0.0, height, 0)
            ..rotateX(-pi / 2),
          width: width,
          height: depth,
          // color: Colors.teal,
          child: faceWidgets.downFace),

      ///
      /// Top Face
      ///
      CubeFace(
          transform: vector.Matrix4.identity()
            // ..setEntry(3, 2, perspective)
            ..translate(0.0, 0.0, depthOffset)
            ..translate(0.0, 0.0, -depth),
          width: width,
          height: height,
          child: faceWidgets.topFace),
    ];

    List<Widget> faceWidgetsList = [];
    for (var item in faces) {
      faceWidgetsList
          .add(item.child.call(context, Size(item.width, item.height)));
    }

    return DepthBuilder(
        rotationController: boardRotaioncontroller,
        builder: (context, offset) {
          final angleY = (offset.dy);
          final angleX = (offset.dx);
          final cameraMatrix = vector.Matrix4.identity()
            // ..translate(width, height, 0)
            ..multiply(vector.Matrix4.identity()
              ..setEntry(3, 2, perspective)
              ..rotateX(angleY)
              ..rotateY(angleX));
          List<int> sortedKeys = createZOrder(faces, cameraMatrix);
          // List<CubeFace> sortedFaces = [];

          final List<Widget> facesInOrder = [];
          for (var i in sortedKeys.reversed.toList()) {
            // sortedFaces.insert(0, faces[i]);
            final e = faces[i];
            final finalMatrix = cameraMatrix.multiplied(e.transform);
            final normalVector = normalVector3(
              finalMatrix.transformed3(v1),
              finalMatrix.transformed3(v2),
              finalMatrix.transformed3(v3),
            ).normalized();
            final directionBrightness = normalVector.dot(light).clamp(0.0, 1.0);

            var sizedBox = SizedBox(
              width: e.width,
              height: e.height,
              child: Stack(
                children: [
                  faceWidgetsList[i],
                  if (enableShadow)
                    Container(
                      color: Colors.black.withOpacity(
                        (0.25 - (directionBrightness * 0.25)),
                      ),
                      child: const Center(),
                    )
                ],
              ),
            );
            facesInOrder.insert(
                0,
                Transform(
                  transform: Matrix4.fromFloat64List(
                      Float64List.fromList(e.transform.storage)),

                  // color: e.color,
                  child: onTap == null
                      ? sizedBox
                      : DeferPointer(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: onTap,
                            child: sizedBox,
                          ),
                        ),
                ));
          }

          return Stack(
              // clipBehavior: Clip.none,
              children: facesInOrder);
        });
  }

  List<int> createZOrder(
    List<CubeFace> _positions,
    vector.Matrix4 matrix,
  ) {
    final renderOrder = <int, double>{};
    final pos = vector.Vector3.zero();
    for (int i = 0; i < _positions.length; i++) {
      var tmp = matrix.multiplied(_positions[i].transform);
      pos.x = _positions[i].rect.center.dx;

      /// Side
      pos.y = _positions[i].rect.center.dy;

      /// Side
      pos.z = 0.0;
      var t = tmp.transform3(pos).z;
      renderOrder[i] = t;
    }

    return renderOrder.keys.toList(growable: false)
      ..sort((a, b) => renderOrder[b]!.compareTo(renderOrder[a]!));
  }
}

class CubeFace {
  final vector.Matrix4 transform;
  final double width;
  final double height;
  Rect get rect => Rect.fromLTRB(0, 0, width, height);
  final Widget Function(BuildContext context, Size size) child;

  CubeFace({
    required this.transform,
    required this.width,
    required this.height,
    required this.child,
  });
}

vector.Vector3 normalVector3(
    vector.Vector3 v1, vector.Vector3 v2, vector.Vector3 v3) {
  vector.Vector3 s1 = vector.Vector3.copy(v2);
  s1.sub(v1);
  vector.Vector3 s3 = vector.Vector3.copy(v2);
  s3.sub(v3);

  return vector.Vector3(
    (s1.y * s3.z) - (s1.z * s3.y),
    (s1.z * s3.x) - (s1.x * s3.z),
    (s1.x * s3.y) - (s1.y * s3.x),
  );
}

class CubeFaceWidgets {
  final Widget Function(BuildContext context, Size size) topFace;
  final Widget Function(BuildContext context, Size size) leftFace;
  final Widget Function(BuildContext context, Size size) rightFace;
  final Widget Function(BuildContext context, Size size) upFace;
  final Widget Function(BuildContext context, Size size) downFace;

  CubeFaceWidgets({
    required this.topFace,
    required this.leftFace,
    required this.rightFace,
    required this.upFace,
    required this.downFace,
  });

  factory CubeFaceWidgets.all(
      Widget Function(BuildContext context, Size size) face) {
    return CubeFaceWidgets(
      topFace: face,
      leftFace: face,
      rightFace: face,
      upFace: face,
      downFace: face,
    );
  }

  factory CubeFaceWidgets.symetric(
      Widget Function(BuildContext context, Size size) top,
      Widget Function(BuildContext context, Size size) vertical,
      Widget Function(BuildContext context, Size size) horizontal) {
    return CubeFaceWidgets(
      topFace: top,
      leftFace: horizontal,
      rightFace: horizontal,
      upFace: vertical,
      downFace: vertical,
    );
  }
}
