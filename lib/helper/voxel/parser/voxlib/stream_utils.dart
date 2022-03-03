

 import 'dart:io';
import 'dart:typed_data';

import 'GridPoint3.dart';

class StreamUtils {

	 static int readIntLE(InputStream stream){
    
        List<int> bytes = List.filled(4, -1); 
        if (stream.read(bytes) != 4) {
            throw new Exception("Not enough bytes to read an int");
        }

        return Uint8List.fromList(bytes).buffer.asInt8List();
    }

	 static double readFloatLE(InputStream stream) {
        int[] bytes = new int[4];
        if (stream.read(bytes) != 4) {
            throw new IOException("Not enough bytes to read a float");
        }

        return ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN).getFloat();
    }

	 static GridPoint3 readVector3i(InputStream stream) {
        return new GridPoint3(readIntLE(stream), readIntLE(stream), readIntLE(stream));
    }

	 static GridPoint3 readVector3b(InputStream stream) {
        int x = stream.read();
        int y = stream.read();
        int z = stream.read();

        if (x == -1 || y == -1 || z == -1) {
            throw new IOException("Not enough bytes to read a vector3b");
        }

        return new GridPoint3((int)x, (int)y, (int)z);
    }

	 static String readString(InputStream stream) {
        int n = readIntLE(stream);
        if (n < 0) {
            throw new IOException("String is too large to read");
        }

        int[] bytes = new int[n];
        if (stream.read(bytes) != n) {
            throw new IOException("Not enough bytes to read a string of size " + n);
        }

        return new String(bytes);
    }

	 static HashMap<String, String> readDictionary(InputStream stream) {
        int n = readIntLE(stream);
        if (n < 0) {
            throw new InvalidVoxException("Dictionary too large");
        }

        HashMap<String, String> dict = new HashMap<>(n);

        for (int i = 0; i < n; i++) {
            String key = readString(stream);
            String value = readString(stream);
            dict.put(key, value);
        }

        return dict;
    }


    // ======================= WRITE METHODS =======================

     static void writeIntLE(int v, OutputStream stream) {
        stream.write(
            ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putInt(v).array()
        );
    }
    
     static void writeVector3i(GridPoint3 v, OutputStream stream) {
        writeIntLE(v.x, stream);
        writeIntLE(v.y, stream);
        writeIntLE(v.z, stream);
    }

     static void writeVector3b(GridPoint3 v, OutputStream stream) {
        stream.write(v.x);
        stream.write(v.y);
        stream.write(v.z);
    }

     static void writeString(String s, OutputStream stream) {
        writeIntLE(s.length(), stream);
        stream.write(s.getBytes(StandardCharsets.UTF_8));
    }

     static void writeDictionary(Map<String, String> dict, OutputStream stream) {
        writeIntLE(dict.length, stream);

        for (var entry in dict.entrySet()) {
            writeString(entry.getKey(), stream);
            writeString(entry.getValue(), stream);
        }
    }
}
