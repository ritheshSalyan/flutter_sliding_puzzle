class VoxelBlock {
  final int x;
  final int y;
  final int z;
  final String color;
  final VisibleFaces visibleFaces;
  VoxelBlock({
    required this.x,
    required this.y,
    required this.z,
    required this.color,
    required this.visibleFaces,
  });

  VoxelBlock copyWith({
    int? x,
    int? y,
    int? z,
    String? color,
    VisibleFaces? visibleFaces,
  }) {
    return VoxelBlock(
      x: x ?? this.x,
      y: y ?? this.y,
      z: z ?? this.z,
      color: color ?? this.color,
      visibleFaces: visibleFaces ?? this.visibleFaces,
    );
  }

  @override
  String toString() {
    return 'VoxelBlock(x: $x, y: $y, z: $z, color: $color, visibleFaces: $visibleFaces)';
  }
}

class VisibleFaces {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final bool up;
  final bool down;
  VisibleFaces({
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.up = true,
    this.down = true,
  });

  ///
  ///
  ///If All Faces are covered then we consider it as completely invisible
  ///
  ///
  bool get isCompletelyCovered =>
      !top && !bottom && !left && !right && !up && !down;

  VisibleFaces copyWith({
    bool? top,
    bool? bottom,
    bool? left,
    bool? right,
    bool? up,
    bool? down,
  }) {
    return VisibleFaces(
      top: top ?? this.top,
      bottom: bottom ?? this.bottom,
      left: left ?? this.left,
      right: right ?? this.right,
      up: up ?? this.up,
      down: down ?? this.down,
    );
  }
}
