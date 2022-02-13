
import 'package:flutter/material.dart';

extension OffsetExtension on Offset {
  Offset clamp(Offset min, Offset max) {
    return Offset(dx.clamp(min.dx, max.dx), dy.clamp(min.dy, max.dy));
  }
}
