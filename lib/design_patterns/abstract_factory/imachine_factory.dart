import 'package:flutter/material.dart';

import '../../enum/player.dart';
import '../../model/tile_position.dart';

abstract class IMachineFactory {
  TilePosition getPosition();
  Widget getAsset();
  Player getPlayer();
  String getName();
  int getCombatPower();
  int getMovementRange();
  int getHealth();
}
