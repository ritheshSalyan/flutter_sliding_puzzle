import 'dart:typed_data';

import '../stream_utils.dart';
import 'chunk_factory.dart';
import 'vox_chunk.dart';

class VoxRGBAChunk extends VoxChunk {
  static final DEFAULT_PALETTE = [
    0x00000000,
    0xFFFFFFFF,
    0xFFCCFFFF,
    0xFF99FFFF,
    0xFF66FFFF,
    0xFF33FFFF,
    0xFF00FFFF,
    0xFFFFCCFF,
    0xFFCCCCFF,
    0xFF99CCFF,
    0xFF66CCFF,
    0xFF33CCFF,
    0xFF00CCFF,
    0xFFFF99FF,
    0xFFCC99FF,
    0xFF9999FF,
    0xFF6699FF,
    0xFF3399FF,
    0xFF0099FF,
    0xFFFF66FF,
    0xFFCC66FF,
    0xFF9966FF,
    0xFF6666FF,
    0xFF3366FF,
    0xFF0066FF,
    0xFFFF33FF,
    0xFFCC33FF,
    0xFF9933FF,
    0xFF6633FF,
    0xFF3333FF,
    0xFF0033FF,
    0xFFFF00FF,
    0xFFCC00FF,
    0xFF9900FF,
    0xFF6600FF,
    0xFF3300FF,
    0xFF0000FF,
    0xFFFFFFCC,
    0xFFCCFFCC,
    0xFF99FFCC,
    0xFF66FFCC,
    0xFF33FFCC,
    0xFF00FFCC,
    0xFFFFCCCC,
    0xFFCCCCCC,
    0xFF99CCCC,
    0xFF66CCCC,
    0xFF33CCCC,
    0xFF00CCCC,
    0xFFFF99CC,
    0xFFCC99CC,
    0xFF9999CC,
    0xFF6699CC,
    0xFF3399CC,
    0xFF0099CC,
    0xFFFF66CC,
    0xFFCC66CC,
    0xFF9966CC,
    0xFF6666CC,
    0xFF3366CC,
    0xFF0066CC,
    0xFFFF33CC,
    0xFFCC33CC,
    0xFF9933CC,
    0xFF6633CC,
    0xFF3333CC,
    0xFF0033CC,
    0xFFFF00CC,
    0xFFCC00CC,
    0xFF9900CC,
    0xFF6600CC,
    0xFF3300CC,
    0xFF0000CC,
    0xFFFFFF99,
    0xFFCCFF99,
    0xFF99FF99,
    0xFF66FF99,
    0xFF33FF99,
    0xFF00FF99,
    0xFFFFCC99,
    0xFFCCCC99,
    0xFF99CC99,
    0xFF66CC99,
    0xFF33CC99,
    0xFF00CC99,
    0xFFFF9999,
    0xFFCC9999,
    0xFF999999,
    0xFF669999,
    0xFF339999,
    0xFF009999,
    0xFFFF6699,
    0xFFCC6699,
    0xFF996699,
    0xFF666699,
    0xFF336699,
    0xFF006699,
    0xFFFF3399,
    0xFFCC3399,
    0xFF993399,
    0xFF663399,
    0xFF333399,
    0xFF003399,
    0xFFFF0099,
    0xFFCC0099,
    0xFF990099,
    0xFF660099,
    0xFF330099,
    0xFF000099,
    0xFFFFFF66,
    0xFFCCFF66,
    0xFF99FF66,
    0xFF66FF66,
    0xFF33FF66,
    0xFF00FF66,
    0xFFFFCC66,
    0xFFCCCC66,
    0xFF99CC66,
    0xFF66CC66,
    0xFF33CC66,
    0xFF00CC66,
    0xFFFF9966,
    0xFFCC9966,
    0xFF999966,
    0xFF669966,
    0xFF339966,
    0xFF009966,
    0xFFFF6666,
    0xFFCC6666,
    0xFF996666,
    0xFF666666,
    0xFF336666,
    0xFF006666,
    0xFFFF3366,
    0xFFCC3366,
    0xFF993366,
    0xFF663366,
    0xFF333366,
    0xFF003366,
    0xFFFF0066,
    0xFFCC0066,
    0xFF990066,
    0xFF660066,
    0xFF330066,
    0xFF000066,
    0xFFFFFF33,
    0xFFCCFF33,
    0xFF99FF33,
    0xFF66FF33,
    0xFF33FF33,
    0xFF00FF33,
    0xFFFFCC33,
    0xFFCCCC33,
    0xFF99CC33,
    0xFF66CC33,
    0xFF33CC33,
    0xFF00CC33,
    0xFFFF9933,
    0xFFCC9933,
    0xFF999933,
    0xFF669933,
    0xFF339933,
    0xFF009933,
    0xFFFF6633,
    0xFFCC6633,
    0xFF996633,
    0xFF666633,
    0xFF336633,
    0xFF006633,
    0xFFFF3333,
    0xFFCC3333,
    0xFF993333,
    0xFF663333,
    0xFF333333,
    0xFF003333,
    0xFFFF0033,
    0xFFCC0033,
    0xFF990033,
    0xFF660033,
    0xFF330033,
    0xFF000033,
    0xFFFFFF00,
    0xFFCCFF00,
    0xFF99FF00,
    0xFF66FF00,
    0xFF33FF00,
    0xFF00FF00,
    0xFFFFCC00,
    0xFFCCCC00,
    0xFF99CC00,
    0xFF66CC00,
    0xFF33CC00,
    0xFF00CC00,
    0xFFFF9900,
    0xFFCC9900,
    0xFF999900,
    0xFF669900,
    0xFF339900,
    0xFF009900,
    0xFFFF6600,
    0xFFCC6600,
    0xFF996600,
    0xFF666600,
    0xFF336600,
    0xFF006600,
    0xFFFF3300,
    0xFFCC3300,
    0xFF993300,
    0xFF663300,
    0xFF333300,
    0xFF003300,
    0xFFFF0000,
    0xFFCC0000,
    0xFF990000,
    0xFF660000,
    0xFF330000,
    0xFF0000EE,
    0xFF0000DD,
    0xFF0000BB,
    0xFF0000AA,
    0xFF000088,
    0xFF000077,
    0xFF000055,
    0xFF000044,
    0xFF000022,
    0xFF000011,
    0xFF00EE00,
    0xFF00DD00,
    0xFF00BB00,
    0xFF00AA00,
    0xFF008800,
    0xFF007700,
    0xFF005500,
    0xFF004400,
    0xFF002200,
    0xFF001100,
    0xFFEE0000,
    0xFFDD0000,
    0xFFBB0000,
    0xFFAA0000,
    0xFF880000,
    0xFF770000,
    0xFF550000,
    0xFF440000,
    0xFF220000,
    0xFF110000,
    0xFFEEEEEE,
    0xFFDDDDDD,
    0xFFBBBBBB,
    0xFFAAAAAA,
    0xFF888888,
    0xFF777777,
    0xFF555555,
    0xFF444444,
    0xFF222222,
    0xFF111111
  ];

