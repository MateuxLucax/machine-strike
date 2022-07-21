import 'package:flutter/material.dart';

class TilePosition {
  int x;
  int y;

  TilePosition(this.x, this.y);

  move({int? x, int? y}) {
    this.y = y != null ? (this.y + (y)) : this.y;
    this.x = x != null ? (this.x + (x)) : this.x;
  }

  @override
  operator ==(other) => other is TilePosition && other.x == x && other.y == y;

  @override
  int get hashCode => hashValues('$x-', y);

  @override
  String toString() {
    return '[$x][$y]';
  }
}
