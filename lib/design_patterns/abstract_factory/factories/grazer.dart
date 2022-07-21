import 'package:flutter/widgets.dart';

import '../../../config/machines_asset_config.dart';
import '../../../enum/player.dart';
import '../../../model/tile_position.dart';
import '../imachine_factory.dart';

class Grazer implements IMachineFactory {
  final Player player;
  late Widget asset;
  late TilePosition position;

  Grazer(
    this.player,
    int x,
    int y,
  ) {
    position = TilePosition(x, y);
    asset = MachineFromAsset.grazer;
  }

  @override
  Widget getAsset() {
    return asset;
  }

  @override
  Player getPlayer() {
    return player;
  }

  @override
  TilePosition getPosition() {
    return position;
  }

  @override
  String getName() {
    return 'Grazer';
  }

  @override
  int getCombatPower() {
    return 4;
  }

  @override
  int getHealth() {
    return 8;
  }

  @override
  int getMovementRange() {
    return 4;
  }
}
