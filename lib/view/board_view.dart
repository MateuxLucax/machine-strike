import 'package:flutter/material.dart';

import '../controller/board_controller.dart';
import '../design_patterns/decorator/tile/attack_tile_decorator.dart';
import '../design_patterns/decorator/tile/reachable_tile_decorator.dart';
import '../design_patterns/decorator/tile/select_tile_stack_decorator.dart';
import '../design_patterns/observer/cursor_observer.dart';
import '../design_patterns/observer/update_tiles_observer.dart';
import '../enum/reachability.dart';
import '../model/tile.dart';
import '../model/tile_position.dart';
import '../widget/tile_widget.dart';

class BoardView extends StatefulWidget {
  final IBoardController controller;
  const BoardView(
    this.controller, {
    super.key,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> implements CursorObserver, UpdateTilesObserver {
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
    widget.controller.attachCursorObserver(this);
    widget.controller.attachTilesObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding');
    List<Tile> tilesClone = [...tiles];
    tilesClone[cursorPosition] = tilesClone[cursorPosition].copyWith(
      tileStack: SelectTileStackDecorator(tilesClone[cursorPosition].tileStack),
    );

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
              padding: const EdgeInsets.all(0),
              itemCount: tiles.length,
              itemBuilder: (context, index) {
                var tile = TileWidget(tilesClone[index].tileStack);
                if (tilesClone[index].reachability == Reachability.reachable) {
                  tile = TileWidget(ReachableTileDecorator(tile.tileStack));
                }
                if (tilesClone[index].inAttackRange) {
                  tile = TileWidget(AttackTileDecorator(tile.tileStack));
                }

                return tile;
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void updateCursor(TilePosition cursor, Tile? terrain) {
    setState(() {
      cursorPosition = tiles.indexWhere((tile) => tile.position == cursor);
    });
  }

  @override
  void update(List<List<Tile>> tiles) {
    setState(() {
      this.tiles = _matrixToList(tiles);
    });
  }
}
