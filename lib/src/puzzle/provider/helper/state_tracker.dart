mixin StateTracker<T> {
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
