import 'package:flutter/services.dart';

import '../design_patterns/command/command_invoker.dart';
import '../design_patterns/command/cursor/cursor_down_command.dart';
import '../design_patterns/command/cursor/cursor_left_command.dart';
import '../design_patterns/command/cursor/cursor_right_command.dart';
import '../design_patterns/command/cursor/cursor_up_command.dart';
import '../design_patterns/command/game/attack_range_command.dart';
import '../design_patterns/command/game/rachable_pieces_command.dart';
import '../design_patterns/command/game/select_tile_command.dart';
import '../design_patterns/command/machine/attack_command.dart';
import '../design_patterns/command/machine/rotate_machine_command.dart';
import '../design_patterns/observer/events/cursor_event.dart';
import '../design_patterns/observer/events/game_event.dart';
import '../design_patterns/observer/events/tiles_event.dart';
import '../design_patterns/observer/observer.dart';
import '../design_patterns/observer/observer_event.dart';
import '../design_patterns/singleton/cursor.dart';
import '../design_patterns/state/game/game.dart';
import '../exceptions/game_finished_exception.dart';
import '../model/board.dart';
import '../model/tile.dart';
import 'igame_controller.dart';

class GameController implements IGameController {
  final List<Observer> observers = [];
  final invoker = CommandInvoker();
  late Game game;

  GameController(Board board) {
    game = Game(board);
  }

  @override
  Tile get cursorTile => game.board.tiles[Cursor().row][Cursor().col];

  @override
  List<List<Tile>> get tiles => game.board.tiles;

  @override
  Game get currentGame => game;

  @override
  void handleKeyStroke(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;
    final tile = game.selectedTile;

    final key = event.logicalKey;

    try {
      if (key == LogicalKeyboardKey.keyA) {
        invoker.execute(CursorLeftCommand());
      } else if (key == LogicalKeyboardKey.keyD) {
        invoker.execute(CursorRightCommand());
      } else if (key == LogicalKeyboardKey.keyS) {
        invoker.execute(CursorDownCommand());
      } else if (key == LogicalKeyboardKey.keyW) {
        invoker.execute(CursorUpCommand());
      } else if (key == LogicalKeyboardKey.escape) {
        game.reset();
      } else if (key == LogicalKeyboardKey.enter) {
        invoker.execute(SelectTileCommand(game, cursorTile));
        if (tile == null) {
          invoker.execute(AttackRangeCommand(game));
          invoker.execute(ReachablePiecesCommand(game));
        }
      } else if (key == LogicalKeyboardKey.keyT) {
        if (tile != null) {
          final machine = tile.machine;
          if (machine != null) {
            invoker.execute(AttackCommand(machine, game));
            invoker.execute(AttackRangeCommand(game));
          }
        }
      } else if (key == LogicalKeyboardKey.keyQ) {
        if (tile != null) {
          final machine = tile.machine;
          if (machine != null) {
            invoker.execute(RotateMachineCommand(machine, tile, false));
            invoker.execute(AttackRangeCommand(game));
          }
        }
      } else if (key == LogicalKeyboardKey.keyE) {
        if (tile != null) {
          final machine = tile.machine;
          if (machine != null) {
            invoker.execute(RotateMachineCommand(machine, tile, true));
            invoker.execute(AttackRangeCommand(game));
          }
        }
      } else if (key == LogicalKeyboardKey.keyF) {
        invoker.clear();
        game.nextPlayer();
      } else if (key == LogicalKeyboardKey.keyZ) {
        invoker.undo();
      } else if (key == LogicalKeyboardKey.keyX) {
        invoker.redo();
      }

      notifyObservers([TilesEvent(tiles), CursorEvent(cursorTile), GameEvent(game)]);
    } on GameFinishedException catch (_) {}
  }

  @override
  void attach(Observer observer) {
    observers.add(observer);
  }

  @override
  void notifyObservers(List<ObserverEvent> events) {
    for (var observer in observers) {
      events.forEach(observer.update);
    }
  }
}
