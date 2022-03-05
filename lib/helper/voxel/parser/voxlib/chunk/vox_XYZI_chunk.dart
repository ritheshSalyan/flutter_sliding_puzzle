import 'dart:developer';

import '../input_stream.dart';
import '../stream_utils.dart';
import '../voxel.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxXYZIChunk extends VoxChunk {
  List<Voxel> voxels = [];

  //  VoxXYZIChunk(): super(ChunkFactory.XYZI){

  // }

  VoxXYZIChunk([this.voxels = const []]) : super(ChunkFactory.XYZI);

  static VoxXYZIChunk read(InputStream stream) {
    int voxelCount = StreamUtils.readIntLE(stream);
    List<Voxel> voxels = [];
    // var chunk = VoxXYZIChunk();
    log("$voxelCount" " voxels");

    for (int i = 0; i < voxelCount ; i++) {
      // print(i);
      var position = StreamUtils.readVector3b(stream);
      var colorIndex = (stream.read() & 0xff);
      voxels.add(Voxel(position, colorIndex));
    }
    return VoxXYZIChunk(voxels);
  }

  List<Voxel> getVoxels() {
    return voxels;
  }

// @override
//   void writeContent(OutputStream stream)  {
//         StreamUtils.writeIntLE(voxels.length, stream);
//         for (var voxel in voxels) {
//             StreamUtils.writeVector3b(voxel.getPosition(), stream);
//             stream.write(voxel.getColourIndex());
//         }
//     }
}
