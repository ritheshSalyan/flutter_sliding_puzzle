import 'package:flutter/cupertino.dart';

import 'state.dart';

mixin KeyboardController {
  final FocusNode keyboardFocusNode = FocusNode();

  ///
  /// Define all the shortcuts over here. It will auto mapped.
  ///
  List<KeyBoardShortcut> get _shortcuts => [
        KeyWShotcut(
          moveUp,
        ),
        KeySShotcut(
          moveDown,
        ),
        KeyAShotcut(
          moveLeft,
        ),
        KeyDShotcut(
          moveRight,
        ),
        KeyLeftShotcut(
          moveLeft,
        ),
        KeyUpShotcut(
          moveUp,
        ),
        KeyDownShotcut(
          moveDown,
        ),
        KeyRightShotcut(
          moveRight,
        ),
      ];

  ///
  /// [shortcuts] is Option for [FocusableActionDetector] Widget
  ///
  Map<ShortcutActivator, Intent> get shortcuts {
    final map = <ShortcutActivator, Intent>{};
    for (var item in _shortcuts) {
      map[item.keyset] = item;
    }
    return map;
  }

  ///
  /// [actions] is Option for [FocusableActionDetector] Widget
  ///
  Map<Type, Action<Intent>> get actions {
    final map = <Type, Action<Intent>>{};
    for (var item in _shortcuts) {
      map[item.runtimeType] = CallbackAction(onInvoke: (intent) {
        return item.perform();
      });
    }
    return map;
  }

  void moveUp();

  void moveDown();

  void moveLeft();

  void moveRight();
}
