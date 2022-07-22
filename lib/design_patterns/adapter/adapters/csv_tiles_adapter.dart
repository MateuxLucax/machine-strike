import 'package:flutter/services.dart';

import '../../../config/game_config.dart';
import '../../../model/tile.dart';
import '../../../model/tile_position.dart';
import '../itiles_adapter.dart';
import '../terrain_from_config.dart';

class CsvTilesAdapter implements ITilesAdapter {
  Future<List<String>> _getFile(String file) async {
    return (await rootBundle.loadString(file)).split('\n');
  }

  @override
  Future<List<List<Tile>>> getTiles(String file) async {
    final rows = await _getFile(file);
    List<List<Tile>> tiles = [];

    for (var x = 0; x < GameConst.size; x++) {
      List<Tile> column = [];
      final elements = rows[x].split(',');
      for (var y = 0; y < GameConst.size; y++) {
        column.add(
          Tile(
            position: TilePosition(x, y),
            terrain: TerrainFromConfig(elements[y]).fromConfig(),
          ),
        );
      }
      tiles.add(column);
    }

    return tiles;
  }
}
