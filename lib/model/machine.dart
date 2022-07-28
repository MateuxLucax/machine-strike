import 'package:flutter/material.dart';

import '../enum/direction.dart';
import '../enum/player.dart';
import 'tile_position.dart';

class Machine {
  final TilePosition position;
  final Player player;
  final String name;
  final int combatPower;
  final int movementRange;
  final int attackRange;
  final Widget image;
  final int victoryPoints;
  int health;
  Direction direction;
  bool alreadyAttacked = false;
  bool alreadyMoved = false;

  Machine({
    required this.position,
    required this.direction,
    required this.player,
    required this.name,
    required this.combatPower,
    required this.movementRange,
    required this.attackRange,
    required this.health,
    required this.image,
    required this.victoryPoints,
  });

  Widget getAsset() {
    return AnimatedRotation(
      key: image.key,
      turns: direction.value,
      duration: const Duration(milliseconds: 150),
      child: image,
    );
  }

  void updateDirection(Direction direction) {
    this.direction = direction;
  }

  void updateAlreadyAttacked(bool alreadyAttacked) {
    this.alreadyAttacked = alreadyAttacked;
  }

  void updateAlreadyMoved(bool alreadyMoved) {
    this.alreadyMoved = alreadyMoved;
  }

  void receiveAttack(int attack) {
    health -= attack;
  }

  bool get dead => health <= 0;

  @override
  operator ==(other) =>
      other is Machine &&
      other.name == name &&
      other.position == position &&
      other.player == player;

  @override
  int get hashCode => hashValues(name, position, player);
}
