import 'dart:developer';

import 'package:just_audio/just_audio.dart';

import 'audio_player.dart';

class PlatformAudioPlayerWeb implements PlatformAudioPlayer {
  String? path;
  bool? isLocal;
  PlatformAudioPlayerWeb() {
    audioPlayer = AudioPlayer();
  }
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
  }

  @override
  Future<bool> setFilePath(String filePath, {Duration? initialPosition}) async {
    // await audioPlayer.setUrl(filePath, isLocal: true);
    isLocal = true;
    path = filePath;

    await audioPlayer.setFilePath(filePath);
    if (initialPosition != null) await seekTo(initialPosition);
    return true;
  }

  @override
  Future<Duration> setAssetPath(String assetPath, {Duration? initialPosition}) async {
   final duration= await  audioPlayer.setAsset(assetPath);
   return duration!;
  }
  @override
  Future<Duration> setUrl(String url, {Duration? initialPosition}) async {
    // MojiCacheManager.getInstance().
    try {
      await audioPlayer.setUrl(url);
      if (initialPosition != null) await seekTo(initialPosition);
      isLocal = false;
      path = url;
      // var fileInfo = await MojiCacheManager.getInstance().downloadFile(url);

      // await setFilePath(fileInfo.file.path);
      // isLocal = true;
      // path = fileInfo.file.path;

      // await audioPlayer.setFilePath(fileInfo.file.path);
    } catch (e) {
      try {
        await audioPlayer.setUrl(url);
        if (initialPosition != null) await seekTo(initialPosition);
        isLocal = false;
        path = url;
        // var fileInfo =
        //     await MojiCacheManager.getInstance().getFileFromMemory(url);
        // if (fileInfo == null) throw "No Cahced File for $url";
        // // await audioPlayer.setUrl(fileInfo.file.path, isLocal: true);
        // await setFilePath(fileInfo.file.path);

        // // await audioPlayer.setFilePath(fileInfo?.file?.path);
        // isLocal = true;
        // path = fileInfo.file.path;
      } catch (e) {
        log("ERROR While loading for web", error: e, name: "ERROR");
        await audioPlayer.setUrl(url);
        if (initialPosition != null) await seekTo(initialPosition);
        isLocal = false;
        path = url;
      }
    }
    return audioPlayer.duration ?? Duration.zero;
  }

  @override
  Future<void> pause() async {
    audioPlayer.pause();
  }

  @override
  Future<void> play() async {
    audioPlayer.play();
  }

  @override
  void reset() {
    audioPlayer.seek((Duration.zero));
  }

  @override
  String toString() {
    return "${audioPlayer.currentIndex}";
  }

  @override
  Future<void> seekTo(Duration duration) async {
    audioPlayer.seek(duration);
  }


  @override
  Stream<Duration> get positionStream => audioPlayer.positionStream;

  @override
  Future<void> mute() async {
    audioPlayer.setVolume(0);
  }

  @override
  Future<void> unmute() async {
    audioPlayer.setVolume(1);
  }

}
