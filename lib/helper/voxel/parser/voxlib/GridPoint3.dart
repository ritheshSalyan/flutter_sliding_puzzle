class GridPoint3 {
  int x, y, z;
  GridPoint3([
    this.x = 0,
    this.y = 0,
    this.z = 0,
  ]);

  factory GridPoint3.fromPoints(GridPoint3 point3) => GridPoint3(
    point3.x,
    point3.y,
    point3.z
  );

  //  GridPoint3() {
  // }

  //  GridPoint3(int _x, int _y, int _z) {
  // 	x = _x;
  // 	y = _y;
  // 	z = _z;
  // }

  //  GridPoint3(GridPoint3 point) {
  // 	x = point.x;
  // 	y = point.y;
  // 	z = point.z;
  // }

  void set(int _x, int _y, int _z) {
    x = _x;
    y = _y;
    z = _z;
  }

  void add(int _x, int _y, int _z) {
    x += _x;
    y += _y;
    z += _z;
  }

  void addGP(GridPoint3 point) {
    x += point.x;
    y += point.y;
    z += point.z;
  }

  bool equals(Object o) {
    if (this == o) return true;
    if (runtimeType != o.runtimeType) return false;
    GridPoint3 that = o as GridPoint3;
    return x == that.x && y == that.y && z == that.z;
  }

  @override
  int get hashCode {
    return x.hashCode ^ y.hashCode ^ z.hashCode;
  }

  @override
  String toString() {
    return "$x, $y, $z";
  }

  @override
  bool operator ==(Object other) {
    return equals(other);
  }
}
