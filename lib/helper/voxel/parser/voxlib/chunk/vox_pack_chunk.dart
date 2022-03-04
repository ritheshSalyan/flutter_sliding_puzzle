import '../input_stream.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxPackChunk extends VoxChunk {
  final int modelCount;

  VoxPackChunk(this.modelCount) : super(ChunkFactory.PACK);

  static VoxPackChunk read(InputStream stream) {
    var modelCount = StreamUtils.readIntLE(stream);
    return VoxPackChunk(modelCount);
  }

  int getModelCount() {
    return modelCount;
  }

  // @override
  // void writeContent(OutputStream stream) {
  //   StreamUtils.writeIntLE(modelCount, stream);
  // }
}
