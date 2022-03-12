import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/provider/voxel_mesh_provider.dart';
import 'package:sliding_puzzle/src/common/ui/theme/app_theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/ice_theme/theme.dart';
import 'package:sliding_puzzle/src/common/ui/theme/available/jungle_theme/jungle_theme.dart';

class ThemeNotifier extends StateNotifier<AppTheme> {
  static final provider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
    return ThemeNotifier(ref.read);
  });
  ThemeNotifier(this.reader) : super(jungleTheme) {
    _cacheMeshes();
  }
  final Reader reader;
  void changeTheme(BuildContext context, AppTheme appTheme) {
    state = appTheme;
  }

  void _cacheMeshes() {
    Future.delayed(const Duration(seconds: 1), () {
      for (var element in state.elements) {
        reader(MeshProvider.provider(element));
      }
    });
  }

  List<AppTheme> availableThemes = [
    jungleTheme,
    iceTheme,
  ];
}
