import 'package:flutter/services.dart';

import '../design_patterns/abstract_factory/imachine_factory.dart';
import '../design_patterns/observer/cursor/default_subscriber.dart';
import '../design_patterns/observer/cursor/subscribers/board_cursor_subscriber.dart';
import '../design_patterns/observer/cursor/subscribers/machine_subscriber.dart';
import '../design_patterns/observer/cursor/subscribers/terrain_subscriber.dart';
import '../model/board.dart';
import '../model/terrain.dart';
import '../model/tile_position.dart';
import '../widget/tile_widget.dart';

class BoardController {
  final Board board;
  final List<TileWidget> tileWidgets = [];
  TilePosition cursorPosition = TilePosition(0, 0);
  DefaultSubscriber<TilePosition> cursorSubscriber = BoardCursorSubscriber(0, 0);
  DefaultSubscriber<IMachineFactory> selectedMachineSubscriber = MachineSubscriber();
  DefaultSubscriber<Terrain> currentTerrainSubscriber = TerrainSubscriber();

  BoardController(this.board) {
    for (var row in board.tiles) {
      for (var column in row) {
        tileWidgets.add(TileWidget(
          tile: column,
          tileStack: column.tileStack,
        ));
      }
    }
  }

  int indexFromPosition(TilePosition position) {
    return tileWidgets.indexWhere((widget) => widget.tile.position == position);
  }

  int get cursorPositionIndex => tileWidgets.indexWhere(
        (widget) => widget.tile.position == cursorPosition,
      );

  TileWidget get currentTileWidget => tileWidgets[cursorPositionIndex];

  void handleKeyStroke(RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return;

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.keyA || key == LogicalKeyboardKey.arrowLeft) {
      cursorPosition.move(y: -1);
    } else if (key == LogicalKeyboardKey.keyD || key == LogicalKeyboardKey.arrowRight) {
      cursorPosition.move(y: 1);
    } else if (key == LogicalKeyboardKey.keyS || key == LogicalKeyboardKey.arrowDown) {
      cursorPosition.move(x: 1);
    } else if (key == LogicalKeyboardKey.keyW || key == LogicalKeyboardKey.arrowUp) {
      cursorPosition.move(x: -1);
    } else if (key == LogicalKeyboardKey.enter && tileWidgets[cursorPositionIndex].hasMachine) {
      print(tileWidgets[cursorPositionIndex].tile.machine?.getPlayer());
    }

    cursorSubscriber.update(cursorPosition);
    currentTerrainSubscriber.update(board.getByPosition(cursorPosition).terrain);

    if (tileWidgets[cursorPositionIndex].hasMachine) {
      final machine = tileWidgets[cursorPositionIndex].tile.machine;
      if (machine != null) selectedMachineSubscriber.update(machine);
    }
  }
}
