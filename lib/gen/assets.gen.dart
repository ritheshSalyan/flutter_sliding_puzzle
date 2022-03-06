/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get lava => const AssetGenImage('assets/images/lava.jpg');
  AssetGenImage get lavaA => const AssetGenImage('assets/images/lava_a.jpg');
  AssetGenImage get rock => const AssetGenImage('assets/images/rock.jpg');
  AssetGenImage get wave => const AssetGenImage('assets/images/wave.png');
  AssetGenImage get wave1 => const AssetGenImage('assets/images/wave_1.png');
}

class $AssetsMarkerGen {
  const $AssetsMarkerGen();

  String get puzzlehackLogo => 'assets/marker/puzzlehack_logo.mind';
  String get target3 => 'assets/marker/target_3.mind';
  String get targets => 'assets/marker/targets.mind';
}

class $AssetsModelsGen {
  const $AssetsModelsGen();

  String get castle => 'assets/models/castle.vox';
  String get deer => 'assets/models/deer.vox';
  $AssetsModelsIceGen get ice => const $AssetsModelsIceGen();
  $AssetsModelsJungleGen get jungle => const $AssetsModelsJungleGen();
  String get monu2 => 'assets/models/monu2.vox';
  String get monu2Old => 'assets/models/monu2_old.vox';
  String get tRex => 'assets/models/t_rex.vox';
  String get teapot => 'assets/models/teapot.vox';
  String get wall => 'assets/models/wall.vox';
}

class $AssetsModelsIceGen {
  const $AssetsModelsIceGen();

  String get rock1 => 'assets/models/ice/rock_1.vox';
  String get rock2 => 'assets/models/ice/rock_2.vox';
}

class $AssetsModelsJungleGen {
  const $AssetsModelsJungleGen();

  String get rock1 => 'assets/models/jungle/rock_1.vox';
  String get rock2 => 'assets/models/jungle/rock_2.vox';
  String get rock3 => 'assets/models/jungle/rock_3.vox';
  String get tree1 => 'assets/models/jungle/tree_1.vox';
  String get tree2 => 'assets/models/jungle/tree_2.vox';
  String get tree3 => 'assets/models/jungle/tree_3.vox';
  String get tree4 => 'assets/models/jungle/tree_4.vox';
  String get tree5 => 'assets/models/jungle/tree_5.vox';
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMarkerGen marker = $AssetsMarkerGen();
  static const $AssetsModelsGen models = $AssetsModelsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
