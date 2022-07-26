import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:machinestrike/design_patterns/decorator/tile/unreachable_decorator.dart';
import 'package:machinestrike/design_patterns/decorator/tile/reachable_tile_decorator.dart';
import 'package:machinestrike/enum/reachability.dart';

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
  Tile get currentTile => board.tiles[cursor.row][cursor.col];

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
    final tile = selectedTile;

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.keyA || key == LogicalKeyboardKey.arrowLeft) {
      cursor.move(col: -1);
    } else if (key == LogicalKeyboardKey.keyD || key == LogicalKeyboardKey.arrowRight) {
      cursor.move(col: 1);
    } else if (key == LogicalKeyboardKey.keyS || key == LogicalKeyboardKey.arrowDown) {
      cursor.move(row: 1);
    } else if (key == LogicalKeyboardKey.keyW || key == LogicalKeyboardKey.arrowUp) {
      cursor.move(row: -1);
    } else if (key == LogicalKeyboardKey.escape) {
      _reset();
      _callUpdateTiles();
      _callUpdateCursor();
    } else if (key == LogicalKeyboardKey.enter) {
      if (tile == null && currentTile.hasMachine) {
        selectedTile = currentTile;
        _reachablePieces(currentTile);
      } else if (tile != null && !currentTile.hasMachine) {
        _reset(tile: tile);
      }
      _callUpdateTiles();
      _callUpdateCursor();
    } else if (key == LogicalKeyboardKey.keyF && tile != null) {
      print('attack');
    }

    final reachable = tiles[cursor.row][cursor.col].reachability;

    if (reachable == null || reachable == Reachability.reachable) {
      if (initialPosition != cursor) {
        _callUpdateCursor();
      }
    } else {
      cursor = initialPosition;
    }
  }

  void _reachablePieces(Tile selectedTile) {
    final position = selectedTile.position;
    final movementRange = selectedTile.machine?.getMovementRange() ?? 0;

    for (var row in tiles) {
      for (var col in row) {
        final colPos = col.position;
        final dist = (position.row - colPos.row).abs() + (position.col - colPos.col).abs();
        if (dist > movementRange || col.hasMachine) {
          col.updateReachability(Reachability.unreachable);
        } else {
          col.updateReachability(Reachability.reachable);
        }
      }
    }
  }

  void _callUpdateCursor() {
    for (var observer in cursorObservers) {
      observer.updateCursor(cursor, currentTile);
    }
  }

  void _callUpdateTiles() {
    for (var observer in tilesObserver) {
      observer.update(tiles);
    }
  }

  void _reset({Tile? tile}) {
    if (tile != null) {
      currentTile.addMachine(tile.machine!);
      board.tiles[tile.position.row][tile.position.col].unsetMachine();
    }

    selectedTile = null;
    for (var row in tiles) {
      for (var col in row) {
        col.updateReachability(null);
      }
    }
  }
}
