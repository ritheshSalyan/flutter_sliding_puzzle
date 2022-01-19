import 'position.dart';

class Tile<T> {
  final BoardPosition correctPos;
  final BoardPosition currentPos;
  final T data;

  Tile({required this.correctPos, required this.currentPos, required this.data});

  Tile<T> copyWith({
    BoardPosition? correctPos,
    BoardPosition? currentPos,
    T? data,
  }) {
    return Tile<T>(
      correctPos: correctPos ?? this.correctPos,
      currentPos: currentPos ?? this.currentPos,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Tile<T> &&
      other.correctPos == correctPos &&
      other.currentPos == currentPos &&
      other.data == data;
  }

  @override
  int get hashCode => correctPos.hashCode ^ currentPos.hashCode ^ data.hashCode;
}
