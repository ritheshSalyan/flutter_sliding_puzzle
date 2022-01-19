class BoardPosition {
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
}
