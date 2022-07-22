import 'package:flutter/material.dart';

class Terrain {
  final String name;
  final int combatPowerOffset;
  final Widget asset;

  Terrain({
    required this.name,
    required this.combatPowerOffset,
    required this.asset,
  });
}
