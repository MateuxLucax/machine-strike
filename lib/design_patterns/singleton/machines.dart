import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../../model/machine.dart';
import '../abstract_factory/factories/csv_xml_game_factory.dart';
import '../abstract_factory/factories/json_game_factory.dart';
import '../abstract_factory/igame_factory.dart';

class Machines {
  static final Machines _singleton = Machines._internal();

  factory Machines() {
    return _singleton;
  }

  Machines._internal();

  final List<Machine> machines = [];

  final Map<String, IGameFactory> factories = {
    'json': JsonGameFactory(),
    'xml': CsvXmlGameFactory(),
  };

  Future<void> loadMachines() async {
    final Map<String, dynamic> assets =
        jsonDecode(await rootBundle.loadString('AssetManifest.json'));

    for (var asset in assets.entries) {
      if (asset.key.contains('assets/config/machines/')) {
        final type = asset.key.split('.').last;
        final factory = factories[type];
        if (factory != null) {
          machines.add(await factory.getMachine(asset.key));
        }
      }
    }
  }

  Machine get(int index) {
    return machines[index];
  }

  Machine random() {
    return get(Random().nextInt(machines.length));
  }
}
