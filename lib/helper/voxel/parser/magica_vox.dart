


//     import 'dart:typed_data';
//      class ChunkType
//         {
//             static const int Main = 1296124238;
//             static const int Matt = 1296127060;
//             static const int Pack = 1346454347;
//             static const int Rgba = 1380401729;
//             static const int Size = 1397316165;
//             static const int Xyzi = 1482250825;
//         }

//          class MaterialType
//         {
//            static const  Diffuse = 0;
//            static const  Metal = 1;
//            static const  Glass = 2;
//            static const  Emissive = 3;
//         }

//          class PropertyBitsType
//         {
//             static const int Plastic = 1;
//             static const int Roughness = 2;
//             static const int Specular = 4;
//             static const int Ior = 8;
//             static const int Attenuation = 16;
//             static const int Power = 32;
//             static const int Glow = 64;
//             static const int IsTotalPower = 128;
//         }
// /// <remarks>
//     /// Reference: <a href="https://ephtracy.github.io/">MagicaVoxel Homepage</a>
//     /// </remarks>
//     /// <remarks>
//     /// Reference: <a href="https://github.com/ephtracy/voxel-model/blob/master/MagicaVoxel-file-format-vox.txt">Format Description</a>
//     /// </remarks>
//  class MagicavoxelVox
//     {
//         //  static MagicavoxelVox fromFile(string fileName)
//         // {
//         //     return new MagicavoxelVox(new KaitaiStream(fileName));
//         // }


    
//          MagicavoxelVox(KaitaiStream pIo,)
//         {
//             // m_parent = p__parent;
//             // m_root = p__root ?? this;
//             _read();
//         }
//          void _read()
//         {
//             _magic = m_io.ReadBytes(4);
//             if (!((KaitaiStream.ByteArrayCompare(Magic, new Uint8List { 86, 79, 88, 32 }) == 0)))
//             {
//                 throw ValidationNotEqualError(new Uint8List { 86, 79, 88, 32 }, Magic, M_Io, "/seq/0");
//             }
//             _version = m_io.ReadU4le();
//             _main = Chunk(m_io, this, m_root);
//         }
//           class Chunk
//         {
//              static Chunk FromFile(string fileName)
//             {
//                 return new Chunk(new KaitaiStream(fileName));
//             }

//              Chunk(KaitaiStream p__io, KaitaiStruct p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 _read();
//             }
//              void _read()
//             {
//                 _chunkId = ((MagicavoxelVox.ChunkType) m_io.ReadU4be());
//                 _numBytesOfChunkContent = m_io.ReadU4le();
//                 _numBytesOfChildrenChunks = m_io.ReadU4le();
//                 if (NumBytesOfChunkContent != 0) {
//                     switch (ChunkId) {
//                     case MagicavoxelVox.ChunkType.Size: {
//                         __raw_chunkContent = m_io.ReadBytes(NumBytesOfChunkContent);
//                         var io___raw_chunkContent = new KaitaiStream(__raw_chunkContent);
//                         _chunkContent = new Size(io___raw_chunkContent, this, m_root);
//                         break;
//                     }
//                     case MagicavoxelVox.ChunkType.Matt: {
//                         __raw_chunkContent = m_io.ReadBytes(NumBytesOfChunkContent);
//                         var io___raw_chunkContent = new KaitaiStream(__raw_chunkContent);
//                         _chunkContent = new Matt(io___raw_chunkContent, this, m_root);
//                         break;
//                     }
//                     case MagicavoxelVox.ChunkType.Rgba: {
//                         __raw_chunkContent = m_io.ReadBytes(NumBytesOfChunkContent);
//                         var io___raw_chunkContent = new KaitaiStream(__raw_chunkContent);
//                         _chunkContent = new Rgba(io___raw_chunkContent, this, m_root);
//                         break;
//                     }
//                     case MagicavoxelVox.ChunkType.Xyzi: {
//                         __raw_chunkContent = m_io.ReadBytes(NumBytesOfChunkContent);
//                         var io___raw_chunkContent = new KaitaiStream(__raw_chunkContent);
//                         _chunkContent = new Xyzi(io___raw_chunkContent, this, m_root);
//                         break;
//                     }
//                     case MagicavoxelVox.ChunkType.Pack: {
//                         __raw_chunkContent = m_io.ReadBytes(NumBytesOfChunkContent);
//                         var io___raw_chunkContent = new KaitaiStream(__raw_chunkContent);
//                         _chunkContent = new Pack(io___raw_chunkContent, this, m_root);
//                         break;
//                     }
//                     default: {
//                         _chunkContent = m_io.ReadBytes(NumBytesOfChunkContent);
//                         break;
//                     }
//                     }
//                 }
//                 if (NumBytesOfChildrenChunks != 0) {
//                     _childrenChunks = new List<Chunk>();
//                     {
//                         var i = 0;
//                         while (!m_io.IsEof) {
//                             _childrenChunks.Add(new Chunk(m_io, this, m_root));
//                             i++;
//                         }
//                     }
//                 }
//             }
//              ChunkType _chunkId;
//              uint _numBytesOfChunkContent;
//              uint _numBytesOfChildrenChunks;
//              object _chunkContent;
//              List<Chunk> _childrenChunks;
//              MagicavoxelVox m_root;
//              KaitaiStruct m_parent;
//              Uint8List __raw_chunkContent;
//              ChunkType ChunkId { get { return _chunkId; } }
//              uint NumBytesOfChunkContent { get { return _numBytesOfChunkContent; } }
//              uint NumBytesOfChildrenChunks { get { return _numBytesOfChildrenChunks; } }
//              object ChunkContent { get { return _chunkContent; } }
//              List<Chunk> ChildrenChunks { get { return _childrenChunks; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              KaitaiStruct M_Parent { get { return m_parent; } }
//              Uint8List M_RawChunkContent { get { return __raw_chunkContent; } }
//         }
//           class Size 
//         {
//              static Size FromFile(string fileName)
//             {
//                 return new Size(new KaitaiStream(fileName));
//             }

