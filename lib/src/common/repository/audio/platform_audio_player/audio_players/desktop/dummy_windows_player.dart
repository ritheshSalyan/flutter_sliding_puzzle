import '../../audio_player_windows.dart';

class DartVlcDesktopPlayer implements PlatformAudioPlayerWindows {
  @override
  void dispose() {
  }

  @override
  Future<void> pause() {
    throw UnimplementedError();
  }

  @override
  Future<void> play() {
    throw UnimplementedError();
  }

  @override
  Stream<Duration> get positionStream => throw UnimplementedError();

  @override
  void reset() {
  }

  @override
  Future<void> seekTo(Duration duration, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setFilePath(String filePath, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<Duration> setUrl(String url, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<void> mute() {
    throw UnimplementedError();
  }

  @override
  Future<void> unmute() {
    throw UnimplementedError();
  }

  @override
  Future<Duration> setAssetPath(String assetPath, {Duration? initialPosition}) {
    throw UnimplementedError();
  }
}

class LibWinMediaPlayer implements PlatformAudioPlayerWindows {
  @override
  void dispose() {
  }

  @override
  Future<void> mute() {
    throw UnimplementedError();
  }

  @override
  Future<void> pause() {
    throw UnimplementedError();
  }

  @override
  Future<void> play() {
    throw UnimplementedError();
  }

  @override
  Stream<Duration> get positionStream => throw UnimplementedError();

  @override
  void reset() {
  }

  @override
  Future<void> seekTo(Duration duration) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setFilePath(String filePath, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<Duration> setUrl(String url, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<void> unmute() {
    throw UnimplementedError();
  }

  @override
  Future<Duration> setAssetPath(String assetPath, {Duration? initialPosition}) {
    throw UnimplementedError();
  }
}

class JustAudioPlatformPlayer implements PlatformAudioPlayerWindows {
  @override
  void dispose() {
  }

  @override
  Future<void> pause() {
    throw UnimplementedError();
  }

  @override
  Future<void> play() {
    throw UnimplementedError();
  }

  @override
  Stream<Duration> get positionStream => throw UnimplementedError();

  @override
  void reset() {
  }

  @override
  Future<void> seekTo(Duration duration, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setFilePath(String filePath, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<Duration> setUrl(String url, {Duration? initialPosition}) {
    throw UnimplementedError();
  }

  @override
  Future<void> mute() {
    throw UnimplementedError();
  }

  @override
  Future<void> unmute() {
    throw UnimplementedError();
  }

  @override
  Future<Duration> setAssetPath(String assetPath, {Duration? initialPosition}) {
    throw UnimplementedError();
  }
}
