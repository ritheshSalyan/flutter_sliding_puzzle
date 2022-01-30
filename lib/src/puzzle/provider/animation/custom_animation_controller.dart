import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class AnimationControllers {
  final TileAnimationController idelTilesController;
  final TileAnimationController movementTileController;

  AnimationControllers({
    required this.idelTilesController,
    required this.movementTileController,
  });

  factory AnimationControllers.create(TickerProvider vsync) {
    return AnimationControllers(
        idelTilesController: TileAnimationController.create(vsync),
        movementTileController: TileAnimationController.create(vsync));
  }
}

class TileAnimationController {
  final AnimationController animationController;
  TileAnimationController({
    required this.animationController,
  }) {
    animationController.repeat(
        min: 0, max: 1, reverse: true, period: const Duration(seconds: 1));
  }

  factory TileAnimationController.create(
    TickerProvider vsync,
  ) {
    return TileAnimationController(
      animationController: AnimationController(vsync: vsync),
    );
  }
}
