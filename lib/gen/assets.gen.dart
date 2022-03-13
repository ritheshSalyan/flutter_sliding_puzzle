/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  $AssetsAudioIceGen get ice => const $AssetsAudioIceGen();
  $AssetsAudioNatureGen get nature => const $AssetsAudioNatureGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app_icon.png');
  AssetGenImage get wave => const AssetGenImage('assets/images/wave.png');
}

class $AssetsMarkerGen {
  const $AssetsMarkerGen();

  String get logo => 'assets/marker/logo.mind';
  String get puzzlehackLogo => 'assets/marker/puzzlehack_logo.mind';
  String get target3 => 'assets/marker/target_3.mind';
  String get targets => 'assets/marker/targets.mind';
}

class $AssetsModelsGen {
  const $AssetsModelsGen();

  $AssetsModelsIceGen get ice => const $AssetsModelsIceGen();
  $AssetsModelsJungleGen get jungle => const $AssetsModelsJungleGen();
}

class $AssetsAudioIceGen {
  const $AssetsAudioIceGen();

  String get background => 'assets/audio/ice/background.wav';
  String get completion => 'assets/audio/ice/completion.wav';
  String get correctPos => 'assets/audio/ice/correct_pos.wav';
  String get tileMove => 'assets/audio/ice/tile_move.wav';
}

class $AssetsAudioNatureGen {
  const $AssetsAudioNatureGen();

  String get background => 'assets/audio/nature/background.wav';
  String get completion => 'assets/audio/nature/completion.wav';
  String get correctPos => 'assets/audio/nature/correct_pos.wav';
  String get tileMove => 'assets/audio/nature/tile_move.wav';
}

class $AssetsModelsIceGen {
  const $AssetsModelsIceGen();

  String get iceTree1 => 'assets/models/ice/Ice_tree_1.vox';
  String get iceLandIgloo => 'assets/models/ice/ice_land_igloo.vox';
  String get iceLandTreeV1 => 'assets/models/ice/ice_land_tree_v1.vox';
  String get iceTree2 => 'assets/models/ice/ice_tree_2.vox';
  String get iceTree3 => 'assets/models/ice/ice_tree_3.vox';
  String get iceTree4 => 'assets/models/ice/ice_tree_4.vox';
}

class $AssetsModelsJungleGen {
  const $AssetsModelsJungleGen();

  String get grassLandTreeV1 => 'assets/models/jungle/grass_land_tree_v1.vox';
  String get grassLandTreeV2 => 'assets/models/jungle/grass_land_tree_v2.vox';
  String get grassLandTreeV3 => 'assets/models/jungle/grass_land_tree_v3.vox';
  String get grasslandTree1 => 'assets/models/jungle/grassland_tree_1.vox';
  String get grasslandTree2 => 'assets/models/jungle/grassland_tree_2.vox';
  String get grasslandTree3 => 'assets/models/jungle/grassland_tree_3.vox';
  String get grasslandTree4 => 'assets/models/jungle/grassland_tree_4.vox';
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
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
