import 'chunk/voxRootChunk.dart';
import 'mat/voxMaterial.dart';
import 'vox_model_instance.dart';

class VoxFile {
  final int version;
  final VoxRootChunk root;

  VoxFile(this.version, this.root);
  VoxRootChunk getRoot() {
    return root;
  }

  List<VoxModelInstance> getModelInstances() {
    return root.getModelInstances();
  }

  List<int> getPalette() {
    return root.getPalette();
  }

  Map<int, VoxMaterial> getMaterials() {
    return root.getMaterials();
  }

  int getVersion() {
    return version;
  }

  @override
  String toString() {
    return "VoxFile{version=" "$version" "}";
  }
}
