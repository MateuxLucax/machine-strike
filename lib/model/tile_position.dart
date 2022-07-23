import 'dart:ui';

import '../config/game_config.dart';

class TilePosition {
  int x;
  int y;

  TilePosition(this.x, this.y);

  TilePosition copyWith({int? x, int? y}) {
    return TilePosition(x ?? this.x, y ?? this.y);
  }

  move({int? x, int? y}) {
    this.x = x != null && _respectLimits((this.x + (x))) ? (this.x + (x)) : this.x;
    this.y = y != null && _respectLimits((this.y + (y))) ? (this.y + (y)) : this.y;
  }

  bool _respectLimits(int val) => !val.isNegative && val < GameConst.size;

  @override
  operator ==(other) => other is TilePosition && other.x == x && other.y == y;

  @override
  int get hashCode => hashValues('$x-', y);

  @override
  String toString() {
    return '[$x][$y]';
  }
}
