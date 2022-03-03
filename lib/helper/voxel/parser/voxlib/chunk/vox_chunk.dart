
 import 'dart:convert';

import '../InvalidVoxException.dart';
import '../stream_utils.dart';
import 'chunk_factory.dart';

abstract class VoxChunk {

	 final String type;

	 String getType() {
		return type;
	}

	 VoxChunk(this.type);
	


	 static VoxChunk? readChunk(InputStream stream, [String? expectedID]) {
		List<int> chunkID = List.filled(4, -1);
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

		int length = StreamUtils.readIntLE(stream);
		int childrenLength = StreamUtils.readIntLE(stream);

		List<int> chunkBytes = List.generate(length, (index) => -1);
		List<int> childrenChunkBytes = List.generate(childrenLength, (index) => 0) ;

		if (length > 0 && stream.read(chunkBytes) != length) {
			throw InvalidVoxException("Chunk \"" + id + "\" is incomplete");
		}

		stream.read(childrenChunkBytes);

		ByteArrayInputStream chunkStream = new ByteArrayInputStream(chunkBytes);
				ByteArrayInputStream childrenStream = new ByteArrayInputStream(childrenChunkBytes)
			VoxChunk? chunk = ChunkFactory.createChunk(id, chunkStream, childrenStream);
			return chunk;
	
	}

	 void writeTo(OutputStream stream){

			var contentStream = ByteArrayOutputStream();
			var childStream = new ByteArrayOutputStream();

			stream.write(utf8.encode(type));
			writeContent(contentStream);
			var contentBytes = contentStream.toByteArray();

			writeChildren(childStream);
			var childBytes = childStream.toByteArray();

			StreamUtils.writeIntLE(contentBytes.length, stream);
			StreamUtils.writeIntLE(childBytes.length, stream);
			stream.write(contentBytes);
			stream.write(childBytes);
	
	}

	/// Write to the stream the content directly associated with this chunk. */
	 void writeContent(OutputStream stream)  {}

	/// Write to the stream the content associated with this chunk's children. */
	 void writeChildren(OutputStream stream) {}
}
