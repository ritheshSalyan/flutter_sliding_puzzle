import 'package:flutter/foundation.dart';

import 'GridPoint3.dart';
import 'voxel.dart';

class VoxModelBlueprint {
  final int id;
  final GridPoint3 size;
  final List<Voxel> voxels;

  VoxModelBlueprint(this.id, this.size, this.voxels);

  GridPoint3 getSize() {
    return size;
  }

  List<Voxel> getVoxels() {
    return voxels;
  }

  //  boolean equals(Object o) {
  //     if (this == o) return true;
  //     if (o == null || getClass() != o.getClass()) return false;
  //     VoxModelBlueprint voxModel = (VoxModelBlueprint) o;
  //     return size.equals(voxModel.size) &&
  //             Arrays.equals(voxels, voxModel.voxels);
  // }

  // @Override
  //  int hashCode() {
  //     int result = Objects.hash(size);
  //     result = 31 * result + Arrays.hashCode(voxels);
  //     return result;
  // }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VoxModelBlueprint &&
        other.id == id &&
        other.size == size &&
        listEquals(other.voxels, voxels);
  }

  @override
  int get hashCode => id.hashCode ^ size.hashCode ^ voxels.hashCode;
}
