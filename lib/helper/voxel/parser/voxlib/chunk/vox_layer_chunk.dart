import '../GridPoint3.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxLayerChunk extends VoxChunk {
  int id = -1;
  int child_node_id = -1;
  GridPoint3 transform = GridPoint3();

  VoxLayerChunk() : super(ChunkFactory.LAYR);

  static VoxLayerChunk read(InputStream stream) {
    var chunk = VoxLayerChunk();
    chunk.id = StreamUtils.readIntLE(stream);
    Map<String, String> dict = StreamUtils.readDictionary(stream);
    //Settings.p("dict=" + dict);
    /*if (dict.containsKey("_name")) {
			Settings.p("Layer Name: " + dict.get("_name"));
		}*/
    int reserved = StreamUtils.readIntLE(stream);
    return chunk;
  }

  @override
  String toString() {
    return "VoxLayerChunk#" "$id" "_" + transform.toString();
  }

  @override
  void writeContent(OutputStream stream) {
    StreamUtils.writeIntLE(id, stream);
    StreamUtils.writeIntLE(0, stream); // dict
    StreamUtils.writeIntLE(0, stream); // reserved
  }
}
