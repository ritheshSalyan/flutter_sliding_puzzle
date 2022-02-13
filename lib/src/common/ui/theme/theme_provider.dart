import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';

import 'available/jungle_theme/jungle_theme.dart';

class ThemeNotifier extends StateNotifier<AppTheme> {
  static final provider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
    return ThemeNotifier();
  });
  ThemeNotifier() : super(jungleTheme);
}