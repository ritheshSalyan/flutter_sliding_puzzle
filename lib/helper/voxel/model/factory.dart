import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';
import 'package:sliding_puzzle/helper/voxel/model/voxel_mesh.dart';

class VoxelMeshFactory {
  final String text;

  VoxelMeshFactory(this.text);

  VoxelMesh construct() {
    final List<String> lines = text.split("\n");
    final List<VoxelBlock> blocks = [];
    int maxX = -1;
    int maxY = -1;
    for (var line in lines) {
      final elements = line.split(" ");

      if (elements.length == 4) {
        final x = int.tryParse(elements[0]);
        final y = int.tryParse(elements[1]);
        final z = int.tryParse(elements[2]);
        final color = "FF" + elements[3];
        if (x != null && y != null && z != null && color.length > 2) {
          blocks.add(VoxelBlock(x: x, y: y, z: -z, color: color));

          if (maxX < x) {
            maxX = x;
          }
          if (maxY < y) {
            maxY = y;
          }
        }
      }
    }

    return VoxelMesh(
      blocks: blocks,
      maxX: maxX,
      maxY: maxY,
    );
  }
}
