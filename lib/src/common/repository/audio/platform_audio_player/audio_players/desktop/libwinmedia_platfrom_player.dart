// import 'dart:async';
// import 'dart:developer' as dev;
// import 'dart:io';
// import 'dart:math' as math;

// import 'package:libwinmedia/libwinmedia.dart';

// import '../../audio_player_windows.dart';
// import '../file_handling/file_downloader.dart';
// import '../file_handling/file_provider.dart';
// // import 'file_handling/file_downloader.dart';
// // import 'file_handling/file_provider.dart';

// class LibWinMediaPlayer implements PlatformAudioPlayerWindows {
//   // static AudioPlayer playing;
//   static int count = 0;
//   LibWinMediaPlayer() {
//     // audioPlayer = Player(id: count++);
//   }
//   Completer loadingFuture = Completer();
//   void log(String message, {String? name}) {
//     dev.log(message, name: name ?? "");
//     // logger.logEventmedium(message);
//   }

//   _FileWithMedia? source;
// //  Player audioPlayer;
//   Player? audioPlayer;
//   @override
//   void dispose() {
//     pause();
//     try {
//       audioPlayer?.pause();
//       // audioPlayer.stop();
//       audioPlayer?.dispose();
//       source?.file.delete();
//     } catch (e) {
//       // logger.logError(e.toString());
//     }
//   }

//   @override
//   Future<bool> setAssetPath(String assetPath, {Duration? initialPosition}) async {
//      audioPlayer = Player(id: count);
//     count++;
// audioPlayer!.add(Media(assetPath))
//    return duration!=null;
//   }
//   Duration? totalDuration;
//   @override
//   Future<bool> setFilePath(String filePath, {Duration? initialPosition}) async {
//     url = filePath;
//     audioPlayer = Player(id: count);
//     count++;
//     // log("SetFilePath Start $this: " + filePath);
//     //  audioPlayer.add( Media.file(File(filePath)));

//     // audioPlayer.currentStream.listen((event) {
//     // if (event.media != null) {
//     // if (!loadingFuture.isCompleted) {
//     //   // print("SET FILE PATH STREAM ${event.media}");
//     //   logger.logInfo("Update currentStream ${event.media}");

//     //   StreamSubscription<PositionState> initializeSubscription;
//     //   initializeSubscription = audioPlayer.positionStream.listen((event) {
//     //     if (event.duration > Duration.zero) {
//     //       audioPlayer.pause();
//     //       initializeSubscription.cancel();

//     //       totalDuration = event.duration;
//     //       logger.logInfo(
//     //           "Update Position ${event.duration} ${event.position}");
//     // if (!loadingFuture.isCompleted) {
//     // print("SET FILE PATH STREAM ${event.media}");
//     // loadingFuture.complete(true);
//     // }
//     // }
//     // });
//     // audioPlayer.play();
//     // }
//     // }
//     // });

//     source = await MediaCacheManager.getMedia(filePath);

//     var media = source?.getMedia();
//     if (media != null) {
//       audioPlayer?.open([media]);
//     }

//     // log("SetFilePath File Added " + filePath);

//     // await loadingFuture.future;
//     //     await play();
//     // await pause();
//     // logger.logInfo("SetFilePath Complete " + filePath);

//     return true;
//   }

//   String? url;

//   @override
//   Future<Duration> setUrl(String url, {Duration? initialPosition}) async {
//     // logger.logInfo(
//     //   "setUrl $url ",
//     // );

//     CacheFileManager manager = CacheFileManager();
//     final filePath = await manager.downloadFile(url);

//     // logger.logInfo(
//     //   "setUrl Download Complete $url ",
//     // );
//     await setFilePath(filePath, initialPosition: initialPosition);
//     return ( await audioPlayer?.streams.duration.last) ?? Duration.zero;
//   }

//   @override
//   Future<void> pause() async {
//     // logger.logInfo(
//     //   "AUDIO PLAYER PAUSE $this ",
//     // );
//     audioPlayer?.pause();
//     // playing = null;
//   }

//   @override
//   Future<void> play() async {
//     if (audioPlayer == null) return;
//     Completer completer = Completer();
//     // logger.logInfo(
//     //   "AUDIO PLAYER PLAY $this ",
//     // );
//     audioPlayer?.streams.position.listen((event) {
//       if (!completer.isCompleted) {
//         // logger.logInfo(
//         //   "AUDIO PLAYER PLAY $this Complete ",
//         // );

//         completer.complete(true);
//       }
//     });

//     ///
//     ///
//     ///
//     ///TODO: Remove This Delay This is for testing Purpose
//     // await Future.delayed(Duration(seconds: 5));
//     audioPlayer!.play();
//     await completer.future;
//     // audioPlayer.setRate(30);
//     // playing?.pause();
//     // var position = await audioPlayer.streams.position.last;
//     // var duration = await audioPlayer.streams.duration.last;
//     // logger.logInfo(
//     //   "AUDIO PLAYER PLAY $this position $position of $duration ",
//     // );
// //  playing = audioPlayer;
// //  log("result");
//   }

