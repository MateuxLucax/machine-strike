import 'package:flutter/widgets.dart';

import '../../../config/machines_asset_config.dart';
import '../../../enum/player.dart';
import '../../../model/tile_position.dart';
import '../imachine_factory.dart';

class Charger implements IMachineFactory {
  final Player player;
  late Widget asset;
  late TilePosition position;

  Charger(
    this.player,
    int x,
    int y,
  ) {
    position = TilePosition(x, y);
    asset = MachineFromAsset.charger;
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
    return 'Charger';
  }

  @override
  int getCombatPower() {
    return 10;
  }

  @override
  int getHealth() {
    return 5;
  }

  @override
  int getMovementRange() {
    return 6;
  }
}
