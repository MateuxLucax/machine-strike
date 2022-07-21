import 'package:flutter/widgets.dart';
import 'package:machinestrike/enum/player.dart';
import 'package:machinestrike/model/tile_position.dart';

class Machine {
  final Widget asset;
  final Player player;
  final TilePosition position;

  Machine({
    required this.asset,
    required this.player,
    required this.position,
  });
}
