import 'package:hooks_riverpod/hooks_riverpod.dart';

enum DifficulyLevel {
  easy,
  medium,
  hard,
}

class DifficultyNotifier extends StateNotifier<DifficulyLevel> {
  DifficultyNotifier() : super(DifficulyLevel.medium);

  static final provider =
      StateNotifierProvider<DifficultyNotifier, DifficulyLevel>((ref) {
    return DifficultyNotifier();
  });

  void changeDifficulty(DifficulyLevel level) {
    state = level;
  }
}
