import 'GridPoint3.dart';
import 'input_stream.dart';

class StreamUtils {
  static int readIntLE(InputStream stream) {
    return stream.read();
    // List<int> bytes = List.filled(4, -1);
    // if (stream.read(bytes) != 4) {
    //     throw new Exception("Not enough bytes to read an int");
    // }

    // return Uint8List.fromList(bytes).buffer.asInt8List();
  }

  static double readFloatLE(InputStream stream) {
    return stream.read() * 1.0;

    // int[] bytes = new int[4];
    // if (stream.read(bytes) != 4) {
    //     throw new IOException("Not enough bytes to read a float");
    // }

    // return ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN).getFloat();
  }

  static GridPoint3 readVector3i(InputStream stream) {
    return GridPoint3(readIntLE(stream), readIntLE(stream), readIntLE(stream));
  }

  static GridPoint3 readVector3b(InputStream stream) {
    int x = stream.read();
    int y = stream.read();
    int z = stream.read();

    if (x == -1 || y == -1 || z == -1) {
      throw Exception("Not enough bytes to read a vector3b");
    }

    return GridPoint3(x, y, z);
  }

  static String readString(InputStream stream) {
    int n = readIntLE(stream);
    if (n < 0) {
      throw Exception("String is too large to read");
    }

    List<int> bytes = List.filled(n, -1);
    if (stream.read(bytes) != n) {
      throw Exception("Not enough bytes to read a string of size " "$n");
    }

    return String.fromCharCodes(bytes);
  }

  static Map<String, String> readDictionary(InputStream stream) {
    int n = readIntLE(stream);
    if (n < 0) {
      throw Exception("Dictionary too large");
    }

    Map<String, String> dict = {};

    for (int i = 0; i < n; i++) {
      String key = readString(stream);
      String value = readString(stream);
      dict[key] = value;
    }

    return dict;
  }

  // ======================= WRITE METHODS =======================

  //  static void writeIntLE(int v, OutputStream stream) {
  //     stream.write(
  //         ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putInt(v).array()
  //     );
  // }

  //  static void writeVector3i(GridPoint3 v, OutputStream stream) {
  //     writeIntLE(v.x, stream);
  //     writeIntLE(v.y, stream);
  //     writeIntLE(v.z, stream);
  // }

  //  static void writeVector3b(GridPoint3 v, OutputStream stream) {
  //     stream.write(v.x);
  //     stream.write(v.y);
  //     stream.write(v.z);
  // }

  //  static void writeString(String s, OutputStream stream) {
  //     writeIntLE(s.length(), stream);
  //     stream.write(s.getBytes(StandardCharsets.UTF_8));
  // }

  //  static void writeDictionary(Map<String, String> dict, OutputStream stream) {
  //     writeIntLE(dict.length, stream);

  //     for (var entry in dict.entrySet()) {
  //         writeString(entry.getKey(), stream);
  //         writeString(entry.getValue(), stream);
  //     }
  // }
}
