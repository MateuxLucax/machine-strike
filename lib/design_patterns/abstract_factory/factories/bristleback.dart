import 'package:flutter/widgets.dart';

import '../../../config/machines_asset_config.dart';
import '../../../enum/player.dart';
import '../../../model/tile_position.dart';
import '../imachine_factory.dart';

class Bristleback implements IMachineFactory {
  final Player player;
  late Widget asset;
  late TilePosition position;

  Bristleback(
    this.player,
    int x,
    int y,
  ) {
    position = TilePosition(x, y);
    asset = MachineFromAsset.bristleback;
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
    return 'Bristleback';
  }

  @override
  int getCombatPower() {
    return 4;
  }

  @override
  int getHealth() {
    return 16;
  }

  @override
  int getMovementRange() {
    return 2;
  }
}
