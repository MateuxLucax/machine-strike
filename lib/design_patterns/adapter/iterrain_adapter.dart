import '../../model/terrain.dart';

abstract class ITerrainAdapter {
  Future<List<List<Terrain>>> toList(String file);
}
