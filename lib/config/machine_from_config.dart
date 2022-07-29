import 'package:flutter/widgets.dart';

import '../enum/direction.dart';
import '../enum/player.dart';
import '../model/machine.dart';
import '../model/tile_position.dart';

class MachineInfo {
  final TilePosition position;
  final Player player;
  final int combatPower;
  final int movementRange;
  final int attackRange;
  final int health;
  final int victoryPoints;

  MachineInfo({
    required this.position,
    required this.player,
    required this.combatPower,
    required this.movementRange,
    required this.attackRange,
    required this.health,
    required this.victoryPoints,
  });
}

class MachineFromConfig {
  String config;

  MachineFromConfig(this.config);

  Machine get(MachineInfo info) {
    try {
      MachineConfig machineConfig = MachineConfig.fromId(config);

      return Machine(
        position: info.position,
        direction: info.player == Player.one ? Direction.south : Direction.north,
        player: info.player,
        name: machineConfig.getName(),
        combatPower: info.combatPower,
        movementRange: info.movementRange,
        attackRange: info.attackRange,
        health: info.health,
        victoryPoints: info.victoryPoints,
        image: Image.asset(
          machineConfig.getAsset(),
          fit: BoxFit.fill,
          key: Key(machineConfig.getName() + info.position.toString()),
        ),
      );
    } catch (_) {
      rethrow;
    }
  }

  static Image _fromAsset(String asset) {
    return Image.asset(
      asset,
      key: Key(asset),
      fit: BoxFit.fill,
    );
  }

  static final bristleback = _fromAsset(MachineAssets.bristleback);
  static final burrower = _fromAsset(MachineAssets.burrower);
  static final charger = _fromAsset(MachineAssets.charger);
  static final grazer = _fromAsset(MachineAssets.grazer);
  static final lancehorn = _fromAsset(MachineAssets.lancehorn);
  static final longleg = _fromAsset(MachineAssets.longleg);
  static final plowhorn = _fromAsset(MachineAssets.plowhorn);
  static final scrapper = _fromAsset(MachineAssets.scrapper);
  static final skydrifter = _fromAsset(MachineAssets.skydrifter);
}

class MachineAssets {
  static const _folder = 'assets/images/machines';
  static const bristleback = '$_folder/bristleback.png';
  static const burrower = '$_folder/burrower.png';
  static const charger = '$_folder/charger.png';
  static const grazer = '$_folder/grazer.png';
  static const lancehorn = '$_folder/lancehorn.png';
  static const longleg = '$_folder/longleg.png';
  static const plowhorn = '$_folder/plowhorn.png';
  static const scrapper = '$_folder/scrapper.png';
  static const skydrifter = '$_folder/skydrifter.png';
}

enum MachineConfig {
  bristleback,
  burrower,
  charger,
  grazer,
  lancehorn,
  longleg,
  plowhorn,
  scrapper,
  skydrifter;

  factory MachineConfig.fromId(String value) {
    return values.firstWhere((e) => e.name == value);
  }

  String getAsset() {
    switch (this) {
      case bristleback:
        return MachineAssets.bristleback;
      case burrower:
        return MachineAssets.burrower;
      case charger:
        return MachineAssets.charger;
      case grazer:
        return MachineAssets.grazer;
      case lancehorn:
        return MachineAssets.lancehorn;
      case longleg:
        return MachineAssets.longleg;
      case plowhorn:
        return MachineAssets.plowhorn;
      case scrapper:
        return MachineAssets.scrapper;
      case skydrifter:
        return MachineAssets.skydrifter;
    }
  }

  String getName() {
    return '${toString().split('.').last[0].toUpperCase()}${toString().split('.').last.substring(1).toLowerCase()}';
  }
}
