

import 'audio_player.dart';
import 
      'audio_players/desktop/libwinmedia_platfrom_player.dart'
      if(dart.library.html) 'audio_players/desktop/dummy_windows_player.dart'
      ;
// import 'audio_players/desktop/flutter_audio_desktop_player.dart';

abstract class PlatformAudioPlayerWindows implements PlatformAudioPlayer {
  // IsolateHandler isolateHandler;
  factory PlatformAudioPlayerWindows() =>
      LibWinMediaPlayer(); //  DartVlcDesktopPlayer();// KPlayerPlatfromAudioPlayer(); // //IsolatedWidnowsPlayer(); //DartVlcDesktopPlayer(); //FlutterAudioDesktopPlayer();

  // initialize() async {
  //   isolateHandler = IsolateHandler(IsolatePlayer(FlutterAudioDesktopPlayer()));
  //   await isolateHandler.initIsolate();
  //   // receivePort = ReceivePort();
  //   // isolate = await Isolate.spawn<IsolatePlayer>(
  //   //     manageIsolates, IsolatePlayer(DartVlcDesktopPlayer()));
  // }

  // @override
  // void dispose() {
  //   // receivePort.close();
  //   // isolate.kill();
  //   isolateHandler.dispose();
  // }

  // @override
  // String url;

  // @override
  // Future<void> pause() async {
  //  sendEvent(PlayerEvent("pause", ""));
  // }

  // @override
  // Future<void> play() async {
  //  sendEvent(PlayerEvent("play", ""));
  // }

  // @override
  // void reset() async {
  //   sendEvent(PlayerEvent("reset", ""));
  // }

  // @override
  // Future<void> seekTo(Duration duration) async {
  //   sendEvent(PlayerEvent("seekTo", duration));
  // }

  // @override
  // Future<bool> setFilePath(String filePath) async {
  //   try {
  //     await sendEvent(PlayerEvent("setFilePath", filePath));
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // @override
  // Future<bool> setUrl(String url) async {
  //   try {
  //     await sendEvent(PlayerEvent("setUrl", url));

  //     return true;
  //     // print(event);
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<dynamic> sendEvent(PlayerEvent event) async {
  //   try {
  //     return await isolateHandler.sentToIsolateAndWait(event);
  //   } catch (e) {
  //     log(e);
  //   }
  // }
}

// class IsolatePlayer extends IsolateReciever {
//   final PlatformAudioPlayer player;

//   IsolatePlayer(this.player);

//   play() {
//     player.play();
//     returnEvent(PlayerEvent("complete", ""));
//   }

//   pause() {
//     player.pause();
//     returnEvent(PlayerEvent("complete", ""));
//   }

//   reset() {
//     player.reset();
//     returnEvent(PlayerEvent("complete", ""));
//   }

//   seekTo(Duration duration) {
//     player.seekTo(duration);
//     returnEvent(PlayerEvent("complete", ""));
//   }

//   setFilePath(String filePath) async {
//     await player.setFilePath(filePath);
//     returnEvent(PlayerEvent("complete", ""));
//     // receivePort.sendPort.send(PlayerEvent("loaded", ""));
//   }

//   setUrl(String url) async {
//     await player.setUrl(url);
//     returnEvent(PlayerEvent("complete", ""));
//   }

//   @override
//   int get id => throw UnimplementedError();

//   @override
//   void listen(message) {
//     print("IsolatePlayer: " + message);
//     if (message is PlayerEvent) {
//       switch (message.event) {
//         case "play":
//           play();
//           break;
//         case "pause":
//           pause();
//           break;
//         case "reset":
//           reset();
//           break;
//         case "seekTo":
//           seekTo(message.data);
//           break;
//         case "setFilePath":
//           setFilePath(message.data);
//           break;
//         case "setUrl":
//           setUrl(message.data);
//           break;

//         default:
//       }
//     }
//   }
// }

// class PlayerEvent {
//   final String event;
//   final dynamic data;

//   PlayerEvent(this.event, this.data);
// }
