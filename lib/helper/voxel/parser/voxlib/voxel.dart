import 'GridPoint3.dart';

class Voxel {
  final GridPoint3 position;
  final int colourIndex;

  Voxel(
    this.position,
    this.colourIndex,
  );

  GridPoint3 getPosition() {
    return position;
  }

  int getColourIndex() {
    return colourIndex;
  }

  @override
  String toString() {
    return "(" + position.toString() + ", " + "$colourIndex" + ")";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Voxel &&
        other.position == position &&
        other.colourIndex == colourIndex;
  }

  @override
  int get hashCode => position.hashCode ^ colourIndex.hashCode;
}
