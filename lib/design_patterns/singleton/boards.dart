import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../../model/board.dart';
import '../abstract_factory/factories/csv_xml_game_factory.dart';
import '../abstract_factory/factories/json_game_factory.dart';
import '../abstract_factory/igame_factory.dart';

class Boards {
  static final Boards _singleton = Boards._internal();

  factory Boards() {
    return _singleton;
  }

  Boards._internal();

  final List<Board> boards = [];

  final Map<String, IGameFactory> factories = {
    'json': JsonGameFactory(),
    'csv': CsvXmlGameFactory(),
  };

  Future<void> loadBoards() async {
    final Map<String, dynamic> assets =
        jsonDecode(await rootBundle.loadString('AssetManifest.json'));

    for (var asset in assets.entries) {
      if (asset.key.contains('assets/configs/boards/')) {
        final type = asset.key.split('.').last;
        final factory = factories[type];
        if (factory != null) {
          boards.add(Board(await factory.getTiles(asset.value)));
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
