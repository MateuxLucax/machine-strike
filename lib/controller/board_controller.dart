import 'package:flutter/services.dart';

import '../design_patterns/observer/cursor_observer.dart';
import '../design_patterns/observer/update_tiles_observer.dart';
import '../model/board.dart';
import '../model/tile.dart';
import '../model/tile_position.dart';
import 'iboard_controller.dart';

class BoardController implements IBoardController {
  final Board board;
  final List<CursorObserver> cursorObservers = [];
  final List<UpdateTilesObserver> tilesObserver = [];
  TilePosition cursor = TilePosition(0, 0);
  Tile? selectedTile;

  BoardController(this.board);

  @override
  Tile get currentTile => board.tiles[cursor.x][cursor.y];

  @override
  List<List<Tile>> get tiles => board.tiles;

  @override
  void attachCursorObserver(CursorObserver observer) {
    cursorObservers.add(observer);
  }

  @override
  void attachTilesObserver(UpdateTilesObserver observer) {
    tilesObserver.add(observer);
  }

  @override
  void handleKeyStroke(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;
    final initialPosition = cursor.copyWith();

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.keyA || key == LogicalKeyboardKey.arrowLeft) {
      cursor.move(y: -1);
    } else if (key == LogicalKeyboardKey.keyD || key == LogicalKeyboardKey.arrowRight) {
      cursor.move(y: 1);
    } else if (key == LogicalKeyboardKey.keyS || key == LogicalKeyboardKey.arrowDown) {
      cursor.move(x: 1);
    } else if (key == LogicalKeyboardKey.keyW || key == LogicalKeyboardKey.arrowUp) {
      cursor.move(x: -1);
    } else if (key == LogicalKeyboardKey.escape) {
      selectedTile = null;
    } else if (key == LogicalKeyboardKey.enter) {
      final tile = selectedTile;
      if (tile == null && currentTile.hasMachine) {
        selectedTile = currentTile;
      } else if (tile != null && !currentTile.hasMachine) {
        currentTile.addMachine(tile.machine!);
        board.tiles[tile.position.x][tile.position.y].unsetMachine();
        selectedTile = null;
        for (var observer in tilesObserver) {
          observer.update(tiles);
        }
      }
    }

    if (initialPosition != cursor) {
      for (var observer in cursorObservers) {
        observer.updateCursor(cursor, currentTile);
      }
    }
  }
}