//              Size(KaitaiStream p__io, MagicavoxelVox.Chunk p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 _read();
//             }
//              void _read()
//             {
//                 _sizeX = m_io.ReadU4le();
//                 _sizeY = m_io.ReadU4le();
//                 _sizeZ = m_io.ReadU4le();
//             }
//              uint _sizeX;
//              uint _sizeY;
//              uint _sizeZ;
//              MagicavoxelVox m_root;
//              MagicavoxelVox.Chunk m_parent;
//              uint SizeX { get { return _sizeX; } }
//              uint SizeY { get { return _sizeY; } }
//              uint SizeZ { get { return _sizeZ; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              MagicavoxelVox.Chunk M_Parent { get { return m_parent; } }
//         }
//           class Rgba
//         {
//              static Rgba FromFile(string fileName)
//             {
//                 return new Rgba(new KaitaiStream(fileName));
//             }

//              Rgba(KaitaiStream p__io, MagicavoxelVox.Chunk p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 _read();
//             }
//              void _read()
//             {
//                 _colors = new List<Color>((int) (256));
//                 for (var i = 0; i < 256; i++)
//                 {
//                     _colors.Add(new Color(m_io, this, m_root));
//                 }
//             }
//              List<Color> _colors;
//              MagicavoxelVox m_root;
//              MagicavoxelVox.Chunk m_parent;
//              List<Color> Colors { get { return _colors; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              MagicavoxelVox.Chunk M_Parent { get { return m_parent; } }
//         }
//           class Pack
//         {
//              static Pack FromFile(string fileName)
//             {
//                 return new Pack(new KaitaiStream(fileName));
//             }

//              Pack(KaitaiStream p__io, MagicavoxelVox.Chunk p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 _read();
//             }
//              void _read()
//             {
//                 _numModels = m_io.ReadU4le();
//             }
//              uint _numModels;
//              MagicavoxelVox m_root;
//              MagicavoxelVox.Chunk m_parent;
//              uint NumModels { get { return _numModels; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              MagicavoxelVox.Chunk M_Parent { get { return m_parent; } }
//         }
//           class Matt
//         {
//              static Matt FromFile(string fileName)
//             {
//                 return new Matt(new KaitaiStream(fileName));
//             }

