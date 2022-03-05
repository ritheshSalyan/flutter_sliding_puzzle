
import 'voxel_block.dart';

class VoxelChunk {
  final VoxelBlock start;
  final VoxelBlock end;
  final String chunkValue;
  VoxelChunk(
    this.start,
    this.end,
    this.chunkValue,
  );

  int get width => end.x - start.x + 1;
  int get height => end.y - start.y + 1;
  int get depth => end.z - start.z + 1;

  @override
  String toString() =>
      'VoxelChunk(start: $start, end: $end, chunkValue: $chunkValue)';
}
