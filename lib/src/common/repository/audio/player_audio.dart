import 'dart:math';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'platform_audio_player/audio_player.dart';

class AudioPlayer {
  late PlatformAudioPlayer audioPlayer;
  bool isPlaying = false;
  late int uid;
  final bool repeat;
  AudioPlayer({this.repeat = false}) {
    audioPlayer = PlatformAudioPlayer();
    uid = Random().nextInt(100);
  }

  Duration startTime = Duration.zero;
  Duration _endTime = Duration.zero;

  Duration get endTime => _endTime + endoffset;

  set endTime(Duration endTime) {
    _endTime = endTime;
  }

  Duration offset = Duration.zero;
  Duration endoffset = Duration.zero;

  String source = "";
  setStartTime(Duration start) {
    startTime = start;
  }

  setEndTime(Duration time) {
    endTime = time;
  }

  setOffset(Duration time) {
    offset = time;
  }

  setEndOffset(Duration time) {
    endoffset = time;
  }

  Future<void> loadAsset(String assetPath) async {
    _duration = await audioPlayer.setAssetPath(assetPath);

    audioPlayer.positionStream.listen((event) {
      if (event >= _duration) {
        if (repeat) {
          seekTo(Duration.zero);
        } else {
          pause();
        }
      }
    });
  }

  Future<void> load(String audioUrl) async {
    audioUrl = audioUrl;
    // audioPlayer = PlatformAudioPlayer();
    // DateTime start = DateTime.now();
    final cacheManager = DefaultCacheManager();

    if (cacheManager != null) {
      await _downloadAudio(cacheManager, audioUrl);
    } else {
      _duration = await audioPlayer.setUrl(audioUrl, initialPosition: offset);
    }

    // var end = DateTime.now();
  }

  Duration get duration => _duration;
  Duration _duration = Duration.zero;
  Stream<Duration> get positionStream => audioPlayer.positionStream;

  Future<void> play(int milliseconds) async {
    if (isPlaying) return;

    await audioPlayer.play();
    await seekTo(
        Duration(milliseconds: milliseconds - startTime.inMilliseconds));
    isPlaying = true;
  }

  int retry = 4;
  Future<void> _downloadAudio(BaseCacheManager cacheManager, audioUrl) async {
    if (audioUrl == null) return;
    try {
      if (retry < 0) {
        _duration = await audioPlayer.setUrl(audioUrl);
        return;
      }
      retry--;
      _duration = await audioPlayer.setUrl(audioUrl);
    } on FormatException catch (_) {
      if (retry < 0) throw "Failed to download Audio file";

      await cacheManager.removeFile(audioUrl);
      await cacheManager.getSingleFile(audioUrl);
      await _downloadAudio(cacheManager, audioUrl);
    } catch (e) {
      if (retry < 0) rethrow;
      try {
        await cacheManager.removeFile(audioUrl);
      } catch (e) {}
      await cacheManager.getSingleFile(audioUrl);
      await _downloadAudio(cacheManager, audioUrl);
    }
  }

  Future<void> pause() async {
    if (!isPlaying) return;
    await audioPlayer.pause();
    isPlaying = false;
  }

  Future<void> reset() async {
    await audioPlayer.seekTo((offset));
  }

  Future<void> seekTo(Duration duration) async {
    await audioPlayer.seekTo(duration + (offset));
  }

  Future<void> mute() async {
    audioPlayer.mute();
  }

  Future<void> unmute() async {
    audioPlayer.unmute();
  }

  void dispose() {
    audioPlayer.dispose();
  }

  @override
  String toString() {
    // return "$uid";
    return '''
|------------------------------------------------------------
|audio track start at: $offset  
|Started at: $startTime  
|AUDIO PLAYER : $audioPlayer
|----------------------------------------------------------''';

// |End at: ${endTime ?? Duration.zero}
  }
}
