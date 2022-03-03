// package com.scs.voxlib;

// import java.io.Closeable;
// import java.io.DataOutputStream;
// import java.io.IOException;
// import java.io.OutputStream;

// public class VoxWriter implements Closeable {
//     public static final int VERSION = 150;

//     private final DataOutputStream stream;

//     public VoxWriter(OutputStream stream) {
//         if (stream == null) {
//             throw new IllegalArgumentException("stream must not be null");
//         }

//         this.stream = new DataOutputStream(stream);
//     }

//     public void write(VoxFile file) throws IOException {
//         try (stream) {
//             stream.write(VoxReader.MAGIC_BYTES);
//             StreamUtils.writeIntLE(file.getVersion(), stream);
//             file.getRoot().writeTo(stream);
//         }
//     }

//     @Override
//     public void close() throws IOException {
//         stream.close();
//     }
// }
