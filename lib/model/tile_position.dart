import 'dart:ui';

import '../config/game_const.dart';

class TilePosition {
  int row;
  int col;

  TilePosition(this.row, this.col);

  TilePosition copy() => TilePosition(row, col);

  void move({int? row, int? col}) {
    this.row = row != null && _respectLimits((this.row + (row))) ? (this.row + (row)) : this.row;
    this.col = col != null && _respectLimits((this.col + (col))) ? (this.col + (col)) : this.col;
  }

  bool _respectLimits(int val) => !val.isNegative && val < GameConst.size;

  @override
  operator ==(other) => other is TilePosition && other.row == row && other.col == col;

  @override
  int get hashCode => hashValues('$row-$col', col, row);

  @override
  String toString() {
    return '[$row][$col]';
  }

  String get description => '[${row + 1}][${col + 1}]';
}
