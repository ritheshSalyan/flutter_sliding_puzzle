/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  $AssetsAudioIceGen get ice => const $AssetsAudioIceGen();
  $AssetsAudioNatureGen get nature => const $AssetsAudioNatureGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/lava.jpg
  AssetGenImage get lava => const AssetGenImage('assets/images/lava.jpg');

  /// File path: assets/images/lava_a.jpg
  AssetGenImage get lavaA => const AssetGenImage('assets/images/lava_a.jpg');

  /// File path: assets/images/rock.jpg
  AssetGenImage get rock => const AssetGenImage('assets/images/rock.jpg');

  /// File path: assets/images/wave.png
  AssetGenImage get wave => const AssetGenImage('assets/images/wave.png');

  /// File path: assets/images/wave_1.png
  AssetGenImage get wave1 => const AssetGenImage('assets/images/wave_1.png');
}

class $AssetsMarkerGen {
  const $AssetsMarkerGen();

  /// File path: assets/marker/puzzlehack_logo.mind
  String get puzzlehackLogo => 'assets/marker/puzzlehack_logo.mind';

  /// File path: assets/marker/target_3.mind
  String get target3 => 'assets/marker/target_3.mind';

  /// File path: assets/marker/targets.mind
  String get targets => 'assets/marker/targets.mind';
}

class $AssetsModelsGen {
  const $AssetsModelsGen();

  /// File path: assets/models/castle.vox
  String get castle => 'assets/models/castle.vox';

  /// File path: assets/models/deer.vox
  String get deer => 'assets/models/deer.vox';

  $AssetsModelsIceGen get ice => const $AssetsModelsIceGen();
  $AssetsModelsJungleGen get jungle => const $AssetsModelsJungleGen();

  /// File path: assets/models/monu2.vox
  String get monu2 => 'assets/models/monu2.vox';

  /// File path: assets/models/monu2_old.vox
  String get monu2Old => 'assets/models/monu2_old.vox';

  /// File path: assets/models/t_rex.vox
  String get tRex => 'assets/models/t_rex.vox';

  /// File path: assets/models/teapot.vox
  String get teapot => 'assets/models/teapot.vox';

  /// File path: assets/models/wall.vox
  String get wall => 'assets/models/wall.vox';
}

class $AssetsAudioIceGen {
  const $AssetsAudioIceGen();

  /// File path: assets/audio/ice/background.wav
  String get background => 'assets/audio/ice/background.wav';

  /// File path: assets/audio/ice/completion.wav
  String get completion => 'assets/audio/ice/completion.wav';

  /// File path: assets/audio/ice/correct_pos.wav
  String get correctPos => 'assets/audio/ice/correct_pos.wav';

  /// File path: assets/audio/ice/tile_move.wav
  String get tileMove => 'assets/audio/ice/tile_move.wav';
}

class $AssetsAudioNatureGen {
  const $AssetsAudioNatureGen();

  /// File path: assets/audio/nature/background.wav
  String get background => 'assets/audio/nature/background.wav';

  /// File path: assets/audio/nature/completion.wav
  String get completion => 'assets/audio/nature/completion.wav';

  /// File path: assets/audio/nature/correct_pos.wav
  String get correctPos => 'assets/audio/nature/correct_pos.wav';

  /// File path: assets/audio/nature/tile_move.wav
  String get tileMove => 'assets/audio/nature/tile_move.wav';
}

class $AssetsModelsIceGen {
  const $AssetsModelsIceGen();

  /// File path: assets/models/ice/rock_1.vox
  String get rock1 => 'assets/models/ice/rock_1.vox';

  /// File path: assets/models/ice/rock_2.vox
  String get rock2 => 'assets/models/ice/rock_2.vox';
}

class $AssetsModelsJungleGen {
  const $AssetsModelsJungleGen();

  /// File path: assets/models/jungle/rock_1.vox
  String get rock1 => 'assets/models/jungle/rock_1.vox';

  /// File path: assets/models/jungle/rock_2.vox
  String get rock2 => 'assets/models/jungle/rock_2.vox';

  /// File path: assets/models/jungle/rock_3.vox
  String get rock3 => 'assets/models/jungle/rock_3.vox';

  /// File path: assets/models/jungle/tree_1.vox
  String get tree1 => 'assets/models/jungle/tree_1.vox';

  /// File path: assets/models/jungle/tree_2.vox
  String get tree2 => 'assets/models/jungle/tree_2.vox';

  /// File path: assets/models/jungle/tree_3.vox
  String get tree3 => 'assets/models/jungle/tree_3.vox';

  /// File path: assets/models/jungle/tree_4.vox
  String get tree4 => 'assets/models/jungle/tree_4.vox';

  /// File path: assets/models/jungle/tree_5.vox
  String get tree5 => 'assets/models/jungle/tree_5.vox';
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