//              Matt(KaitaiStream p__io, MagicavoxelVox.Chunk p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 f_hasIsTotalPower = false;
//                 f_hasPlastic = false;
//                 f_hasAttenuation = false;
//                 f_hasPower = false;
//                 f_hasRoughness = false;
//                 f_hasSpecular = false;
//                 f_hasIor = false;
//                 f_hasGlow = false;
//                 _read();
//             }
//              void _read()
//             {
//                 _id = m_io.ReadU4le();
//                 _materialType = ((MagicavoxelVox.MaterialType) m_io.ReadU4le());
//                 _materialWeight = m_io.ReadF4le();
//                 _propertyBits = m_io.ReadU4le();
//                 if (HasPlastic) {
//                     _plastic = m_io.ReadF4le();
//                 }
//                 if (HasRoughness) {
//                     _roughness = m_io.ReadF4le();
//                 }
//                 if (HasSpecular) {
//                     _specular = m_io.ReadF4le();
//                 }
//                 if (HasIor) {
//                     _ior = m_io.ReadF4le();
//                 }
//                 if (HasAttenuation) {
//                     _attenuation = m_io.ReadF4le();
//                 }
//                 if (HasPower) {
//                     _power = m_io.ReadF4le();
//                 }
//                 if (HasGlow) {
//                     _glow = m_io.ReadF4le();
//                 }
//                 if (HasIsTotalPower) {
//                     _isTotalPower = m_io.ReadF4le();
//                 }
//             }
//              bool f_hasIsTotalPower;
//              bool _hasIsTotalPower;
//              bool HasIsTotalPower
//             {
//                 get
//                 {
//                     if (f_hasIsTotalPower)
//                         return _hasIsTotalPower;
//                     _hasIsTotalPower = (bool) ((PropertyBits & 128) != 0);
//                     f_hasIsTotalPower = true;
//                     return _hasIsTotalPower;
//                 }
//             }
//              bool f_hasPlastic;
//              bool _hasPlastic;
//              bool HasPlastic
//             {
//                 get
//                 {
//                     if (f_hasPlastic)
//                         return _hasPlastic;
//                     _hasPlastic = (bool) ((PropertyBits & 1) != 0);
//                     f_hasPlastic = true;
//                     return _hasPlastic;
//                 }
//             }
//              bool f_hasAttenuation;
//              bool _hasAttenuation;
//              bool HasAttenuation
//             {
//                 get
//                 {
//                     if (f_hasAttenuation)
//                         return _hasAttenuation;
//                     _hasAttenuation = (bool) ((PropertyBits & 16) != 0);
//                     f_hasAttenuation = true;
//                     return _hasAttenuation;
//                 }
//             }
//              bool f_hasPower;
//              bool _hasPower;
//              bool HasPower
//             {
//                 get
//                 {
//                     if (f_hasPower)
//                         return _hasPower;
//                     _hasPower = (bool) ((PropertyBits & 32) != 0);
//                     f_hasPower = true;
//                     return _hasPower;
//                 }
//             }
//              bool f_hasRoughness;
//              bool _hasRoughness;
//              bool HasRoughness
//             {
//                 get
//                 {
//                     if (f_hasRoughness)
//                         return _hasRoughness;
//                     _hasRoughness = (bool) ((PropertyBits & 2) != 0);
//                     f_hasRoughness = true;
//                     return _hasRoughness;
//                 }
//             }
//              bool f_hasSpecular;
//              bool _hasSpecular;
//              bool HasSpecular
//             {
//                 get
//                 {
//                     if (f_hasSpecular)
//                         return _hasSpecular;
//                     _hasSpecular = (bool) ((PropertyBits & 4) != 0);
//                     f_hasSpecular = true;
//                     return _hasSpecular;
//                 }
//             }
//              bool f_hasIor;
//              bool _hasIor;
//              bool HasIor
//             {
//                 get
//                 {
//                     if (f_hasIor)
//                         return _hasIor;
//                     _hasIor = (bool) ((PropertyBits & 8) != 0);
//                     f_hasIor = true;
//                     return _hasIor;
//                 }
//             }
//              bool f_hasGlow;
//              bool _hasGlow;
//              bool HasGlow
//             {
//                 get
//                 {
//                     if (f_hasGlow)
//                         return _hasGlow;
//                     _hasGlow = (bool) ((PropertyBits & 64) != 0);
//                     f_hasGlow = true;
//                     return _hasGlow;
//                 }
//             }
//              uint _id;
//              MaterialType _materialType;
//              float _materialWeight;
//              uint _propertyBits;
//              float? _plastic;
//              float? _roughness;
//              float? _specular;
//              float? _ior;
//              float? _attenuation;
//              float? _power;
//              float? _glow;
//              float? _isTotalPower;
//              MagicavoxelVox m_root;
//              MagicavoxelVox.Chunk m_parent;
//              uint Id { get { return _id; } }
//              MaterialType MaterialType { get { return _materialType; } }
//              float MaterialWeight { get { return _materialWeight; } }
//              uint PropertyBits { get { return _propertyBits; } }
//              float? Plastic { get { return _plastic; } }
//              float? Roughness { get { return _roughness; } }
//              float? Specular { get { return _specular; } }
//              float? Ior { get { return _ior; } }
//              float? Attenuation { get { return _attenuation; } }
//              float? Power { get { return _power; } }
//              float? Glow { get { return _glow; } }
//              float? IsTotalPower { get { return _isTotalPower; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              MagicavoxelVox.Chunk M_Parent { get { return m_parent; } }
//         }
         

       
//          Uint8List _magic;
//          uint _version;
//          Chunk _main;
//          MagicavoxelVox m_root;
//          KaitaiStruct m_parent;
//          Uint8List Magic { get { return _magic; } }

