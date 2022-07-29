import '../../model/tile_position.dart';

class Cursor {
  TilePosition position = TilePosition(0, 0);

  static final Cursor _instance = Cursor._internal();

  factory Cursor() {
    return _instance;
  }

  Cursor._internal();

  int get row => position.row;

  int get col => position.col;
}
