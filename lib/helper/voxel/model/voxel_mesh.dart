import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';

class VoxelMesh {
  final List<VoxelBlock> blocks;
  final int maxX;
  final int maxY;
  final int maxZ;
  VoxelMesh({
    required this.blocks,
    required this.maxX,
    required this.maxY,
    required this.maxZ,
  });
}