//         /// <summary>
//         /// 150 expected
//         /// </summary>
//          uint Version { get { return _version; } }
//          Chunk Main { get { return _main; } }
//          MagicavoxelVox M_Root { get { return m_root; } }
//          KaitaiStruct M_Parent { get { return m_parent; } }
//     }
//    class Voxel
//         {
//              static Voxel FromFile(String fileName)
//             {
//                 return new Voxel(new KaitaiStream(fileName));
//             }

//              Voxel(KaitaiStream p__io, MagicavoxelVox.Xyzi p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 _read();
//             }
//              void _read()
//             {
//                 _x = m_io.ReadU1();
//                 _y = m_io.ReadU1();
//                 _z = m_io.ReadU1();
//                 _colorIndex = m_io.ReadU1();
//             }
//              int _x;
//              int _y;
//              int _z;
//              int _colorIndex;
//              MagicavoxelVox m_root;
//              MagicavoxelVox.Xyzi m_parent;
//              int X { get { return _x; } }
//              int Y { get { return _y; } }
//              int Z { get { return _z; } }
//              int ColorIndex { get { return _colorIndex; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              MagicavoxelVox.Xyzi M_Parent { get { return m_parent; } }
//         }
//                   class Color
//         {
//              static Color FromFile(string fileName)
//             {
//                 return new Color(new KaitaiStream(fileName));
//             }

//              Color(KaitaiStream p__io, MagicavoxelVox.Rgba p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 _read();
//             }
//              void _read()
//             {
//                 _r = m_io.ReadU1();
//                 _g = m_io.ReadU1();
//                 _b = m_io.ReadU1();
//                 _a = m_io.ReadU1();
//             }
//              int _r;
//              int _g;
//              int _b;
//              int _a;
//              MagicavoxelVox m_root;
//              MagicavoxelVox.Rgba m_parent;
//              int R { get { return _r; } }
//              int G { get { return _g; } }
//              int B { get { return _b; } }
//              int A { get { return _a; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              MagicavoxelVox.Rgba M_Parent { get { return m_parent; } }
//         }
//          class Xyzi
//         {
//              static Xyzi FromFile(string fileName)
//             {
//                 return new Xyzi(new KaitaiStream(fileName));
//             }

//              Xyzi(KaitaiStream p__io, MagicavoxelVox.Chunk p__parent = null, MagicavoxelVox p__root = null) : base(p__io)
//             {
//                 m_parent = p__parent;
//                 m_root = p__root;
//                 _read();
//             }
//              void _read()
//             {
//                 _numVoxels = m_io.ReadU4le();
//                 _voxels = new List<Voxel>((int) (NumVoxels));
//                 for (var i = 0; i < NumVoxels; i++)
//                 {
//                     _voxels.Add(new Voxel(m_io, this, m_root));
//                 }
//             }
//              uint _numVoxels;
//              List<Voxel> _voxels;
//              MagicavoxelVox m_root;
//              MagicavoxelVox.Chunk m_parent;
//              uint NumVoxels { get { return _numVoxels; } }
//              List<Voxel> Voxels { get { return _voxels; } }
//              MagicavoxelVox M_Root { get { return m_root; } }
//              MagicavoxelVox.Chunk M_Parent { get { return m_parent; } }
//         }