import 'package:flutter/services.dart';

import '../design_patterns/observer/cursor_observer.dart';
import '../design_patterns/observer/update_tiles_observer.dart';
import '../enum/direction.dart';
import '../enum/player.dart';
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

  // get tilesInAttackRange {
  //   return board.tiles.where((row) => row.where((col) => col.inAttackRange)).toList();
  // }

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
    if (key == LogicalKeyboardKey.keyA) {
      cursor.move(col: -1);
    } else if (key == LogicalKeyboardKey.keyD) {
      cursor.move(col: 1);
    } else if (key == LogicalKeyboardKey.keyS) {
      cursor.move(row: 1);
    } else if (key == LogicalKeyboardKey.keyW) {
      cursor.move(row: -1);
    } else if (key == LogicalKeyboardKey.escape) {
      _reset();
      _callUpdateTiles();
      _callUpdateCursor();
    } else if (key == LogicalKeyboardKey.enter) {
      if (tile == null && currentTile.hasMachine) {
        selectedTile = currentTile;
        _reachablePieces(currentTile);
        _attackRange(selectedTile!);
      } else if (tile != null && !currentTile.hasMachine) {
        _reset(tile: tile);
      }
      _callUpdateTiles();
      _callUpdateCursor();
    } else if (key == LogicalKeyboardKey.keyK && tile != null) {
      final attack = tile.machine?.combatPower ?? 0 + (tile.terrain.combatPowerOffset);
      for (var row in tiles) {
        for (var col in row) {
          if (col.inAttackRange) {
            if (col.machine!.combatPower == tile.machine!.combatPower) {
              col.machine?.receiveAttack(1);
              tile.machine?.receiveAttack(1);
            } else if (col.machine!.combatPower > tile.machine!.combatPower) {
              tile.machine?.receiveAttack(attack);
            } else {
              col.machine?.receiveAttack(attack);
            }

            if (tile.machine?.dead ?? false) {
              tile.unsetMachine();
              _reset();
            }
            if (col.machine?.dead ?? false) {
              col.unsetMachine();
              _attackRange(tile);
              _reachablePieces(tile);
            }
          }
        }
      }
      _callUpdateCursor();
      _callUpdateTiles();
    } else if (key == LogicalKeyboardKey.keyQ && tile != null) {
      if (tile.hasMachine) {
        tile.machine!.updateDirection(tile.machine!.direction.previous());
        tile.updateMachine();
      }
      _attackRange(tile);
      _callUpdateCursor();
      _callUpdateTiles();
    } else if (key == LogicalKeyboardKey.keyE && tile != null) {
      if (tile.hasMachine) {
        tile.machine!.updateDirection(tile.machine!.direction.next());
        tile.updateMachine();
      }
      _attackRange(tile);
      _callUpdateCursor();
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
        if (col.machine == selectedTile.machine) {
          continue;
        }
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

  void _attackRange(Tile selectedTile) {
    _resetAttackRange();
    final position = selectedTile.position;
    final attackRange = selectedTile.machine?.attackRange ?? 0;
    final direction = selectedTile.machine?.direction ?? Direction.north;
    final player = selectedTile.machine?.player ?? Player.one;

    if (direction == Direction.north) {
      for (var row = 0; row < position.row; row++) {
        if ((position.row - row).abs() <= attackRange) {
          final tileMachine = tiles[row][position.col].machine;

          if (tileMachine != null && tileMachine.player != player) {
            tiles[row][position.col].updateInAttackRange(true);
          }
        }
      }
    } else if (direction == Direction.south) {
      for (var row = (tiles.length - 1); row > position.row; row--) {
        if ((position.row - row).abs() <= attackRange) {
          final tileMachine = tiles[row][position.col].machine;

          if (tileMachine != null && tileMachine.player != player) {
            tiles[row][position.col].updateInAttackRange(true);
          }
        }
      }
    } else if (direction == Direction.east) {
      for (var col = (tiles.length - 1); col > position.col; col--) {
        if ((position.col - col).abs() <= attackRange) {
          final tileMachine = tiles[position.row][col].machine;

          if (tileMachine != null && tileMachine.player != player) {
            tiles[position.row][col].updateInAttackRange(true);
          }
        }
      }
    } else if (direction == Direction.west) {
      for (var col = 0; col < position.col; col++) {
        if ((position.col - col).abs() <= attackRange) {
          final tileMachine = tiles[position.row][col].machine;

          if (tileMachine != null && tileMachine.player != player) {
            tiles[position.row][col].updateInAttackRange(true);
          }
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
        col.updateInAttackRange(false);
      }
    }
  }

  void _resetAttackRange() {
    for (var row in tiles) {
      for (var col in row) {
        col.updateInAttackRange(false);
      }
    }
  }
}
