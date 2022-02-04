
import 'dart:math';

import 'package:flutter/material.dart';
num map(num value, [num iStart = 0, num iEnd = pi * 2, num oStart = 0, num oEnd = 1.0]) =>
  ((oEnd - oStart) / (iEnd - iStart)) * (value - iStart) + oStart;
class Cube extends StatelessWidget{
  const Cube({Key? key, required this.x, required this.y, required this.color, required this.size,}) : super(key: key);

  static const double _shadow = 0.2, _halfPi = pi / 2, _oneHalfPi = pi + pi / 2;

  final double x, y, size;
  final Color color;

  double get _sum => (y + (x > pi ? pi : 0.0)).abs() % (pi * 2);

  @override
  Widget build(BuildContext context){
    final bool _topBottom = x < _halfPi || x > _oneHalfPi;
    final bool _northSouth = _sum < _halfPi || _sum > _oneHalfPi;
    final bool _eastWest = _sum < pi;

    return Stack(children: <Widget>[
      _side(zRot: y, xRot: -x, shadow: _getShadow(x), moveZ: _topBottom),
      _side(yRot: y, xRot: _halfPi - x, shadow: _getShadow(_sum), moveZ: _northSouth),
      _side(yRot: -_halfPi + y, xRot: _halfPi - x, shadow: _shadow - _getShadow(_sum), moveZ: _eastWest)
    ]);
  }

  double _getShadow(double r){
    if(r < _halfPi){
      return map(r, 0, _halfPi, 0, _shadow) *1.0;
    }else if(r > _oneHalfPi){
      return _shadow - map(r, _oneHalfPi, pi * 2, 0, _shadow);
    }else if(r < pi){
      return _shadow - map(r, _halfPi, pi, 0, _shadow);
    }

    return map(r, pi, _oneHalfPi, 0, _shadow)*1.0;
  }

  Widget _side({bool moveZ = true, double xRot = 0.0, double yRot = 0.0, double zRot = 0.0, double shadow = 0.0}){
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateX(xRot)..rotateY(yRot)..rotateZ(zRot)
        ..translate(0.0, 0.0, moveZ ? -size / 2 : size / 2),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          constraints: BoxConstraints.expand(width: size, height: size),
          color: color,
          foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(shadow.clamp(0.01,1.0)
),
          border: Border.all(width: 0.8, color:  Colors.black26))
        )
      )
    );
  }
}