//   @override
//   void reset() {
//     // audioPlayer.seek(Duration.zero);
//     audioPlayer?.seek(Duration.zero);
//   }

//   @override
//   Future<void> seekTo(Duration duration) async {
//     // logger.logInfo(
//     //   "AUDIO PLAYER SEEK TO $this  : $duration",
//     // );
//     audioPlayer?.seek(duration);
//     // logger.logInfo(
//     //   "AUDIO PLAYER SEEK TO $this Complete  : $duration",
//     // );
//     // if (!loadingFuture.isCompleted) {
//     //   logger.logInfo("AUDIO PLAYER SEEK:  Audio Player Not Loaded.");
//     //   await loadingFuture.future;
//     // }
//     // audioPlayer.positionStream.listen((event) {
//     //   // log("AUDIO PLAYER SEEK STREAM $this position ${event.position} of ${event.duration} ");
//     // });

//     // logger.logInfo(
//     //   "AUDIO PLAYER SEEK TO $this  : $duration",
//     // );
//     // // await audioPlayer.seek(duration);
//     // // var totalDuration =   audioPlayer.duration;
//     // // log("AUDIO PLAYER SEEK TO $this totalDuration $totalDuration ",name: "audio_player_tag");
//     // var position = audioPlayer.position;
//     // var totalduration =
//     //     totalDuration ?? await audioPlayer.streams.duration.last;

//     // if (position == duration) {
//     //   logger.logInfo(
//     //     "AUDIO PLAYER SEEK TO $this Already In Position ",
//     //   );

//     //   return;
//     // }

//     // if (totalduration <= duration) {
//     //   logger.logInfo(
//     //     "AUDIO PLAYER SEEK TO $this position $position of $totalduration Cannot Seek ",
//     //   );
//     //   if (totalduration == Duration.zero) {
//     //     await Future.delayed(Duration(seconds: 1));
//     //     // await  seekTo(duration);
//     //   }
//     //   return;
//     // }

//     // Completer completer = Completer();
//     // logger.logInfo(
//     //   "seekTo $this ",
//     // );
//     // var onData = (event) {
//     //   logger.logInfo(
//     //     "AUDIO PLAYER SEEK TO $this Recieved Events $event  ",
//     //   );

//     //   if (!completer.isCompleted && event >= duration) {
//     //     completer.complete(true);
//     //   }
//     // };
//     // StreamSubscription<Duration> subsctiption =
//     //     audioPlayer.streams.position.listen(onData);

//     // logger.logInfo(
//     //   "AUDIO PLAYER SEEK TO $this Current position $position of Total: $totalduration ",
//     // );

//     // audioPlayer.seek(duration);
//     // completer.future.then((value) {
//     //   subsctiption.cancel();
//     //   Duration afterSeek = audioPlayer.position;
//     //   logger.logInfo(
//     //     "AUDIO PLAYER SEEK TO $this from $position to $afterSeek for Max $totalduration  requested Pos: $duration ",
//     //   ); // .then((value){
//     //   logger.logInfo(
//     //     "Seek Complete:  $this",
//     //   );
//     // });

//     // if (afterSeek != duration) {
//     //   // await seekTo(duration);
//     // }
//   }

//   @override
//   String toString() {
//     return "${audioPlayer?.id}";
//   }

//   @override
//   Stream<Duration> get positionStream =>
//       audioPlayer!.streams.position; //.map((event) => event.position);


//   @override
//   Future<void> mute() async {
//     audioPlayer?.volume = 0;
//   }

//   @override
//   Future<void> unmute() async {
//     audioPlayer?.volume = 1;
//   }
// }

// class MediaCacheManager {
//   static Map<String, _FileWithMedia> cacheMedia = {};
//   static final FileProvider _fileProvider = FileProvider();
//   static Future<_FileWithMedia> getMedia(String path) async {
//     // if (cacheMedia.containsKey(path)) {
//     // await File(path).copy(newPath);
//     var file = await getNewFile(path);
//     // var media = Media.file(file, parse: false);
//     _FileWithMedia fileWithMedia = _FileWithMedia(
//       file,
//     );
//     return fileWithMedia;
//     // }
//     // var file2 = File(path);
//     // Media media = Media.file(file2);
//     // final witmMedia = _FileWithMedia(file2, media);
//     // cacheMedia[path] = witmMedia;
//     // return witmMedia;
//   }

//   static Future<File> getNewFile(path) async {
//     String fileName = path.split("\\").last;

//     String newPath =
//         path.replaceFirst(fileName, "${math.Random().nextInt(1000)}_$fileName");
//     // log("Change " + path + " to " + newPath);
//     return _fileProvider.copyFile(path, newPath);
//     // await File(path).copy(newPath);

//     // return File(newPath);
//   }
// }

// class _FileWithMedia {
//   final File file;

//   // Media get media => Media.file(file,parse: true);

//   _FileWithMedia(this.file);
//   Media getMedia() {
//     return Media(uri: "file://${file.path}");
//   }
// }
