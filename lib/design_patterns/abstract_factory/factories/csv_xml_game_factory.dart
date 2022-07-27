import '../../../config/game_config.dart';
import '../../../model/machine.dart';
import '../../../model/tile.dart';
import '../../../model/tile_position.dart';
import '../../adapter/imachine_adapter.dart';
import '../../adapter/iterrain_adapter.dart';
import '../../adapter/machine/xml_machine_adapter.dart';
import '../../adapter/terrain/csv_terrain_adapter.dart';
import '../../decorator/tile/base_tile_stack.dart';
import '../igame_factory.dart';

class CsvXmlGameFactory implements IGameFactory {
  final ITerrainAdapter terrainAdapter = CsvTerrainAdapter();
  final IMachineAdapter machineAdapter = XmlMachineAdapter();

  @override
  Future<Machine> getMachine(String file) async {
    return await machineAdapter.getMachine(file);
  }

  @override
  Future<List<List<Tile>>> getTiles(String file) async {
    List<List<Tile>> tiles = [];
    final terrains = await terrainAdapter.toList(file);

    for (var x = 0; x < GameConst.size; x++) {
      List<Tile> column = [];
      for (var y = 0; y < GameConst.size; y++) {
        column.add(
          Tile(
            position: TilePosition(x, y),
            terrain: terrains[x][y],
            tileStack: BaseTileStack(terrains[x][y].asset),
          ),
        );
      }
      tiles.add(column);
    }

    return tiles;
  }
}
