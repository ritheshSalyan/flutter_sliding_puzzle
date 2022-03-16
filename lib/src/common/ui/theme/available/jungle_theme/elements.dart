import 'dart:math';

import 'package:sliding_puzzle/gen/assets.gen.dart';

class JungleThemeElements {
  static final List<String> _trees = [
    // Assets.models.jungle.grassLand,
    // Assets.models.jungle.grassLandV,
    // Assets.models.jungle.grassLandV2,
    Assets.models.jungle.grassLandTreeV1,
    Assets.models.jungle.grassLandTreeV2,
    Assets.models.jungle.grassLandTreeV3,
    Assets.models.jungle.deer,
    Assets.models.jungle.grasslandTree1,
    Assets.models.jungle.grasslandTree2,
    Assets.models.jungle.grasslandTree3,
    Assets.models.jungle.grasslandTree4,
    // Assets.models.jungle.tree1,
    // Assets.models.jungle.tree2,
    // Assets.models.jungle.tree3,
    // Assets.models.jungle.tree4,
    // Assets.models.jungle.tree5,
  ];

  // static final List<String> _rock = [
  //   // Assets.models.jungle.grassLand,
  //   // Assets.models.jungle.rock1,
  //   // Assets.models.jungle.rock2,
  //   // Assets.models.jungle.rock3,
  // ];

  static List<String> get elements => [
        ..._trees,
      ];
  // static String get rock {
  //   return _rock[Random().nextInt(_rock.length)];
  // }

  static String get tree {
    return _trees[Random().nextInt(_trees.length)];
  }
}
