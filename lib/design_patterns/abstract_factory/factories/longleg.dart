import 'package:flutter/widgets.dart';

import '../../../config/machines_asset_config.dart';
import '../../../enum/player.dart';
import '../../../model/tile_position.dart';
import '../imachine_factory.dart';

class Longleg implements IMachineFactory {
  final Player player;
  late Widget asset;
  late TilePosition position;

  Longleg(
    this.player,
    int x,
    int y,
  ) {
    position = TilePosition(x, y);
    asset = MachineFromAsset.longleg;
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
    return 'Longleg';
  }

  @override
  int getCombatPower() {
    return 5;
  }

  @override
  int getHealth() {
    return 5;
  }

  @override
  int getMovementRange() {
    return 5;
  }
}
