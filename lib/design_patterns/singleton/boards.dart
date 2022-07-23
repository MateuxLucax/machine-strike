import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../../model/board.dart';
import '../adapter/adapters/csv_tiles_adapter.dart';
import '../adapter/adapters/json_tiles_adapter.dart';
import '../adapter/itiles_adapter.dart';

class Boards {
  static final Boards _singleton = Boards._internal();

  factory Boards() {
    return _singleton;
  }

  Boards._internal();

  final List<Board> boards = [];

  final Map<String, ITilesAdapter> adapters = {
    'json': JsonTilesAdapter(),
    'csv': CsvTilesAdapter(),
  };

  Future<void> loadBoards() async {
    final Map<String, dynamic> assets = jsonDecode(await rootBundle.loadString('AssetManifest.json'));

    for (var asset in assets.entries) {
      if (asset.key.contains('assets/configs/boards/')) {
        final type = asset.key.split('.').last;
        final adapter = adapters[type];
        if (adapter != null) {
          boards.add(Board(tiles: await adapter.getTiles(asset.key)));
        }
      }
    }
  }

  Board get(int index) {
    return boards[index];
  }

  Board random() {
    return get(Random().nextInt(boards.length));
  }
}
