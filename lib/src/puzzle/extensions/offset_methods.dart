import 'package:flutter/material.dart';

extension OffsetExtension on Offset{
  bool isNear(Offset offset){
    return (offset.dx - dx).abs() <0.1 && (offset.dy - dy) < 0.1;
  }
}