import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../config/game_config.dart';
import '../../../config/terrain_from_config.dart';
import '../../../model/terrain.dart';
import '../iterrain_adapter.dart';

class JsonTerrainAdapter implements ITerrainAdapter {
  Future<Map<dynamic, dynamic>> _getJsonConfig(String file) async {
    return jsonDecode(await rootBundle.loadString(file));
  }

  @override
  Future<List<List<Terrain>>> toList(String file) async {
    final json = await _getJsonConfig(file);
    final rows = json['terrains'] as List;
    List<List<Terrain>> list = [];

    for (var x = 0; x < GameConst.size; x++) {
      List<Terrain> column = [];
      for (var y = 0; y < GameConst.size; y++) {
        column.add(TerrainFromConfig(rows[x][y] as String).get());
      }
      list.add(column);
    }

    return list;
  }
}
