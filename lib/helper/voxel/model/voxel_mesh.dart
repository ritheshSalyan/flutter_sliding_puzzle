import 'dart:math';

import 'package:sliding_puzzle/helper/voxel/model/voxel_block.dart';

import 'voxel_chunk.dart';

class VoxelMesh {
  final List<VoxelBlock> blocks;
  final List<VoxelChunk> chunks;
  final int maxX;
  final int maxY;
  final int maxZ;

  int get maxAxis => max(max(maxX, maxY), maxZ);
  VoxelMesh({
    required this.blocks,
    required this.chunks,
    required this.maxX,
    required this.maxY,
    required this.maxZ,
  });

  VoxelMesh copyWith({
    List<VoxelBlock>? blocks,
    List<VoxelChunk>? chunks,
    int? maxX,
    int? maxY,
    int? maxZ,
  }) {
    return VoxelMesh(
      blocks: blocks ?? this.blocks,
      chunks: chunks ?? this.chunks,
      maxX: maxX ?? this.maxX,
      maxY: maxY ?? this.maxY,
      maxZ: maxZ ?? this.maxZ,
    );
  }
}
