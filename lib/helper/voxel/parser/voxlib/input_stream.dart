import 'dart:typed_data';

class InputStream {
  final ByteData _bytes;
  final String key;
  InputStream(this._bytes, this.key) : _currentOffset = 0;

  // Future<void> readFromAsset(String path) async {
  //   _bytes = await rootBundle.load(path);

  // }

  int _currentOffset = 0;
  int read([List<int>? buffer, String readingIn = "UNKOWN"]) {
    if (buffer == null) {
      if (_bytes.lengthInBytes < _currentOffset) return -1;
      int data = _bytes.buffer.asUint8List().elementAt(_currentOffset);

      _currentOffset += 1;

      // log("Read Int: $key + $readingIn : currentOffset $_currentOffset  readValue =  $data");
      return data;
    }
    if (buffer.isEmpty) return 0;
    final bufferData = _bytes.buffer.asUint8List(_currentOffset, buffer.length);

    for (var i = 0; i < buffer.length; i++) {
      buffer[i] = bufferData.elementAt(i);
    }
    // log("$key $_currentOffset ${bufferData.length}  Read List:" +
    //     buffer.toList().toString());
    _currentOffset += bufferData.length;
    // log("Read List: $key + $readingIn : currentOffset $_currentOffset  Read Value Length: ${bufferData.length}");

    return bufferData.length;
  }

  int available() {
    return _bytes.lengthInBytes - _currentOffset;
  }
}