  late final Uint8List palette;

  VoxRGBAChunk([Uint8List? palette]) : super(ChunkFactory.RGBA) {
    this.palette = palette ??= Uint8List(256);
  }

  /// The provided colour integers must be in the ARGB format, i.e.
  /// the highest 8 bits represent the Alpha channel, and
  /// the lowest 8 bits represent the blue channel.
  /// Valid indices are from 1 to 255; 0 is not used.
  // public VoxRGBAChunk(int[] palette) {
  //     super(ChunkFactory.RGBA);
  //     for (int i = 1; i < 256 && i < palette.length; i++) {
  //         this.palette[i] = palette[i];
  //     }
  // }

  static VoxRGBAChunk read(InputStream stream) {
    var chunk = VoxRGBAChunk();
    for (int i = 0; i < 255; i++) {
      var abgr = StreamUtils.readIntLE(stream);
      chunk.palette[i + 1] = ABGRToARGB(abgr);
    }
    return chunk;
  }

  /// The returned colour integers are in the ARGB format, i.e.
  /// the highest 8 bits represent the Alpha channel, and
  /// the lowest 8 bits represent the blue channel.
  /// Valid indices are from 1 to 255; 0 is not used.
  List<int> getPalette() {
    return palette;
  }

  static int ABGRToARGB(int abgr) {
    int alpha = (abgr & 0xFF000000) >> 24;
    int blue = (abgr & 0xFF0000) >> 16;
    int green = (abgr & 0xFF00) >> 8;
    int red = (abgr & 0xFF);
    return (blue) | (green << 8) | (red << 16) | (alpha << 24);
  }

  static int ARGBToABGR(int argb) {
    int alpha = (argb & 0xFF000000) >> 24;
    int red = (argb & 0xFF0000) >> 16;
    int green = (argb & 0xFF00) >> 8;
    int blue = (argb & 0xFF);
    return (red) | (green << 8) | (blue << 16) | (alpha << 24);
  }

  @override
  void writeContent(OutputStream stream) {
    for (int i = 0; i < 255; i++) {
      var abgr = ARGBToABGR(palette[i + 1]);
      StreamUtils.writeIntLE(abgr, stream);
    }
  }
}
