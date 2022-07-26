import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../config/machine_from_config.dart';
import '../../../enum/player.dart';
import '../../../model/machine.dart';
import '../../../model/tile_position.dart';
import '../imachine_adapter.dart';

class JsonMachineAdapter implements IMachineAdapter {
  Future<Map<dynamic, dynamic>> _getJsonConfig(String file) async {
    return jsonDecode(await rootBundle.loadString(file));
  }

  @override
  Future<Machine> getMachine(String file) async {
    final Map<dynamic, dynamic> json = await _getJsonConfig(file);

    final info = MachineInfo(
      combatPower: json['combatPower'] as int,
      health: json['health'] as int,
      movementRange: json['movementRange'] as int,
      attackRange: json['attackRange'] as int,
      player: Player.fromId(json['player'] as int),
      position: TilePosition(
        json['row'] as int,
        json['col'] as int,
      ),
    );

    return MachineFromConfig(json['name']).get(info);
  }
}
