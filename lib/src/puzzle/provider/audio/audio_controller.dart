import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_puzzle/src/common/repository/audio/player_audio.dart';
import 'package:sliding_puzzle/src/common/ui/theme/audio_theme.dart';
import 'package:sliding_puzzle/src/common/ui/ui.dart';

class AudioController extends ChangeNotifier {
  static final provider = ChangeNotifierProvider<AudioController>((ref) {
    return AudioController(ref.watch(ThemeNotifier.provider).audios);
  });

  final AudioThemes audioThemes;

  AudioController(this.audioThemes) {
    _init();
  }
  _init() async {
    await movePlayer.loadAsset(audioThemes.tileMove);
    await correctPlayer.loadAsset(audioThemes.correctPos);
    await backgroundPlayer.loadAsset(audioThemes.background);
    backgroundMusic();
    await completionPlayer.loadAsset(audioThemes.completion);
  }

  final AudioPlayer movePlayer = AudioPlayer();
  final AudioPlayer correctPlayer = AudioPlayer();
  final AudioPlayer backgroundPlayer = AudioPlayer(repeat: true);
  final AudioPlayer completionPlayer = AudioPlayer();
  void moveSound() {
    movePlayer.play(0);
  }

  void correctSound() {
    correctPlayer.play(0);
  }

  void backgroundMusic() {
    backgroundPlayer.play(0);
  }

  void completionSound() {
    completionPlayer.play(0);
  }

  @override
  void dispose() {
    movePlayer.pause();
    movePlayer.dispose();
    correctPlayer.pause();
    correctPlayer.dispose();
    backgroundPlayer.pause();
    backgroundPlayer.dispose();
    completionPlayer.pause();
    completionPlayer.dispose();
    super.dispose();
  }
}
