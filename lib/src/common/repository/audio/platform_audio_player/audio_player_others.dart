
import 'audio_player.dart';
import 'audio_players/just_audio_player.dart';

abstract class PlatformAudioPlayerOther implements PlatformAudioPlayer {
  factory PlatformAudioPlayerOther() => JustAudioPlatformPlayer(); 
//   String path;
//   bool isLocal;
//   static int counter = 0;
//   int index;
//   PlatformAudioPlayerOther() {
//    index =  counter++;
//     // audioPlayer = AudioPlayer();
//     playerModule.openAudioSession();
//   }
//   FlutterSoundPlayer playerModule = FlutterSoundPlayer();

//   // AudioPlayer audioPlayer = AudioPlayer();
//   @override
//   void dispose() {
//     // audioPlayer.stop();
//     // audioPlayer.dispose();
//     playerModule.closeAudioSession();
//   }

//   @override
//   Future<bool> setFilePath(String filePath) async {
//     // await audioPlayer.setUrl(filePath, isLocal: true);
//     isLocal = true;
//     path = filePath;

//     // await audioPlayer.setFilePath(filePath);
//     return true;
//   }

//   @override
//   Future<bool> setUrl(String url) async {
//     // MojiCacheManager.getInstance().
//     try {
//       var fileInfo = await MojiCacheManager.getInstance().downloadFile(url);

//       await setFilePath(fileInfo.file.path);
//       isLocal = true;
//       path = fileInfo.file.path;

//       // await audioPlayer.setFilePath(fileInfo.file.path);
//     } catch (e) {
//       try {
//         var fileInfo =
//             await MojiCacheManager.getInstance().getFileFromMemory(url);
//         if (fileInfo == null) throw "No Cahced File for $url";
//         // await audioPlayer.setUrl(fileInfo.file.path, isLocal: true);
//         await setFilePath(fileInfo.file.path);

//         // await audioPlayer.setFilePath(fileInfo?.file?.path);
//         isLocal = true;
//         path = fileInfo.file.path;
//       } catch (e) {
//         log("ERROR", error: e, name: "ERROR");
//         // await audioPlayer.setUrl(url);
//         isLocal = false;
//         path = url;
//       }
//     }
//     return true;
//   }

//   @override
//   Future<void> pause() async {
//     log("AUDIO PLAYER Pause $this ",name: "audio_player");
// try {    // audioPlayer.pause();
//     playerModule.pausePlayer();

//   }e

//   @override
//   Future<void> play() async {
//     log("AUDIO PLAYER PLAY $this ",name: "audio_player");
//    await audioPlayer.play();
//   }

//   @override
//   void reset() {
//     audioPlayer.seek((Duration.zero));
//   }

//   @override
//   String toString() {
//     return " $index";
//   }

//   @override
//   Future<void> seekTo(Duration duration) async {
//     log("AUDIO PLAYER Seek to  $this : $duration",name: "audio_player");
//    await audioPlayer.seek(duration);
//     log(" Seek complete  $this : $duration",name: "audio_player");
//   }

//   @override
//   String url;
}
