import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:just_audio/just_audio.dart';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayer/audioplayer.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';

import '../audio_player_others.dart';
import '../audio_player_windows.dart';
import 'file_handling/file_provider.dart';

class JustAudioPlatformPlayer
    implements PlatformAudioPlayerOther, PlatformAudioPlayerWindows {
  String? path;
  bool? isLocal;
  static int counter = 0;
  late int index;
  JustAudioPlatformPlayer() {
    index = counter++;
    audioPlayer = AudioPlayer();
    // playerModule.openAudioSession();
  }
  // FlutterSoundPlayer playerModule = FlutterSoundPlayer();

  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    try {
      if (path != null) File(path!).delete();
    } catch (e) {}
    start = null;
    // playerModule.closeAudioSession();
  }

  @override
  Future<bool> setFilePath(String filePath, {Duration? initialPosition}) async {
    // await audioPlayer.setUrl(filePath, isLocal: true);
    path = await MediaCacheManager.getMedia(filePath);
    audioPlayer = AudioPlayer();
    // await audioPlayer.setFilePath(path);
    var uri = AudioSource.uri(Uri.file(path!));

    Duration? duration =
        await audioPlayer.setAudioSource(uri, initialPosition: initialPosition);
    // print(logger.tag +
    //     "" +
    //     audioPlayer.toString() +
    //     audioPlayer.audioSource?.toString() +
    //     "$duration");
    isLocal = true;
    path = path;
    return true;
  }

  @override
  Future<Duration> setAssetPath(String assetPath, {Duration? initialPosition}) async {
   final duration= await  audioPlayer.setAsset(assetPath);
   return duration!;
  }
  DateTime? start;
  @override
  Future<Duration> setUrl(String url, {Duration? initialPosition}) async {
    // MojiCacheManager.getInstance().
    try {
      // if(start!=null) return true;
      // start = DateTime.now();

      // final names = await PlatformFileManager()
      //     .createFile(["audio${Random().nextInt(100)}.mp3"]);

      // start = DateTime.now();

      // log("Audio Download Start: $start");
      var fileInfo = await DefaultCacheManager().getSingleFile(url);
      // log("Download FileInfo: ${fileInfo.originalUrl} ${fileInfo.file.path}" );
      // File("audio.mp3");
      // Dio().downloadUri(Uri.parse(url), names.first,

      //     onReceiveProgress: (int current, int total) {
      //   final progress = (current / total) * 100;
      //   log("Audio Download Progress: ${"="*(progress~/10)}> ${progress.toStringAsFixed(0)}% ");
      //   if (progress == 100) {
      //     var end = DateTime.now();
      //     log("Audio Download Progress: ==> ${progress.toStringAsFixed(0)}% ${end.difference(start)}");

      //     log("Audio Download end: $end");
      //   }
      // });
      //     final downloaderUtils = DownloaderUtils(
      //       progressCallback: (current, total) {
      //         final progress = (current / total) * 100;
      //         if(progress%10==0) log("Audio Download progress: $progress");
      //         // print('Downloading: $progress');
      //       },
      //       progress: ProgressImplementation(),
      //       file: File(names.first),
      //       onDone: () {
      // var end = DateTime.now();
      // log("Audio Download total duration: ==> ${end.difference(start)}");
      // log("Audio Download end: $end");
      //       },
      //       deleteOnCancel: true,
      //     );

      //     final core = await Flowder.download(
      //         url, downloaderUtils);
      await setFilePath(fileInfo.path, initialPosition: initialPosition);
      // isLocal = true;
      // path = fileInfo.file.path;

      // await audioPlayer.setFilePath(path);
    } catch (e) {
      try {
        var fileInfo = await DefaultCacheManager().getFileFromMemory(url);
        if (fileInfo == null) throw "No Cahced File for $url";
        // await audioPlayer.setUrl(fileInfo.file.path, isLocal: true);
        await setFilePath(fileInfo.file.path, initialPosition: initialPosition);

        // await audioPlayer.setFilePath(fileInfo?.file?.path);
        isLocal = true;
        path = fileInfo.file.path;
      } catch (e) {
        log("ERROR", error: e, name: "ERROR");
        // await audioPlayer.setUrl(url);
        isLocal = false;
        path = url;
        rethrow;
      }
    }
    // positionStream.listen((event) {
    //   MojiLogger("JustAudioPlatformPlayer").logdetailed("Time: $event");
    // });
    return audioPlayer.duration ?? Duration.zero;
  }

  @override
  Future<void> pause() async {
    // log("AUDIO PLAYER Pause $this ", name: "audio_player");
    try {
      await audioPlayer.pause();
    } catch (e) {}
  }

  @override
  Future<void> play() async {
    log("AUDIO PLAYER PLAY Before $this ", name: "audio_player");
    try {
      Completer completer = Completer();

      // var onData = (bool state) {
      //   if (state) {
      //     if (!completer.isCompleted) completer.complete();
      //   }
      // };
      // audioPlayer.playingStream.listen(onData);
      final sub2 = audioPlayer.playbackEventStream.listen((event) {
        // logger.logDebug(
        //     "${DateTime.now().toIso8601String()} PlayTesting playbackEventStream $event");
      });
      final subscription = audioPlayer.playerStateStream.listen((event) {
        // logger.logDebug(
        //     "${DateTime.now().toIso8601String()} PlayTesting playerStateStream $event");
        if (event.playing && event.processingState == ProcessingState.ready) {
          if (!completer.isCompleted) {
            completer.complete();
          }
        }
      });
      audioPlayer.processingStateStream.listen((event) {
        // logger.logDebug(
        //     "${DateTime.now().toIso8601String()} PlayTesting processingStateStream $event");
        if (event == ProcessingState.completed) {
          if (!completer.isCompleted) completer.complete();
        }
      });

      audioPlayer.play();
      // audioPlayer.s(0.5);
      await completer.future;
      subscription.cancel();
      sub2.cancel();
    } catch (e) {
      log("AUDIO PLAYER Error $this $e ", name: "audio_player");
    }
    log("AUDIO PLAYER PLAY Started $this ", name: "audio_player");
  }

  @override
  void reset() {
    audioPlayer.seek((Duration.zero));
  }

  @override
  String toString() {
    return " $index";
  }

  @override
  Future<void> seekTo(Duration duration) async {
    // log("AUDIO PLAYER Seek to  $this : $duration", name: "audio_player");
    await audioPlayer.seek(duration);
    // log(" Seek complete  $this : $duration", name: "audio_player");
  }

  @override
  Stream<Duration> get positionStream => audioPlayer.positionStream;

  // @override
  // MojiLogger get logger => MojiLogger("JustAudioPlatformPlayer $this");
  @override
  Future<void> mute() async {
    audioPlayer.setVolume(0);
  }

  @override
  Future<void> unmute() async {
    audioPlayer.setVolume(1);
  }

}

class MediaCacheManager {
  static Map<String, String> cacheMedia = {};
  static final FileProvider _fileProvider = FileProvider();
  static Future<String> getMedia(String path) async {
    // if (cacheMedia.containsKey(path)) {
    // await File(path).copy(newPath);
    return await getNewFile(path);
    // }
    // final media = path;

    // cacheMedia[path] = media;
    // return media;
  }

  static Future<String> getNewFile(String path) async {
    final segments = path.split(".");
    final fileName =
        segments[segments.length - 2] + "-" + "${math.Random().nextInt(1000)}";
    // String newPath = fileName.replaceFirst(
    //     fileName, "${fileName}_${math.Random().nextInt(1000)}");
    segments[segments.length - 2] = fileName;
    var newPath = segments.join(".");
    log("Change " + path + " to " + newPath);
    return (await _fileProvider.copyFile(path, newPath)).path;
    // await File(path).copy(newPath);

    // return File(newPath);
  }
}
