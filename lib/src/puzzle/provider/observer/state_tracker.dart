// class BoardMovementStateTracker extends ChangeNotifier
//     with StackTracker<PuzzleBoard> {
//   static final provider =
//       ChangeNotifierProvider<BoardMovementStateTracker>((ref) {
//     return BoardMovementStateTracker();
//   });

//   @override
//   void saveState(PuzzleBoard state) {
//     super.saveState(state);
//     notifyListeners();
//   }
// }

// final movesCount = StateProvider<int>((ref) {
//   final boardState = ref.watch(BoardController.provider);

//   var watch = ref.watch(BoardMovementStateTracker.provider);
//   watch.saveState(boardState);
//   return watch.moves;
// });

mixin StackTracker<T> {
  final List<T> _stack = [];

  int get moves => _stack.length;

  void saveState(T state) {
    _stack.add(state);
  }

  T? popState() {
    if (_stack.isNotEmpty) {
      return _stack.removeLast();
    }
    return null;
  }
}
