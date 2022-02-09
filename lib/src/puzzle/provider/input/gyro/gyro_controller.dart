import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:universal_platform/universal_platform.dart';

mixin GyroController {
  StreamSubscription<GyroscopeEvent>? _subscription;

  Offset _gyroEvents = Offset.zero;
  void initializeGyro() {
    double stepSize = 1;
    if (UniversalPlatform.isAndroid ||
        UniversalPlatform.isIOS ||
        UniversalPlatform.isWeb) {
      _subscription = gyroscopeEvents.listen((event) {
        _gyroEvents += Offset(event.y, event.x);
        if (_gyroEvents.dx.abs() > stepSize ||
            _gyroEvents.dy.abs() > stepSize) {
          // log("GyroController: $event ");
          onGyroChange(_gyroEvents);
          _gyroEvents = Offset.zero;
        }
      });
    }
  }

  void onGyroChange(Offset offset);

  void cancelGyro() {
    _subscription?.cancel();
  }
}
