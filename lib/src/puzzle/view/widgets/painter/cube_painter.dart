import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

///
///
/// Thanks to https://codepen.io/winteryf/pen/vYLRxQx for Providing way to display cube.
/// Modified the same to get rectangular.
///

class CubePainter extends CustomPainter {
  static final light = vector.Vector3(0, 0, -1);
  static final specularLight = Colors.white.withOpacity(0.9);

  final List<Color> colors;
  final double angleX;
  final double angleY;
  final int index;
  final ui.Image? image;
  List<Face> _positions = [];

  CubePainter({
    required this.angleX,
    required this.angleY,
    required this.colors,
    required this.index,
    this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.shortestSide * 0.75;
    final width = size.shortestSide * 0.75;
    var d = (width /2);
    final depth = d * (index + 1); // height * 0.5;
    // final cubeSize = depth; //size.shortestSide / 2;

    ///

    // final side = Rect.fromLTRB(-cubeSize, -cubeSize, cubeSize, cubeSize);
    final v1 = vector.Vector3(depth, depth, 0);
    final v2 = vector.Vector3(-depth, depth, 0);
    final v3 = vector.Vector3(-depth, -depth, 0);

    _positions = [
      Face(height, width,
          vector.Matrix4.identity()..translate(0.0, 0.0, -depth / 2)),
      Face(
          height,
          depth,
          vector.Matrix4.identity()
            ..rotate(vector.Vector3(1, 0, 0), -math.pi / 2)
            ..translate(0.0, 0.0, -width / 2)),
    Face(
          height,
          depth,
          vector.Matrix4.identity()
            ..rotate(vector.Vector3(1, 0, 0), math.pi / 2)
            ..translate(0.0, 0.0, -width / 2)),
      Face(
          depth,
          width,
          vector.Matrix4.identity()
            ..rotate(vector.Vector3(0, 1, 0), -math.pi / 2)
            ..translate(0.0, 0.0, -height / 2)),
      Face(
          depth,
          width,
          vector.Matrix4.identity()
            ..rotate(vector.Vector3(0, 1, 0), math.pi / 2)
            ..translate(0.0, 0.0, -height / 2)),

      // Face(
      //     height / 2,
      //     width / 2,
      //     vector.Matrix4.identity()
      //       ..rotate(vector.Vector3(0, 1, 0), math.pi)
      //       ..translate(0.0, 0.0, -depth / 2)),
    ];

    final cameraMatrix = vector.Matrix4.identity()
      ..translate(size.width / 2, size.height / 2,depth )
      ..multiply(vector.Matrix4.identity()
        ..setEntry(3, 2, 0.0001)
        ..rotateX(angleY)
        ..rotateY(angleX)
        ..translate(0.0,0.0,-depth/2 )//-(d/2) *16 TODO: Touch here for depth correction.
        );
    // cameraMatrix.transform3(vector.Vector3.zero());

    List<int> sortedKeys = createZOrder(cameraMatrix,);
    for (int i in sortedKeys) {
      final finalMatrix = cameraMatrix.multiplied(_positions[i].matrix4);
      canvas.save();

      final normalVector = normalVector3(
        finalMatrix.transformed3(v1),
        finalMatrix.transformed3(v2),
        finalMatrix.transformed3(v3),
      ).normalized();

      canvas.transform(Float64List.fromList(finalMatrix.storage));

      final directionBrightness = normalVector.dot(light).clamp(0.0, 1.0);

      const textStyle = TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold);
      final textSpan = TextSpan(
        text: '${index + 1}',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      // var rectsize = _positions[i].rect.size;
      final xCenter = (-textPainter.width) / 2;
      final yCenter = (-textPainter.height) / 2;
      final offset = Offset(xCenter, yCenter);

      if (image != null) {
        canvas.drawImageNine(
            image!,
            Rect.fromCenter(
                center: offset,
                width: _positions[i].rect.width ,//image!.width * 1.0,
                height: _positions[i].rect.height,// image!.height * 1.0
                ),
            _positions[i].rect,
            Paint()
              ..colorFilter = ui.ColorFilter.mode(
                  Colors.black
                      .withOpacity((0.7 - (directionBrightness * 0.7)) + 0.1),
                  ui.BlendMode.darken));
      } else {
        canvas.drawRect(
            _positions[i].rect,

            /// Side
            Paint()
              ..color =
                  colors[i].withBrightness(directionBrightness * 0.6 + 0.4));
      }

      // textPainter.paint(canvas, offset);
      canvas.restore();
    }
  }

  List<int> createZOrder(vector.Matrix4 matrix,) {
    final renderOrder = <int, double>{};
    final pos = vector.Vector3.zero();
    for (int i = 0; i < _positions.length; i++) {
      var tmp = matrix.multiplied(_positions[i].matrix4);
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

  @override
  bool shouldRepaint(CubePainter oldDelegate) => true;
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

// vector.Vector3 reflect(vector.Vector3 d, vector.Vector3 n) {
//   return d - n * 2 * d.dot(n);
// }

// vector.Vector3? intersectLineWithPlane(
//   vector.Vector3 vectorPoint,
//   vector.Vector3 vectorDirection,
//   vector.Vector3 planePoint,
//   vector.Vector3 planeNormal,
// ) {
//   final vn = vectorDirection.dot(planeNormal);
//   if (vn.abs() < 0.00000000000001) {
//     return null;
//   }
//   final d = (planePoint - vectorPoint).dot(planeNormal) / vn;
//   return vectorPoint + vectorDirection * d;
// }

extension ColorUtil on Color {
  Color withBrightness(double value) {
    return Color.fromARGB(
      alpha,
      (red * value).toInt(),
      (green * value).toInt(),
      (blue * value).toInt(),
    );
  }
}

class Face {
  final double width;
  final double height;
  final vector.Matrix4 matrix4;

  Rect get rect =>
      Rect.fromLTRB(-width / 2, -height / 2, width / 2, height / 2);
  Face(
    this.width,
    this.height,
    this.matrix4,
  );
}
