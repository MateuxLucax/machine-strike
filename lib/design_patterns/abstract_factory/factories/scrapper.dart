import 'package:flutter/widgets.dart';

import '../../../config/machines_asset_config.dart';
import '../../../enum/player.dart';
import '../../../model/tile_position.dart';
import '../imachine_factory.dart';

class Scrapper implements IMachineFactory {
  final Player player;
  late Widget asset;
  late TilePosition position;

  Scrapper(
    this.player,
    int x,
    int y,
  ) {
    position = TilePosition(x, y);
    asset = MachineFromAsset.scrapper;
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
    return 'Scrapper';
  }

  @override
  int getCombatPower() {
    return 1;
  }

  @override
  int getHealth() {
    return 30;
  }

  @override
  int getMovementRange() {
    return 1;
  }
}
