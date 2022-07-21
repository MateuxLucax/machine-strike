import 'package:flutter/widgets.dart';

import '../../../config/machines_asset_config.dart';
import '../../../enum/player.dart';
import '../../../model/tile_position.dart';
import '../imachine_factory.dart';

class Burrower implements IMachineFactory {
  final Player player;
  late Widget asset;
  late TilePosition position;

  Burrower(
    this.player,
    int x,
    int y,
  ) {
    position = TilePosition(x, y);
    asset = MachineFromAsset.burrower;
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
    return 'Burrower';
  }

  @override
  int getCombatPower() {
    return 2;
  }

  @override
  int getHealth() {
    return 80;
  }

  @override
  int getMovementRange() {
    return 1;
  }
}
