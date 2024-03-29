import 'package:flutter/material.dart';
import 'package:machinestrike/design_patterns/decorator/tile/selected_tile_decorator.dart';

import '../controller/igame_controller.dart';
import '../design_patterns/decorator/tile/attack_tile_decorator.dart';
import '../design_patterns/decorator/tile/reachable_tile_decorator.dart';
import '../design_patterns/decorator/tile/select_tile_stack_decorator.dart';
import '../design_patterns/observer/events/cursor_event.dart';
import '../design_patterns/observer/events/tiles_event.dart';
import '../design_patterns/observer/observer.dart';
import '../design_patterns/observer/observer_event.dart';
import '../design_patterns/singleton/cursor.dart';
import '../model/tile.dart';
import '../widget/tile_widget.dart';

class BoardView extends StatefulWidget {
  final IGameController controller;
  const BoardView(
    this.controller, {
    super.key,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> implements Observer {
  List<Tile> tiles = [];
  int cursorPosition = 0;

  List<Tile> _matrixToList(List<List<Tile>> tiles) {
    List<Tile> newTiles = [];
    for (var row in tiles) {
      for (var column in row) {
        newTiles.add(column);
      }
    }

    return newTiles;
  }

  @override
  void initState() {
    super.initState();
    tiles = _matrixToList(widget.controller.tiles);
    widget.controller.attach(this);
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: widget.controller.handleKeyStroke,
      child: SizedBox(
        width: 64 * 8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black, width: 4),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                final tile = tiles[index];
                var tileWidget = TileWidget(tile.tileStack);

                if (tile.reachable) {
                  tileWidget = TileWidget(ReachableTileDecorator(tileWidget.tileStack));
                }
                if (tile.inAttackRange) {
                  tileWidget = TileWidget(AttackTileDecorator(tileWidget.tileStack));
                }
                final selectedTile = widget.controller.currentGame.selectedTile;
                if (selectedTile != null) {
                  if (tile.position == selectedTile.position) {
                    tileWidget = TileWidget(SelectedTileDecorator(tileWidget.tileStack));
                  }
                }
                if (index == cursorPosition) {
                  tileWidget = TileWidget(SelectTileStackDecorator((tileWidget.tileStack)));
                }

                return tileWidget;
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void update(ObserverEvent event) {
    if (event is CursorEvent) {
      setState(() {
        cursorPosition = tiles.indexWhere((tile) => tile.position == Cursor().position);
      });
    } else if (event is TilesEvent) {
      setState(() {
        tiles = _matrixToList(event.tiles);
      });
    }
  }
}
