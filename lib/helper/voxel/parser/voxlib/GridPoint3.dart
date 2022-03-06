import 'package:vector_math/vector_math_64.dart';

class GridPoint3 implements Comparable<GridPoint3> {
  int x;
  int y;
  int z;
  GridPoint3([
    this.x = 0,
    this.y = 0,
    this.z = 0,
  ]);

  factory GridPoint3.fromPoints(GridPoint3 point3) =>
      GridPoint3(point3.x, point3.y, point3.z);

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

  // bool equals(Object o) {
  //   if (this == o) return true;
  //   if (o.runtimeType != GridPoint3) return false;
  //   GridPoint3 that = o as ;
  //   return x == that.x && y == that.y && z == that.z;
  // }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GridPoint3 && other.x == x && other.y == y && other.z == z;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  @override
  String toString() {
    return "$x, $y, $z";
  }

  @override
  int compareTo(other) {
    return x.compareTo(other.x) & y.compareTo(other.y) & z.compareTo(other.z);
  }

  // @override
  // bool operator ==(Object other) {
  //   return equals(other);
  // }
}
