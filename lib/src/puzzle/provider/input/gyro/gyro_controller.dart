import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:universal_platform/universal_platform.dart';

mixin GyroController {
  StreamSubscription<GyroscopeEvent>? _subscription;
  void initializeGyro() {
    if (UniversalPlatform.isAndroid ||
        UniversalPlatform.isIOS ||
        UniversalPlatform.isWeb) {
      _subscription = gyroscopeEvents.listen((event) {
        if (event.x.abs() > 0.002 && event.y.abs() > 0.002) {
          // log("GyroController: $event ");
          onGyroChange(Offset(event.y, event.x));
        }
      });
    }
  }

  void onGyroChange(Offset offset);

  void cancelGyro() {
    _subscription?.cancel();
  }
}
