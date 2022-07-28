import 'package:flutter/services.dart';

import '../config/game_const.dart';
import '../design_patterns/command/command_invoker.dart';
import '../design_patterns/command/cursor/cursor_down_command.dart';
import '../design_patterns/command/cursor/cursor_left_command.dart';
import '../design_patterns/command/cursor/cursor_right_command.dart';
import '../design_patterns/command/cursor/cursor_up_command.dart';
import '../design_patterns/observer/events/cursor_event.dart';
import '../design_patterns/observer/events/game_event.dart';
import '../design_patterns/observer/events/tiles_event.dart';
import '../design_patterns/observer/observer.dart';
import '../design_patterns/observer/observer_event.dart';
import '../design_patterns/singleton/cursor.dart';
import '../design_patterns/state/game/game.dart';
import '../enum/direction.dart';
import '../enum/player.dart';
import '../enum/reachability.dart';
import '../model/board.dart';
import '../model/machine.dart';
import '../model/tile.dart';

abstract class IGameController {
  Tile get currentTile;

  List<List<Tile>> get tiles;

  Game get currentGame;

  void attach(Observer observer);

  void handleKeyStroke(RawKeyEvent event);

  Player get currentPlayer;
}

class GameController implements IGameController {
  Board board;
  final List<Observer> observers = [];
  final invoker = CommandInvoker();
  Tile? selectedTile;
  late Game game;

  GameController(this.board) {
    game = Game();
  }

  @override
  Tile get currentTile => board.tiles[Cursor().row][Cursor().col];

  @override
  List<List<Tile>> get tiles => board.tiles;

  @override
  Player get currentPlayer => game.player;

  @override
  Game get currentGame => game;

  @override
  void attach(Observer observer) {
    observers.add(observer);
  }

  @override
  void handleKeyStroke(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;
    final tile = selectedTile;

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.keyA) {
      invoker.execute(CursorLeftCommand());
      _callObservers([CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyD) {
      invoker.execute(CursorRightCommand());
      _callObservers([CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyS) {
      invoker.execute(CursorDownCommand());
      _callObservers([CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyW) {
      invoker.execute(CursorUpCommand());
      _callObservers([CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.escape) {
      _reset();
      _callObservers([CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.enter) {
      if (tile == null && currentTile.hasMachine && currentTile.machine!.player == game.player) {
        selectedTile = currentTile;
        _reachablePieces(currentTile);
        _attackRange(selectedTile!);
      } else if (tile != null &&
          !currentTile.hasMachine &&
          !(tile.machine?.alreadyMoved ?? false) &&
          (currentTile.reachability == Reachability.reachable)) {
        tile.machine?.updateAlreadyMoved(true);
        currentTile.addMachine(tile.machine!);
        board.tiles[tile.position.row][tile.position.col].unsetMachine();
        _reset();
      }
      _callObservers([TilesEvent(tiles), CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyT &&
        tile != null &&
        !(tile.machine?.alreadyAttacked ?? false)) {
      tile.machine?.updateAlreadyAttacked(true);
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
              if (enemyMachines.isEmpty) {
                game.updateVictoryPoints(GameConst.victoryPointsWin + 1);
                col.unsetMachine();
                _attackRange(tile);
                _reachablePieces(tile);
                _callObservers([GameEvent(game)]);
              } else {
                game.updateVictoryPoints(col.machine!.victoryPoints);
              }
              _attackRange(tile);
              _reachablePieces(tile);
              _callObservers([GameEvent(game)]);
            }
          }
        }
      }
      _callObservers([TilesEvent(tiles), CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyQ && tile != null) {
      if (tile.hasMachine) {
        tile.machine!.updateDirection(tile.machine!.direction.previous());
        tile.rotateMachine();
      }
      _attackRange(tile);
      _callObservers([TilesEvent(tiles), CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyE && tile != null) {
      if (tile.hasMachine) {
        tile.machine!.updateDirection(tile.machine!.direction.next());
        tile.rotateMachine();
      }
      _attackRange(tile);
      _callObservers([TilesEvent(tiles), CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyF) {
      for (var row in tiles) {
        for (var col in row) {
          final machine = col.machine;
          if (machine != null) {
            machine.updateAlreadyAttacked(false);
            machine.updateAlreadyMoved(false);
          }
          col.updateReachability(null);
          col.updateInAttackRange(false);
        }
      }
      invoker.clear();
      game.nextPlayer();
      _reset();
      _callObservers([GameEvent(game)]);
    } else if (key == LogicalKeyboardKey.keyZ) {
      invoker.undo();
      _callObservers([CursorEvent(currentTile)]);
    } else if (key == LogicalKeyboardKey.keyX) {
      invoker.redo();
      _callObservers([CursorEvent(currentTile)]);
    }
  }

  void _reachablePieces(Tile selectedTile) {
    if (!(selectedTile.machine?.alreadyMoved ?? true)) {
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
  }

  void _attackRange(Tile selectedTile) {
    _resetAttackRange();

    if (!(selectedTile.machine?.alreadyAttacked ?? true)) {
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
  }

  void _reset() {
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

  void _callObservers(List<ObserverEvent> events) {
    for (var observer in observers) {
      events.forEach(observer.update);
    }
  }

  List<Machine> _getMachinesByPlayer(Player player) {
    final List<Machine> machines = [];
    for (var row in tiles) {
      for (var col in row) {
        final machine = col.machine;
        if (machine != null) {
          if (machine.player == player) {
            machines.add(machine);
          }
        }
      }
    }

    return machines;
  }

  List<Machine> get enemyMachines => _getMachinesByPlayer(game.enemy);
}
