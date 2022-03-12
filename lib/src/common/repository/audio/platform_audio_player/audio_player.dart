// import 'package:mojibooks_core/mojibooks_core.dart';

import 'audio_player_others.dart';
import 'audio_player_web.dart';
import 'audio_player_windows.dart';
import 'package:universal_platform/universal_platform.dart';

abstract class PlatformAudioPlayer {

  // final MojiLogger logger = MojiLogger("PlatformAudioPlayer");
  factory PlatformAudioPlayer() => UniversalPlatform.isWindows
      ? PlatformAudioPlayerWindows()
      : UniversalPlatform.isWeb
          ? PlatformAudioPlayerWeb()
          : PlatformAudioPlayerOther();
  Future<Duration> setUrl(String url,{Duration initialPosition});
  Future<bool> setFilePath(String filePath,{Duration initialPosition});
  Future<Duration> setAssetPath(String assetPath,{Duration initialPosition});
  Future<void> play();
  Future<void> pause();
  Future<void> mute();
  Future<void> unmute();
  void reset();
  Future<void> seekTo(Duration duration);
  void dispose();
  // String url;

  Stream<Duration> get positionStream;
  // @override
  // String toString() ;
}
