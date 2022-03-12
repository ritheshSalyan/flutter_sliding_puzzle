import 'dart:developer';
import 'dart:typed_data';

import '../InvalidVoxException.dart';
import '../input_stream.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';

abstract class VoxChunk {
  final String type;

  String getType() {
    return type;
  }

  VoxChunk(this.type);

  static VoxChunk? readChunk(InputStream stream, [String? expectedID]) {
    List<int> chunkID = List.filled(4, 0);
    int bytesRead = stream.read(chunkID);
    if (bytesRead != 4) {
      if (bytesRead == -1) {
        // There's no chunk here, this is fine.
        return null;
      }

      throw InvalidVoxException("Incomplete chunk ID");
    }

    String id = String.fromCharCodes(chunkID);

    if (expectedID != null && !(expectedID == id)) {
      throw InvalidVoxException(expectedID + " chunk expected, got " + id);
    }
    int length = StreamUtils.readIntLE(stream, id);
    int childrenLength = StreamUtils.readIntLE(stream, id);

    List<int> chunkBytes = List.generate(length, (index) => 0);
    List<int> childrenChunkBytes = List.generate(childrenLength, (index) => 0);
    // log("$id length and children Lenght: $length $childrenLength");
    // log("Reading Chunk $id");

    if (length > 0 && stream.read(chunkBytes) != length) {
      throw InvalidVoxException("Chunk \"" + id + "\" is incomplete");
    }
    // log("Reading Children $id");
    if (childrenLength > 0) {
      stream.read(childrenChunkBytes);
    }

    InputStream chunkStream = InputStream(
        Uint8List.fromList(chunkBytes).buffer.asByteData(),
        id + " Chunk Stream");
    InputStream childrenStream = InputStream(
        Uint8List.fromList(childrenChunkBytes).buffer.asByteData(),
        id + " Children Stream");
    VoxChunk? chunk = ChunkFactory.createChunk(id, chunkStream, childrenStream);
    return chunk;
  }

  //  void writeTo(OutputStream stream){

  // 		var contentStream = ByteArrayOutputStream();
  // 		var childStream = new ByteArrayOutputStream();

  // 		stream.write(utf8.encode(type));
  // 		writeContent(contentStream);
  // 		var contentBytes = contentStream.toByteArray();

  // 		writeChildren(childStream);
  // 		var childBytes = childStream.toByteArray();

  // 		StreamUtils.writeIntLE(contentBytes.length, stream);
  // 		StreamUtils.writeIntLE(childBytes.length, stream);
  // 		stream.write(contentBytes);
  // 		stream.write(childBytes);

  // }

  // /// Write to the stream the content directly associated with this chunk. */
  //  void writeContent(OutputStream stream)  {}

  // /// Write to the stream the content associated with this chunk's children. */
  //  void writeChildren(OutputStream stream) {}
}
