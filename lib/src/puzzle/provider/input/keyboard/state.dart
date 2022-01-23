import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class KeyBoardShortcut extends Intent {
  final LogicalKeySet keyset;
  final VoidCallback _callback;
  const KeyBoardShortcut(this.keyset, this._callback);

  void perform() {
    _callback.call();
  }
}

class KeyAShotcut extends KeyBoardShortcut {
  KeyAShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.keyA), callback);
}
class KeyWShotcut extends KeyBoardShortcut {
  KeyWShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.keyW), callback);
}
class KeySShotcut extends KeyBoardShortcut {
  KeySShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.keyS), callback);
}
class KeyDShotcut extends KeyBoardShortcut {
  KeyDShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.keyD), callback);
}

class KeyLeftShotcut extends KeyBoardShortcut {
  KeyLeftShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.arrowLeft), callback);
}
class KeyUpShotcut extends KeyBoardShortcut {
  KeyUpShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.arrowUp), callback);
}
class KeyDownShotcut extends KeyBoardShortcut {
  KeyDownShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.arrowDown), callback);
}
class KeyRightShotcut extends KeyBoardShortcut {
  KeyRightShotcut(VoidCallback callback)
      : super(LogicalKeySet(LogicalKeyboardKey.arrowRight), callback);
}
