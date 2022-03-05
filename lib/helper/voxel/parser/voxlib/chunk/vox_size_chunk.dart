import 'dart:developer';

import 'package:sliding_puzzle/helper/voxel/parser/voxlib/GridPoint3.dart';

import '../input_stream.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxSizeChunk extends VoxChunk {
  final GridPoint3 size;

  VoxSizeChunk(this.size) : super(ChunkFactory.SIZE);

  // VoxSizeChunk(int width, int length, int height) {
  //   super(ChunkFactory.SIZE);
  //   size = GridPoint3(width, length, height);
  // }

  static VoxSizeChunk read(InputStream stream) {
    var size = StreamUtils.readVector3i(stream);
    log("Read size of " + size.toString());
    return VoxSizeChunk(size);
  }

  GridPoint3 getSize() {
    return size;
  }

  // @override
  // void writeContent(OutputStream stream) {
  //   StreamUtils.writeVector3i(size, stream);
  // }
}
