class BoardPosition extends Comparable<BoardPosition> {
  final int x;
  final int y;

  BoardPosition(this.x, this.y);

  BoardPosition copyWith({
    int? x,
    int? y,
  }) {
    return BoardPosition(
      x ?? this.x,
      y ?? this.y,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoardPosition && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  int compareTo(BoardPosition other) {
    if (y < other.y) {
      return -1;
    } else if (y > other.y) {
      return 1;
    } else {
      if (x < other.x) {
        return -1;
      } else if (x > other.x) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  @override
  String toString() {
    return "<X:$x , Y:$y>";
  }
}
