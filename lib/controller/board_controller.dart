import 'package:flutter/services.dart';

import '../design_patterns/observer/cursor_observer.dart';
import '../design_patterns/observer/update_tiles_observer.dart';
import '../enum/direction.dart';
import '../enum/reachability.dart';
import '../model/board.dart';
import '../model/tile.dart';
import '../model/tile_position.dart';

abstract class IBoardController {
  Tile get currentTile;

  List<List<Tile>> get tiles;

  void attachCursorObserver(CursorObserver observer);

  void attachTilesObserver(UpdateTilesObserver observer);

  void handleKeyStroke(RawKeyEvent event);
}

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
      print('curr $currentTile');
      Tile? attack;
      final pos = currentTile.position;
      switch (tile.machine!.direction) {
        case Direction.north:
          final a = tiles[pos.row][(pos.col + 1)];
          if (a.hasMachine) {
            attack = a;
          }
          break;
        case Direction.east:
          final a = tiles[(pos.row + 1)][pos.col];
          if (a.hasMachine) {
            attack = a;
          }
          break;
        case Direction.south:
          final a = tiles[pos.row][(pos.col - 1)];
          if (a.hasMachine) {
            attack = a;
          }
          break;
        case Direction.west:
          final a = tiles[(pos.row - 1)][pos.col];
          if (a.hasMachine) {
            attack = a;
          }
          break;
        default:
          break;
      }

      print('attack $attack');
    } else if (key == LogicalKeyboardKey.keyQ && tile != null) {
      if (tile.hasMachine) {
        tile.machine!.updateDirection(tile.machine!.direction.previous());
        tile.updateMachine();
      }
      _callUpdateTiles();
    } else if (key == LogicalKeyboardKey.keyE && tile != null) {
      if (tile.hasMachine) {
        tile.machine!.updateDirection(tile.machine!.direction.next());
        tile.updateMachine();
      }
      _callUpdateTiles();
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
    final movementRange = selectedTile.machine?.movementRange ?? 0;

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

  void _attackRange() {
    print('curr $currentTile');
    Tile? attack;
    final pos = selectedTile!.machine!.position;
    switch (selectedTile!.machine!.direction) {
      case Direction.north:
        final a = tiles[pos.row][(pos.col + 1)];
        if (a.hasMachine) {
          a.updateInAttackRange(true);
        }
        break;
      case Direction.east:
        final a = tiles[(pos.row + 1)][pos.col];
        if (a.hasMachine) {
          a.updateInAttackRange(true);
        }
        break;
      case Direction.south:
        final a = tiles[pos.row][(pos.col - 1)];
        if (a.hasMachine) {
          a.updateInAttackRange(true);
        }
        break;
      case Direction.west:
        final a = tiles[(pos.row - 1)][pos.col];
        if (a.hasMachine) {
          a.updateInAttackRange(true);
        }
        break;
      default:
        break;
    }

    print('attack $attack');
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
        col.updateInAttackRange(false);
      }
    }
  }
}
