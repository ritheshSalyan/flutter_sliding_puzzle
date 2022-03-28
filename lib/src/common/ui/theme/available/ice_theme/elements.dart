import 'dart:math';

import 'package:sliding_puzzle/gen/assets.gen.dart';

class IceLandElements {
  static final List<String> _elements = [
    Assets.models.ice.iceLandIgloo,
    Assets.models.ice.iceLandTreeV1,
    Assets.models.ice.iceTree1,
    Assets.models.ice.iceTree2,
    Assets.models.ice.iceTree3,
    Assets.models.ice.iceTree4,
    Assets.models.ice.iceLandPolarBear,
    Assets.models.ice.iceLandPenguin
    // Assets.models.ice.iceLandPolarBearPenguin,
  ];

  static List<String> get elements => [..._elements];
  static String get tree {
    return _elements[Random().nextInt(_elements.length)];
  }
}
