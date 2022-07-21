import 'dart:math';

import '../../model/board.dart';
import '../adapter/itiles_adapter.dart';

class Boards {
  static final Boards _singleton = Boards._internal();

  factory Boards() {
    return _singleton;
  }

  Boards._internal();

  final List<Board> boards = [];

  Future<void> loadBoards(ITilesAdapter adapter) async {
    const folder = 'assets/configs/boards';

    boards.addAll([
      Board(tiles: await adapter.getTiles('$folder/chasm-only.json')),
      Board(tiles: await adapter.getTiles('$folder/fedora.json')),
    ]);
  }

  Board get(int index) {
    return boards[index];
  }

  Board random() {
    return boards[Random().nextInt(boards.length)];
  }
}
