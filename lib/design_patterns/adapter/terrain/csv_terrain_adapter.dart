import 'package:flutter/services.dart';

import '../../../config/game_const.dart';
import '../../../config/terrain_from_config.dart';
import '../../../model/terrain.dart';
import '../iterrain_adapter.dart';

class CsvTerrainAdapter implements ITerrainAdapter {
  Future<List<String>> _getFile(String file) async {
    return (await rootBundle.loadString(file)).split('\n');
  }

  @override
  Future<List<List<Terrain>>> toList(String file) async {
    final rows = await _getFile(file);
    List<List<Terrain>> list = [];

    for (var x = 0; x < GameConst.size; x++) {
      List<Terrain> column = [];
      final elements = rows[x].split(',');
      for (var y = 0; y < GameConst.size; y++) {
        column.add(TerrainFromConfig(elements[y]).get());
      }
      list.add(column);
    }

    return list;
  }
}
