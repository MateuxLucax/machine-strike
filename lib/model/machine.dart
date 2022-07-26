import 'package:flutter/widgets.dart';
import 'package:machinestrike/enum/direction.dart';
import 'package:machinestrike/enum/player.dart';
import 'package:machinestrike/model/tile_position.dart';

class Machine {
  final TilePosition position;
  final Direction direction;
  final Player player;
  final String name;
  final int combatPower;
  final int movementRange;
  final int health;
  final Widget image;

  Machine({
    required this.position,
    required this.direction,
    required this.player,
    required this.name,
    required this.combatPower,
    required this.movementRange,
    required this.health,
    required this.image,
  });

  Widget getAsset() {
    return RotatedBox(
      quarterTurns: direction.value,
      child: image,
    );
  }
}
