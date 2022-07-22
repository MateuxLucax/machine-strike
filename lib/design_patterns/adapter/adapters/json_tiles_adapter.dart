import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../config/game_config.dart';
import '../../../model/tile.dart';
import '../../../model/tile_position.dart';
import '../itiles_adapter.dart';
import '../terrain_from_config.dart';

class JsonTilesAdapter implements ITilesAdapter {
  Future<Map<dynamic, dynamic>> _getJsonConfig(String file) async {
    return jsonDecode(await rootBundle.loadString(file));
  }

  @override
  Future<List<List<Tile>>> getTiles(String file) async {
    final json = await _getJsonConfig(file);
    final rows = json['terrains'] as List;
    List<List<Tile>> tiles = [];

    for (var x = 0; x < GameConst.size; x++) {
      List<Tile> column = [];
      for (var y = 0; y < GameConst.size; y++) {
        column.add(
          Tile(
            position: TilePosition(x, y),
            terrain: TerrainFromConfig(rows[x][y] as String).fromConfig(),
          ),
        );
      }
      tiles.add(column);
    }

    return tiles;
  }
}
