import 'dart:typed_data';

import 'package:flutter/services.dart';

class InputStream{
  ByteData _bytes;
  InputStream(this._bytes);
  
  // Future<void> readFromAsset(String path) async {
  //   _bytes = await rootBundle.load(path);
    
  // }

  int _currentOffset = 0;
  int read([List<int> buffer = const []]){
    if(buffer.isEmpty){
     int data = _bytes.getUint32(_currentOffset,Endian.little);
     _currentOffset+=4;
    return data;
    }
   final bufferData = _bytes.buffer.asUint8List(_currentOffset,buffer.length);

   for (var i = 0; i < buffer.length; i++) {
      buffer[i] = bufferData.elementAt(i);
   }
   _currentOffset+= bufferData.length;
   return bufferData.length;
  }



  int available(){
    return _bytes.lengthInBytes - _currentOffset;
  }
}