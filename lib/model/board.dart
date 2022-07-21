import 'machine.dart';
import 'tile.dart';

class Board {
  late List<List<Tile>> tiles;
  late List<Machine> machines;

  Board({
    required this.tiles,
    this.machines = const [],
  });
}
