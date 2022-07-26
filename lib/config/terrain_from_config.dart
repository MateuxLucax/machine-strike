import 'package:flutter/widgets.dart';

import '../model/terrain.dart';

class TerrainFromConfig {
  final String config;

  TerrainFromConfig(this.config);

  Terrain get() {
    TerrainConfig terrainConfig = TerrainConfig.fromId(config);

    return Terrain(
      name: terrainConfig.getName(),
      combatPowerOffset: terrainConfig.getPowerOffset(),
      asset: Image.asset(
        terrainConfig.getAsset(),
        fit: BoxFit.fill,
      ),
    );
  }
}

enum TerrainConfig {
  chasm('ch'),
  forest('fo'),
  grassland('ga'),
  hill('hi'),
  marsh('ma'),
  mountain('mo');

  const TerrainConfig(this.value);
  final String value;

  factory TerrainConfig.fromId(String value) {
    return values.firstWhere((e) => e.value == value);
  }

  String getAsset() {
    switch (this) {
      case chasm:
        return TerrainAssetConfig.chasm;
      case forest:
        return TerrainAssetConfig.forest;
      case grassland:
        return TerrainAssetConfig.grassland;
      case hill:
        return TerrainAssetConfig.hill;
      case marsh:
        return TerrainAssetConfig.marsh;
      case mountain:
        return TerrainAssetConfig.mountain;
    }
  }

  int getPowerOffset() {
    switch (this) {
      case chasm:
        return -2;
      case forest:
        return 1;
      case grassland:
        return 0;
      case hill:
        return 2;
      case marsh:
        return -1;
      case mountain:
        return 3;
    }
  }

  String getName() {
    return '${toString().split('.').last[0].toUpperCase()}${toString().split('.').last.substring(1).toLowerCase()}';
  }
}

class TerrainAssetConfig {
  static const folder = 'assets/images/terrains';
  static const chasm = '$folder/chasm.png';
  static const forest = '$folder/forest.png';
  static const grassland = '$folder/grassland.png';
  static const hill = '$folder/hill.png';
  static const marsh = '$folder/marsh.png';
  static const mountain = '$folder/mountain.png';
}
