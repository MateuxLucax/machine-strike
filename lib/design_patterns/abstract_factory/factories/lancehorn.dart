import 'package:flutter/widgets.dart';

import '../../../config/machines_asset_config.dart';
import '../../../enum/player.dart';
import '../../../model/tile_position.dart';
import '../imachine_factory.dart';

class Lancehorn implements IMachineFactory {
  final Player player;
  late Widget asset;
  late TilePosition position;

  Lancehorn(
    this.player,
    int x,
    int y,
  ) {
    position = TilePosition(x, y);
    asset = MachineFromAsset.lancehorn;
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
    return 'Lancehorn';
  }

  @override
  int getCombatPower() {
    return 2;
  }

  @override
  int getHealth() {
    return 12;
  }

  @override
  int getMovementRange() {
    return 2;
  }
}
