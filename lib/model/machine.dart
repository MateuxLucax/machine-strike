import 'package:flutter/widgets.dart';
import 'package:machinestrike/enum/direction.dart';
import 'package:machinestrike/enum/player.dart';
import 'package:machinestrike/model/tile_position.dart';

class Machine {
  final TilePosition position;
  final Player player;
  final String name;
  final int combatPower;
  final int movementRange;
  final int health;
  final Widget image;
  Direction direction;

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
    print('assetDirection $direction');
    return RotatedBox(
      key: image.key,
      quarterTurns: direction.value,
      child: image,
    );
  }

  void updateDirection(Direction direction) {
    this.direction = direction;
  }
}
