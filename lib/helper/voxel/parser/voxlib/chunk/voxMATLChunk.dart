import '../input_stream.dart';
import '../mat/voxMaterial.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxMATLChunk extends VoxChunk {
  final VoxMaterial material;

  VoxMATLChunk(this.material) : super(ChunkFactory.MATL);

  static VoxMATLChunk read(InputStream stream) {
    int id = StreamUtils.readIntLE(stream);
    Map<String, String> props = StreamUtils.readDictionary(stream);
    var material = VoxMaterial(id, props);
    return VoxMATLChunk(material);
  }

  VoxMaterial getMaterial() {
    return material;
  }

  // @override
  // void writeContent(OutputStream stream) {
  //   StreamUtils.writeIntLE(material.getID(), stream);
  //   StreamUtils.writeDictionary(material.getProps(), stream);
  // }
}
